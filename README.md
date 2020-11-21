# Rails Version
6.0

# Install the application locally

## create a credentials file

Rails 6 creates a credentials file for each environment

`EDITOR=vim rails credentials:edit -e development`

- add the database credentials
 - dev_db
 - dev_db_user
 - dev_db_password

## load database schema

`rails db:schema:load`

## run rails server

`rails server`

# Run tests

`bundle exec rspec`


