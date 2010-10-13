# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

miehet = Section.create :name => 'Miehet', :slug => 'miehet'
Section.create :name => 'Edustus', :slug => 'miehet-edustus', :parent => miehet
Section.create :name => 'Miehet II', :slug => 'miehet-kakkonen', :parent => miehet
Section.create :name => 'Miehet III', :slug => 'miehet-kolmonen', :parent => miehet

