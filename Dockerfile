FROM ruby:2.4.1

RUN apt-get update && apt-get install -qq -y build-essential libpq-dev postgresql-client-9.4 --fix-missing --no-install-recommends

#=========IMAGEMAGIC INSTALL=========#
RUN apt-get -y install imagemagick libmagickcore-dev libmagickwand-dev

RUN mkdir /dtalks
WORKDIR /dtalks

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs

COPY . .

LABEL maintainer="Alex Koval <al3xander.koval@gmail.com>"

CMD puma -C config/puma.rb