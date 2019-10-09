FROM ruby:2.6.5
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
VOLUME /app
EXPOSE 4000
CMD ["ruby", "lib/app.rb", "-o", "0.0.0.0"]
