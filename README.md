# README

This project is a Sinatra service for shortening URLs. As there is no external
database, short URLs don't persist between restarts. However, they are shareable
between different clients while the server is running.

You can run the service both with and without Docker.

# Setup with Docker

First build the image by running

`docker build -t url_shortener .`

Then create a container and run the server with

`docker run --rm -p 4000:4000 url_shortener`

There is no need to save the container afterwards, hence the --rm flag in
the run command. You can replace url_shortener with another name for the
image.

# Setup without Docker

Run `gem install bundler -v 1.17.2` followed by `bundle install` to install the
dependencies. Run `ruby lib/app.rb` to start the server.

# Usage

The service can be reached on `localhost:4000` with both docker and non-docker
installs.

To post a url and obtain a corresponding short url, run

`curl localhost:4000 -XPOST -d '{ "url": "your_url" }`

For example:

`curl localhost:4000 -XPOST -d '{ "url": "http://cathex.io" }`

To get a url from a short url, run

`curl -v localhost:4000your_short_url`

For example:

`curl -v localhost/abc123`

# How to run the test suite

With a docker install, run

`docker run --rm url_shortener bundle exec rspec`

As always, if you use another name for your image, replace url_shortener in the
above accordingly.

With a non-docker install, run

`bundle exec rspec`

