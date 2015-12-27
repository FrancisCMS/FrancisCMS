# FrancisCMS

An [IndieWeb](http://indiewebcamp.com/)-friendly content management system built with [Ruby on Rails](http://rubyonrails.org/).

[![Build Status](https://travis-ci.org/jgarber623/FrancisCMS.svg?branch=master)](https://travis-ci.org/jgarber623/FrancisCMS)
[![Code Climate](https://codeclimate.com/github/jgarber623/FrancisCMS/badges/gpa.svg)](https://codeclimate.com/github/jgarber623/FrancisCMS)
[![Test Coverage](https://codeclimate.com/github/jgarber623/FrancisCMS/badges/coverage.svg)](https://codeclimate.com/github/jgarber623/FrancisCMS/coverage)

FrancisCMS began life in October 2014 as a [Sinatra](http://www.sinatrarb.com/) application (hence [the name](https://en.wikipedia.org/wiki/Frank_Sinatra)) before becoming a Rails application before becoming a mountable [Rails engine](http://guides.rubyonrails.org/engines.html). As it stands, FrancisCMS is a white label Rails engine meant to be included in an existing Rails application at a particular mount point (`/blog`, for instance). Your host Rails application is responsible for providing styling with CSS and behavior with JavaScript. FrancisCMS exposes a number of useful methods, helpers, and configuration variables available for use in the host Rails application.


## Features

- Supports multiple content types (posts, links, and photos) with drafts, tags, and RSS feeds
- Receives and verifies [webmentions](http://indiewebcamp.com/Webmention), displaying verified webmentions on content pages
- Inherits styling (CSS) and scripting (JavaScript) from the parent Rails application
- Delegates authentication to the parent Rails application


## Installation


## Usage


## Developing


### Contributing


### Testing


## Acknowledgements

Most of this wouldn't have been possible without [Tony Pitale](http://tpitale.com/)'s mentorship, encouragement, and patience. Thanks, buddy!

The default user avatar image (`app/assets/images/avatar.png`) was derived from [Brent Jackson](http://jxnblk.com/)'s [Geomicons Open](https://github.com/jxnblk/geomicons-open) icon set.

FrancisCMS is written and maintained by [Jason Garber](http://sixtwothree.org/).

## License

FrancisCMS is freely available under the [MIT License](http://opensource.org/licenses/MIT). Use it, learn from it, fork it, improve it, change it, tailor it to your needs.