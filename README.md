# Stockme-api

This is the (future) backend part of the image upload website [Stockme](http://stockme.fr) (name subject to change).

It's a simple rails 5 api application, developed and tested with Ruby v2.4.0, older versions should probably work but there's no guarantee. (Rails 5 needs at least v2.2.2).

Note: This project is part of my [12 Months / 12 Side Projects](https://blog.1ppm.club/12-months-12-side-projects-are-you-in-c395dbcd648e#.1l5cy0ooh).

### Requirements

* Imagemagick

### Installation

* Clone repository
* Copy `config/database.yml-dist` to `config/database.yml` and configure your database cf [Rails documentation](http://edgeguides.rubyonrails.org/configuring.html#configuring-a-database)
* Copy `config/secrets.yml-dist` to `config/secrets.yml` and change value to something quite unique.
* Copy `config/initializers/cors.rb-dist` to `config/initializers/cors.rb`
* Copy `config/application.rb-dist` to `config/application.rb`
* `./bin/bundle install`
* `./bin/rails db:setup`
* `./bin/rails server`

### Testing

Simply run `./bin/rails test`