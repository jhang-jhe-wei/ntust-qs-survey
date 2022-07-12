# frozen_string_literal: true

# Add all Institutions to database.
Institution.find_or_create_by(name: 'National Taiwan University of Science and Technology', country_id: Country.find_by(name: 'Taiwan, Province of China').id)
