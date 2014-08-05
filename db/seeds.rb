# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create(name: 'Companies', entries: 110430)
Category.create(name: 'People', entries: 12530)
Category.create(name: 'Investment Firms', entries: 1330)
Category.create(name: 'Incubators', entries: 430)
Category.create(name: 'Funding Events', entries: 225)
Category.create(name: 'News', entries: 2250003)
