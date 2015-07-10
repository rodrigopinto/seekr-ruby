# Seekr::Ruby

[![Build Status][travis_badge]][travis]
[![Code Climate][codeclimate_badge]][codeclimate]
[![Test Coverage][test_badge]][test]

Ruby client for [Seekr Monitor][seekr] API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'seekr-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install seekr-ruby

## Usage

### Configure API keys

Create a file `config/initializers/seekr.rb` and add:

```ruby
Seekr.configure do |config|
  config.api_key = "<API-KEY>"
  config.api_secret = "<API-SECRET>"
end
```

### Searching for monitors

Run:

```ruby
monitor = Seekr::Monitor.new
monitor.all
```

It results:

```json
{
  "response": {
    "status": "200 OK",
    "code": 200
  },
  "searches": [
    {
      "id": 1,
      "name": "Monitor one",
      "search_results": 1243,
      "search_terms": 2,
      "tags": 7,
      "medias": 3,
      "active": true,
      "sentiment_analysis": false
    },
    {
      "id": 2,
      "name": "Monitor two",
      "search_results": 546,
      "search_terms": 5,
      "tags": 2,
      "medias": 0,
      "active": false,
      "sentiment_analysis": false
    }
  ]
}

```

### Searching for a specific monitor

Run:

```ruby
monitor = Seekr::Monitor.new
monitor.find(9999)
```

It results:

```json
{
  "response": {
    "status": "200 OK",
    "code": 200
  },
  "search": {
    "id": 11111,
    "name": "[Dashboard] Cards",
    "start_date": "01/11/2013",
    "search_results": 10641,
    "search_terms": [
      {
        "term": "Some Term",
        "id": 1
      },
      {
        "term": "some term",
        "id": 2
      }
    ],
    "tags": 10,
    "medias": 4,
    "active": false,
    "sentiment_analysis": true
  }
}
```
### Searching for tags of a monitor

Run:

```ruby
monitor = Seekr::Monitor.new
monitor.tags(9999)
```

It results:

```json
{
  "response": {
    "status": "200 OK",
    "code": 200
  },

  "tags": [
    {
      "id": 1,
      "name": "Awesome Tag",
      "search_results": 53
    },

    {
      "id": 2,
      "name": "Another Tag",
      "search_results": 37
    }
  ]
}
```

### Report

#### General report

Run:

```ruby
report = Seekr::Report.new(9999)
report.general
```

It results:

```json
{
  "response": {
    "status": "200 OK",
    "code": 200
  },
  "report": {
    "total": 2483,
    "positive": 847,
    "neutral": 1156,
    "negative": 480,
    "positive_perc": 34.4,
    "neutral_perc": 46.3,
    "negative_perc": 19.3
  }
}
```

## Contributing

1. Fork it ( https://github.com/rodrigopinto/seekr-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[travis]: https://travis-ci.org/rodrigopinto/seekr-ruby
[travis_badge]: https://travis-ci.org/rodrigopinto/seekr-ruby.svg?branch=master

[codeclimate]: https://codeclimate.com/github/rodrigopinto/seekr-ruby
[codeclimate_badge]: https://codeclimate.com/github/rodrigopinto/seekr-ruby/badges/gpa.svg

[test]: https://codeclimate.com/github/rodrigopinto/seekr-ruby
[test_badge]:https://codeclimate.com/github/rodrigopinto/seekr-ruby/badges/coverage.svg

[seekr]: http://seekr.com.br/
