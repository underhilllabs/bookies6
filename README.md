# Rails Version
6.0

# Install the application locally

## run bundle
`bundle install`

## create a credentials file

Rails 6 creates a credentials file for each environment

`EDITOR=vim rails credentials:edit -e development`

- add the database credentials
  - DEV_DB
  - DEV_DB_USER
  - DEV_DB_PASSWORD

## load database schema

`rails db:schema:load`

## run rails server

`rails server`

# Run tests

`bundle exec rspec`


