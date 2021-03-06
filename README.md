# WithTimedCache

[![Build Status](https://travis-ci.org/jordanstephens/with_timed_cache.svg?branch=master)](https://travis-ci.org/jordanstephens/with_timed_cache)

A simple, time-based cache.

## Installation

Add this line to your application's Gemfile:

    gem 'with_timed_cache'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install with_timed_cache

**Note**: Ruby version 2.0 or later is required.

## Usage

    with_timed_cache(key, max_age: 1.hour) do
      # some operation you would like cached for a certain amount of time
    end

**Options**

* `max_age`: how long to use the cached data, ex: `30.minutes`
* `location`: the directory path in which to store cache files
* `format`: cache data may be persisted as `:json`, `:yaml`, or the default of marshaling objects to strings will be used.
