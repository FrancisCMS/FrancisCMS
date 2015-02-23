# FrancisCMS

An [IndieWeb](http://indiewebcamp.com/)-friendly content management system built with [Ruby on Rails](http://rubyonrails.org).


## Installation


## Usage


## Testing

The bulk of the test suite can be run using `rspec spec` (aliased to the default `rake` task).

### Running Smoke Tests

1. `cd spec/dummy`
1. `bin/rake db:migrate db:test:prepare`
1. `RAILS_ENV=test bin/rails s`
1. In a different tab and inside `spec/dummy`, `rspec spec`