countries = {
  'Georgia': %w[Tbilisi Batumi Rustavi Kutaisi],
  'Ukraine': %w[Kiev Kharkiv],
  'Germany': %w[Berlin Hamburg Bavaria]
}

countries.each do |country_name, cities|
  country = Country.create(name: country_name)

  cities.each do |city|
    country.cities << City.new(name: city)
  end

  country.save
end
