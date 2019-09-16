# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: 'First', email: 'firstuser@email.com', birth_day: Date.current, password: 'rootroot', password_confirmation: 'rootroot')
User.create(name: 'Second', email: 'seconduser@email.com', birth_day: Date.current, password: 'rootroot', password_confirmation: 'rootroot')
