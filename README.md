# FrancisCMS

An [IndieWeb](http://indiewebcamp.com/)-friendly content management system built with [Ruby on Rails](http://rubyonrails.org).


## Installation

1. `bundle`
1. `cp config/database.yml{.example,}`
1. `cp config/secrets.yml{.example,}`
1. `rake db:create`
1. `rake db:migrate`
1. `rails server`


## Testing

### Running Smoke Tests

1. `RAILS_ENV=test rails s`
1. `rspec spec`

