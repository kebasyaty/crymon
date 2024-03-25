require "i18n"
require "dynfork"
require "./models/*"

module Basic
  VERSION = "0.1.0"

  # Initialize locale.
  I18n.config.loaders << I18n::Loader::YAML.new("config/locales")
  I18n.config.default_locale = :en
  I18n.init

  # Run migration.
  DynFork::Migration::Monitor.new(
    "app_name": "AppName",
    "unique_app_key": "924992B27o5zf40f",
    "mongo_uri": "mongodb://localhost:27017",
    "model_list": {
      Models::Accounts::User,
    }
  ).migrat

  # Create a user.
  user = Models::Accounts::User.new
  # Add user details.
  user.username.value = "username"
  user.email.value = "user@noreaply.net"
  user.birthday.value = "2023-03-25"
  # Save user (print_err - convenient for development).
  user.print_err unless user.save?
  # Print field values.
  puts "\n# New user details:"
  puts "username: #{user.username.value?}"
  puts "email: #{user.email.value?}"
  puts "birthday: #{user.birthday.value?}"

  # Update user data.
  user.username.value = "username_2"
  user.email.value = "user_2@noreaply.net"
  user.birthday.value = "2024-04-26"
  # update
  user.print_err unless user.save?
  # print
  puts "\n# Updated user information:"
  puts "username: #{user.username.value?}"
  puts "email: #{user.email.value?}"
  puts "birthday: #{user.birthday.value?}"
  puts
end
