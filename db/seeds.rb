# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:  "admin",
             email: "admin@admin.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: true,
             activated: true)
User.create!(name:  "test",
             email: "test@test.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: false,
             activated: true)
User.create!(name:  "test2",
             email: "test2@test.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: false,
             activated: true)
User.create!(name:  "test3",
             email: "test3@test.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: false,
             activated: true)
User.create!(name:  "unactivated",
             email: "unactivated@test.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: false,
             activated: false)
User.create!(name:  "unactivated2",
             email: "unactivated2@test.com",
             password:              "123456",
             password_confirmation: "123456",
             admin: false,
             activated: false)








