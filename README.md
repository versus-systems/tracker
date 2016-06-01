# Software Development Sample Project

This is a sample project used by applicants interested in a career at Versus Systems.

## Context

At Versus Systems a portion of our platform is currently built on a similar stack. Using this semi-real-world application helps us to determine how you interact with a code base to add a feature.

This application is very incomplete and as such has plenty of room for you to add a feature.

## Setup

### Software

* Ruby 2.3
* Postgres >= 9.3

### Enviroment Setup

This project uses bundler so that may well be good enough for you. In addition you may want to create a gemset to further sandbox your environment.

* `bundle install`

### Database Setup

* `bundle exec rake db:create`
* `bundle exec rake db:migrate`

### Running Tests

* `bundle exec rake spec` - Run the RSpec tests
* `bin/cuc_all` - Run all cucumber features
* `bin/cuc_domain` - Run just the domain level cucumber features
* `bin/cuc_api` - Run just the API level cucumber features

### Interacting with the system

* `bundle exec rails server` - Run the rails server itself
* `bundle exec rails console` - Run the rails console

## What's Expected

As a general rule you should use idiomatic Ruby and Rails. It should be evident where the project has diverged and you should attempt to follow the conventions of the project.

You should feel free to add any gems, libraries, or tools you feel are necessary to complete the feature you have been asked to add.

You should feel proud of your solution and confident the feature is a good addition to the code base.
