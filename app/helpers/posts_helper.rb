module PostsHelper
  def post_styled_badge(status)
    badge_class =
      case status
      when 'draft'
        'badge bg-secondary'

      when 'scheduled'
        'badge bg-info text-dark'

      when 'on_moderation'
        'badge bg-warning text-dark'

      when 'published'
        'badge bg-success'

      when 'canceled'
        'badge bg-danger'

      else
        'badge bg-primary'

      end
    content_tag(:span, status, class: badge_class)

  end

  def post_styled_date(current_date)
    current_date&.strftime("%Y-%m-%d %H:%M")
  end

end
