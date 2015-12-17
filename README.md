# FrancisCMS

An [IndieWeb](http://indiewebcamp.com/)-friendly content management system built with [Ruby on Rails](http://rubyonrails.org).

[![Build Status](https://travis-ci.org/jgarber623/FrancisCMS.svg?branch=master)](https://travis-ci.org/jgarber623/FrancisCMS)
[![Code Climate](https://codeclimate.com/github/jgarber623/FrancisCMS/badges/gpa.svg)](https://codeclimate.com/github/jgarber623/FrancisCMS)
[![Test Coverage](https://codeclimate.com/github/jgarber623/FrancisCMS/badges/coverage.svg)](https://codeclimate.com/github/jgarber623/FrancisCMS/coverage)


## Installation


## Usage


## Testing

The bulk of the test suite can be run using `rspec spec` (aliased to the default `rake` task).

### Running Smoke Tests

1. `cd spec/dummy`
1. `bin/rake db:migrate db:test:prepare`
1. `RAILS_ENV=test bin/rails s`
1. In a different tab and inside `spec/dummy`, `rspec spec`