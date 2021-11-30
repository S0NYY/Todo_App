class City < ApplicationRecord
  belongs_to :country

  scope :country_id, -> (country_id) { where(country_id: country_id ) }
end
