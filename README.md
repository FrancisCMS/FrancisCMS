# FrancisCMS

An [IndieWeb](https://indiewebcamp.com/)-friendly content management system built with [Ruby on Rails](http://rubyonrails.org/).

[![Build](https://img.shields.io/travis/com/FrancisCMS/FrancisCMS/master.svg?style=for-the-badge)](https://travis-ci.com/FrancisCMS/FrancisCMS)
[![Maintainability](https://img.shields.io/codeclimate/maintainability/FrancisCMS/FrancisCMS.svg?style=for-the-badge)](https://codeclimate.com/github/FrancisCMS/FrancisCMS)
[![Coverage](https://img.shields.io/codeclimate/c/FrancisCMS/FrancisCMS.svg?style=for-the-badge)](https://codeclimate.com/github/FrancisCMS/FrancisCMS/code)

FrancisCMS began life in October 2014 as a [Sinatra](http://www.sinatrarb.com/) application (hence [the name](https://en.wikipedia.org/wiki/Frank_Sinatra)) before becoming a Rails application before becoming a mountable [Rails engine](http://guides.rubyonrails.org/engines.html).

At present, FrancisCMS is a white label Rails engine meant to be included in an existing Rails application at a particular mount point (`/`, for instance). FrancisCMS provides models, controllers, and views for [CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)-ing supported content types. Your host Rails application is responsible for providing a user authentication system, styles with CSS, and behavior with JavaScript. FrancisCMS also exposes a number of useful methods, helpers, and configuration variables available for use in the host Rails application.

## Features

- Supports multiple content types ([posts](https://indiewebcamp.com/posts), [links](https://indiewebcamp.com/links), and [photos](https://indiewebcamp.com/photos)) with [drafts](https://indiewebcamp.com/drafts), [tags](https://indiewebcamp.com/tags), and [RSS](https://indiewebcamp.com/RSS) feeds.
- Supports syndicating content types to several third-party [silos](https://indiewebcamp.com/silo).
- Receives and verifies [webmentions](https://indiewebcamp.com/Webmention), displaying verified webmentions on content pages.
- Provides alternative representations of content types as [Markdown](https://indiewebcamp.com/Markdown) and [jf2](https://indiewebcamp.com/jf2)-formatted [JSON](https://indiewebcamp.com/JSON).
- Inherits styling (CSS) and scripting (JavaScript) from the host Rails application.
- Delegates authentication to the host Rails application.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
	- [From The Ground Up](#from-the-ground-up)
	- [Configuration](#configuration)
	- [Authentication](#authentication)
	- [Routes](#routes)
	- [RSS Feeds](#rss-feeds)
	- [Extending Controllers](#extending-controllers)
	- [Internationalization](#internationalization)
- [Content Types](#content-types)
	- [Posts](#posts)
	- [Links](#links)
	- [Photos](#photos)
- [Syndicating Content](#syndicating-content)
	- [Flickr](#flickr)
	- [Medium](#medium)
	- [Twitter](#twitter)
	- [Manual Syndication](#manual-syndication)
- [Theming](#theming)
	- [Markup Conventions](#markup-conventions)
- [Improving FrancisCMS](#improving-franciscms)
	- [Contributing](#contributing)
	- [Testing](#testing)
	- [Donations](#donations)
- [Acknowledgments](#acknowledgments)
- [License](#license)

## Prerequisites

I manage Ruby versions with [rbenv](https://github.com/rbenv/rbenv). I'd recommend you do the same or use a similar Ruby version manager ([chruby](https://github.com/postmodern/chruby/) or [RVM](https://rvm.io/) come to mind). Also, if you're using Mac OS X, [Homebrew](http://brew.sh/) makes installing command line utilities incredibly easy. The following instructions assume you'll use rbenv and Homebrew but you're totally free to install things as you like.

### Software Dependencies

- [Ruby](https://www.ruby-lang.org/) 2.4.9 (`rbenv install 2.4.9`)
- [Bundler](http://bundler.io/) (`gem install bundler`)
- [PostgreSQL](http://www.postgresql.org/) (`brew install postgresql`)
- [ImageMagick](http://www.imagemagick.org/) (`brew install imagemagick`)

### General Knowledge

I'll do my best to keep this documentation digestible and will avoid making assumptions about your skill level or depth of knowledge about Ruby, Rails, and any technology used in FrancisCMS. I highly recommend though that you familiarize yourself with Ruby on Rails, the framework upon which FrancisCMS is built. [The official Ruby on Rails Guides](http://guides.rubyonrails.org/) are a great resource and worth a read.

## Installation

Include the FrancisCMS engine in your project's Gemfile:

```rb
gem 'francis_cms', git: 'https://github.com/FrancisCMS/FrancisCMS.git'
```

Run `bundle install` to install FrancisCMS and its dependencies.

### Sample Gemfile

```rb
ruby '2.4.9'

source 'https://rubygems.org' do
  gem 'rails', '~> 4.2'
  gem 'francis_cms', git: 'https://github.com/FrancisCMS/FrancisCMS.git'
end
```

## Usage

As mentioned above, FrancisCMS is a mountable [Rails engine](http://guides.rubyonrails.org/engines.html) meant for inclusion in a host application. Rails engines are structurally similar to a typical Rails application, but how the host application and engine interact with one another is unique. In this section, we'll build a basic Rails application that mounts FrancisCMS and will detail many of the ways in which it interacts with the host application.

### From The Ground Up

1. `mkdir example.com && cd example.com`
1. `rbenv local 2.4.9`
1. Create a `Gemfile` in the root of the project and, in your editor of choice, add the contents from the [Sample Gemfile section](#sample-gemfile) above.
1. `bundle install`
1. `bundle exec rails new . --database=postgresql --skip-gemfile --skip-spring --skip-javascript --skip-turbolinks --skip-test-unit`
1. Edit `config/database.yml` to match your PostgreSQL configuration and start your local PostgreSQL server.
1. `bundle exec rake db:create && bundle exec rake db:migrate`
1. Create a static pages controller: `bundle exec rails generate controller pages homepage --skip-routes --no-helper --no-assets`.
1. In `config/routes.rb`, add `root 'pages#homepage'`.
1. Also in `config/routes.rb`, add `mount FrancisCms::Engine, at: '/'`, replacing `at: '/'` with the path at which you wish to mount FrancisCMS.
1. In `app/controllers/application_controller.rb`, create a `logged_in?` method (see [Authentication](#authentication) below).
1. `bundle exec rails server -b 0.0.0.0`
1. Point your favorite browser at `http://localhost:3000`.

You should now have a templated homepage (source file at `app/views/pages/homepage.html.erb`) and you should be able to navigate directly to FrancisCMS' content listing pages (assuming FrancisCMS is mounted at `/`):

- `http://localhost:3000/links`
- `http://localhost:3000/photos`
- `http://localhost:3000/posts`
- `http://localhost:3000/webmentions`

See the [Routes section](#routes) below for more on how to create navigational links to these pages in your site's layout.

### Configuration

FrancisCMS has a number of configuration options that you can set in your application by creating an initializer file called `config/initializers/francis_cms.rb`. This file might look something like:

```rb
Rails.application.config.tap do |config|
  config.francis_cms.logged_in_method = :logged_in?
  config.francis_cms.login_path       = '/login' # path may be relative or absolute

  config.francis_cms.site_url         = 'http://example.com/' # `site_url` must include protocol and trailing slash
  config.francis_cms.site_title       = 'FrancisCMS Demo Site'
  config.francis_cms.site_description = 'This is the default site description for a new FrancisCMS-powered website.'
  config.francis_cms.site_language    = 'en-US'

  config.francis_cms.user_name        = 'Jane Doe'
  config.francis_cms.user_email       = 'jane@example.com'
  config.francis_cms.user_avatar      = 'http://www.placecage.com/180/180' # path may be relative or absolute

  config.francis_cms.license_title    = 'Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International'
  config.francis_cms.license_url      = 'http://creativecommons.org/licenses/by-nc-sa/4.0/'
end
```

The values above are the default configuration options. You will only want to include the options you wish to override in your `francis_cms.rb` initializer. In your host Rails application, you can access these values with `francis_cms_config.foo` (where `foo` is replaced with `site_url`, `site_title`, etc.).

### Authentication

FrancisCMS does not include an authentication system, preferring instead to delegate authentication to your host Rails application. In keeping with the IndieWeb ethos, my preference is to use a service like [IndieAuth](https://indieauth.com/), but I didn't want to force that decision on anyone interested in using FrancisCMS. Your application may have different needs so you should choose an authentication system that best suits those needs.

Regardless of which system you choose, you'll need to let FrancisCMS know about it. In the [Configuration section](#configuration) above, you'll see settings for `logged_in_method` and `login_path`. The former is the method that FrancisCMS will delegate to when it needs to determine a user's authentication state and the latter is the URL to which a user should be redirected when not logged in.

In `app/controllers/application_controller.rb`, create a `logged_in?` method and expose it with `helper_method`:

```rb
def logged_in?
  # Your application-specific authentication logic would go here.
  # This method should return a boolean `true` or `false`.
end
helper_method :logged_in?
```

The name of this method (and its exposed helper) should match the method name set in your configuration (if you chose to override the default). You can now use conditional logic like `if logged_in?` in your application's controllers and views. Any actions or views controlled by FrancisCMS will delegate to this method and respond accordingly.

#### Displaying the Admin Panel

FrancisCMS provides a basic "panel" of admin-related markup that you can include in your pages. It's best to include this in your application's layout file using the following bit of code:

```erb
<%= francis_cms_admin_panel if logged_in? %>
```

This helper method will generate markup similar to:

```html
<div class="admin-panel">
    <menu class="global">
        <li><a href="/posts/new">New post</a></li>
        <li><a href="/links/new">New link</a></li>
        <li><a href="/photos/new">New photo</a></li>
    </menu>
</div>
```

### Routes

FrancisCMS uses standards Rails-y resource-based routing so generating URLs in views should be familiar. The primary difference, though, is a required `francis_cms.` prefix when using route helpers. For instance:

```erb
<%= link_to 'Posts', francis_cms.posts_path %>
```

The above ERB will generate the following markup (assuming a FrancisCMS is mounted at `/`):

```html
<a href="/posts">Posts</a>
```

For a full list of available routes, run `bundle exec rake routes` from the root of your application.

### RSS Feeds

FrancisCMS makes available RSS feeds for all content types (posts, links, photos, and webmentions). These URLs can be generated using ERB like:

```erb
<%= link_to 'Posts RSS feed', francis_cms.posts_path(format: :rss) %>
```

You can also use Rails' [`auto_discovery_link_tag`](http://api.rubyonrails.org/classes/ActionView/Helpers/AssetTagHelper.html#method-i-auto_discovery_link_tag) helper to generate `<link>` elements in the `<head>` of your application's layout:

```erb
<%= auto_discovery_link_tag :rss, francis_cms.posts_path(format: :rss), title: %{#{francis_cms_config.site_title}: Posts} %>
```

### Extending Controllers

You may find that your application would benefit by extending FrancisCMS' existing controllers and routing. The reasons for this and the complexity required will vary, of course, but a basic example might look like:

In `app/controllers/links_controller.rb`:

```rb
class LinksController < ApplicationController
  def fetch_json
    render json: { title: 'Sample Link Title', url: 'http://example.com/foo/bar' }
  end
end
```

And in `config/routes.rb`:

```rb
post 'links/fetch_json', to: 'links#fetch_json'
```

The above example would add a route (`/links/fetch_json`) that responds to `POST` requests and a controller action that returns a block of [JSON](http://json.org/). Extending FrancisCMS' functionality in your application can be helpful, but proceed with caution.

### Internationalization

FrancisCMS takes advantage of the [Rails Internationalization API](http://guides.rubyonrails.org/i18n.html). Internationalization support is incomplete, but some strings are easily translatable. Default values are set in `config/locales/en.yml` and may be overridden in your host Rails application by adding the appropriate language files to `config/locales`. See [the official documentation](http://guides.rubyonrails.org/i18n.html) for more on this topic.

## Content Types

FrancisCMS currently supports three primary content types: posts, links, and photos. All content types support receiving and displaying webmentions and provide alternative representations as [Markdown](http://daringfireball.net/projects/markdown/) and [JSON](http://json.org/).

### Posts

Posts are textual content of any length and map to the general IndieWeb [post](https://indiewebcamp.com/posts) construct. FrancisCMS doesn't currently distinguish between [articles](https://indiewebcamp.com/article) (akin to blog posts) and [notes](https://indiewebcamp.com/note) (akin to tweets). This may change in the future, though.

A post has the following attributes:

- Title _(required)_
- URL slug (e.g. `an-example-post-url`) _(required)_
- Body (Markdown-formatted) _(required)_
- Excerpt
- Tags
- Save as draft

### Links

Links are a type of post consisting primarily of a URL to a third-party website and map to the IndieWeb [bookmark](https://indiewebcamp.com/bookmark) construct.

A link has the following attributes:

- URL _(required)_
- Title _(required)_
- Body (Markdown-formatted)
- Tags
- Save as draft

### Photos

Photos are a type of post consisting primarily of a photograph or image and map to the IndieWeb [photo](https://indiewebcamp.com/photo) construct.

A photo has the following attributes:

- Photo (an image file of type GIF, JPG, or PNG) _(required)_
- Body (Markdown-formatted)
- Tags
- Save as draft

Photos also have a `title` virtual attribute (e.g. `@photo.title`) that will return the first line from the photo's body attribute or `Untitled`.

Photos are uploaded using [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) and processed with [MiniMagick](https://github.com/minimagick/minimagick) and [ImageMagick](http://www.imagemagick.org/). Photos are converted to JPG and resized with the longest side being no greater than 500px, 750px, and 1000px.

## Syndicating Content

FrancisCMS supports automated and manual syndication of content to third-party silos. In IndieWeb terminology, this is known as [POSSE](https://indiewebcamp.com/POSSE): _Publish (on your) Own Site, Syndicate Elsewhere_.

### Flickr

1. Apply for [a new Flickr API key](https://www.flickr.com/services/apps/create/apply/). Keep the supplied `key` and `secret` handy, you'll need them in subsequent steps.
1. From the root of your Rails application, run `bundle exec rake francis_cms:configure_flickr`.
1. Follow the prompts to obtain the necessary OAuth keys and secrets from Flickr.
1. Copy and paste your Flickr syndication configuration into your application's `config/secrets.yml`.

### Medium

1. Generate [a new Medium integration token](https://medium.com/me/settings).
1. Add the following to your application's `config/secrets.yml`, replacing the uppercased strings with your integration token from Medium:

```yml
medium_integration_token: YOUR_MEDIUM_INTEGRATION_TOKEN
```

### Twitter

1. Visit [apps.twitter.com](https://apps.twitter.com/) and click the "Create New App" button.
1. Enter the required Application Details and agree to the Developer Agreement.
1. On the Keys and Access Tokens tab, click the "Create my access token" button.
1. Add the following to your application's `config/secrets.yml`, replacing the uppercased strings with the appropriate values from Twitter:

```yml
twitter_consumer_key: YOUR_TWITTER_CONSUMER_KEY
twitter_consumer_secret: YOUR_TWITTER_CONSUMER_SECRET
twitter_access_token: YOUR_TWITTER_ACCESS_TOKEN
twitter_access_token_secret: YOUR_TWITTER_ACCESS_TOKEN_SECRET
```

### Manual Syndication

For networks that either don't allow for automated syndication (e.g. Instagram) or that aren't currently supported in FrancisCMS, you can manually add syndicated copies to each content type. After publishing a piece of content, and when editing that piece of content, you'll see a form for adding links to syndicated copies.

## Theming

FrancisCMS supplies views for CRUD-ing all supported content types. The host Rails application is responsible for providing the primary layout (e.g. `app/views/layouts/application.html.erb`) as well as CSS, JavaScript, and other assets. It's your choice as to how you create and serve those assets. A typical Rails application uses the [Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html) which makes available to you pre-processing technologies like [Sass](http://sass-lang.com/).

FrancisCMS' views are lightweight, accessible, and flexible which means you can easily use a technique like [progressive enhancement](https://en.wikipedia.org/wiki/Progressive_enhancement) to build a beautiful and richly interactive website with the provided base markup. The sky's the limit, really!

### Markup Conventions

FrancisCMS is built on [IndieWeb principles](https://indiewebcamp.com/principles) and [building blocks](https://indiewebcamp.com/Category:building-blocks). Among those are the inclusion of [microformats2](http://microformats.org/wiki/microformats2) which enable technologies like [webmention](https://indiewebcamp.com/Webmention). As such, you'll see sprinkled throughout the markup `class` attribute values begining with `h-`, `p-`, and `u-`.

Care has been taken to craft FrancisCMS' markup in a way that is lightweight, accessible, and flexible. Rather than wed FrancisCMS to a particular CSS framework or convention (e.g. [BassCSS](http://www.basscss.com/), [SMACSS](https://smacss.com/), or [OOCSS](https://github.com/stubbornella/oocss/wiki)), I've instead tried to use descriptive `class` attribute values and allowed for considered use of the cascade (the "C" in "CSS").

## Improving FrancisCMS

TODO

### Contributing

TODO

### Testing

TODO

### Donations

If diving into Ruby isn't your thing, but you'd still like to support FrancisCMS, consider making a donation! Any amount—large or small—is greatly appreciated. As a token of my gratitude, I'll add your name to the [Acknowledgments](#acknowledgments) below.

[![Donate via Square Cash](https://img.shields.io/badge/square%20cash-$jgarber-28c101.svg?style=for-the-badge)](https://cash.me/$jgarber)
[![Donate via Paypal](https://img.shields.io/badge/paypal-jgarber-009cde.svg?style=for-the-badge)](https://www.paypal.me/jgarber)

## Acknowledgments

Most of this wouldn't have been possible without [Tony Pitale](http://tpitale.com/)'s mentorship, encouragement, and patience. Thanks, buddy!

The default user avatar image (`app/assets/images/avatar.png`) was derived from [Brent Jackson](http://jxnblk.com/)'s [Geomicons Open](https://github.com/jxnblk/geomicons-open) icon set.

FrancisCMS is written and maintained by [Jason Garber](http://sixtwothree.org/).

## License

FrancisCMS is freely available under the [MIT License](http://opensource.org/licenses/MIT). Use it, learn from it, fork it, improve it, change it, tailor it to your needs.