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

Sector.create(name: 'E-Commerce', entries: 1349)
Sector.create(name: 'Pharmaceutical', entries: 149)
Sector.create(name: 'Transportation', entries: 235)
Sector.create(name: 'Bio-Tech', entries: 35)
Sector.create(name: 'Manufacturing', entries: 10035)
Sector.create(name: 'Agricultural', entries: 135)
Sector.create(name: 'Fertilizers', entries: 235)
Sector.create(name: 'Software', entries: 13599)

Company.create(name: 'Upelite', thumbnail: 'http://www.grapelinemedia.com/img/companies1.jpeg')
Company.create(name: 'Roaming Treasure', thumbnail: 'http://www.grapelinemedia.com/img/companies2.jpeg')
Company.create(name: 'Surrounds', thumbnail: 'http://www.grapelinemedia.com/img/companies3.jpeg')
Company.create(name: 'China HR', thumbnail: 'http://www.grapelinemedia.com/img/companies4.jpeg')
