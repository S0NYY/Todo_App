class User < ApplicationRecord
  has_one :profile, dependent: :destroy

  belongs_to :city
  belongs_to :country

  validates :email, :username, presence: true
  validates :pin, length: { is: 11 }, presence: true, uniqueness: true




end
