# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

unless Country.count > 1
  connection = ActiveRecord::Base.connection
  # connection.tables.each do |table|
  #   connection.execute("TRUNCATE #{table}") unless table == "schema_migrations"
  # end

  sql = File.read('db/countries.sql')
  statements = sql.split(/;$/)
  statements.pop

  ActiveRecord::Base.transaction do
    statements.each do |statement|
      connection.execute(statement)
    end
  end
end

Country.all.each do |country|
  state_data = []
  CS.states(country.iso).each do |sts|
    state_data << { iso: sts.first, name: sts.last, country_id: country.id }
  end

  State.create!(state_data)

  State.all.each do |state|
    city_data = []
    CS.cities(state.iso, country.iso)&.each do |city|
      city_data << { name: city, state_id: state.id }
    end

    City.create!(city_data)
  end
end
#end
