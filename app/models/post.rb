class Post < ApplicationRecord
  include AASM

  aasm :column => 'status_state', whiny_persistence: true do
    state :draft, initial: true
    state :scheduled, :on_moderation, :published, :canceled

    event :process_scheduled do
      transitions from: :draft, to: :scheduled, after: Proc.new { |*args| set_scheduled_at(*args) }
    end

    event :process_on_moderation do
      transitions from: [:draft, :scheduled], to: :on_moderation
    end

    event :mark_as_draft do
      transitions from: [:scheduled, :published, :canceled], to: :draft, after: :clear_excess_attributes
    end

    event :mark_as_published do
      transitions from: :on_moderation, to: :published, after: Proc.new { |*args| set_published_at(*args) }
    end

    event :mark_as_canceled do
      transitions from: :on_moderation, to: :canceled, after: Proc.new { |*args| set_cancellation_reason(*args) }
    end
  end

  def set_scheduled_at(current_datetime)
    self.scheduled_at = current_datetime
  end

  def set_published_at(moderator)
    self.moderator_id = moderator.id
    self.published_at = Time.now
    self.scheduled_at = nil
  end

  def set_cancellation_reason(moderator, reason)
    self.moderator_id = moderator.id
    self.cancellation_reason = reason
    self.scheduled_at = nil
  end

  def clear_excess_attributes
    self.moderator_id = nil
    self.published_at = nil
    self.scheduled_at = nil
    self.cancellation_reason = nil
  end

  belongs_to :user
  belongs_to :moderator, class_name: 'User', foreign_key: :moderator_id, required: false

  #scheduled_at validation
  validates :scheduled_at, presence: true, if: Proc.new { self.scheduled? }

  #scheduled_at & datetime validation gem 'validates_timeliness', '~> 6.0.0.beta2'
  validates_date :scheduled_at, on: :create, on_or_after: :today, if: Proc.new { self.scheduled? }

  #cancellation_reason validation
  validates :cancellation_reason, presence: true, if: Proc.new { self.canceled? }

end
