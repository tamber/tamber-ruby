# Tamber API Client for Ruby  [![Build Status](https://travis-ci.org/tamber/tamber-ruby.svg?branch=master)](https://travis-ci.org/tamber/tamber-ruby)

Recommendation engines for developers, easy as π. Build blazing fast, head-scratchingly accurate hosted recommendation engines in minutes.

The Tamber iOS SDK makes it easy to track events (user-item interactions) and get recommendations for your users inside your iOS app. 

[Get a free api key][homepage] to get started.

## Documentation

See [full API documentation][reference].

## Installation

To use the Tamber Ruby bindings, you should run:

```
gem install tamber
```

If you want to build the gem from source:

```
gem build tamber.gemspec
```

## Compatibility

We are compatible with Ruby 1.9.3 and above.


## Usage

If you are just getting started, check out the [Quick Start][quickstart] guide for instructions on how to get setup.

*We recommend tracking events from the client-side so that Tamber can learn from clicks/views, guest users, and contextual data. Use our [iOS][tamber-ios], [Node][tamber-node], or [javascript][tamber-js] SDKs to start tracking.* 

Of course, you can also track events from your backend.

### Track Events

```rb
require 'tamber'
Tamber.project_key = 'your_project_key'

begin
  Tamber::Event.track(
    user: 'user_rlox8k927z7p',
    behavior: 'like'
    item:  'item_wmt4fn6o4zlk',
    context: {
      "page": "homepage", 
      "section": "featured_section"
    }
  )
rescue TamberError => error
  puts error.message
end
```


### Get Recommendations

Once you have tracked enough events and created your engine, it's time to put personalized recommendations in your app.

The primary methods of discovery in Tamber are the `Discover.next` and `Discover.recommended` methods, which returns the optimal set of items that the user should be shown next on a given item page, and in a personalized recommendations section, respectively.

#### Up Next

Don't make an item page a deadend. Keep users engaged by creating paths of discovery as they navigate from item to item, always showing the right mix of items they should check out next. Just supply the user and the item that they are navigating to / looking at.

```rb
begin
  d = Tamber::Discover.next(
    user: 'user_rlox8k927z7p',
    item: 'item_wmt4fn6o4zlk',
    number: 14
  )
  d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
rescue TamberError => error
  puts error.message
end
```

#### For You

To put personalized recommendations on your homepage, or in any recommended section, just call `Discover.recommended` with the given user's id and the number of recommendations you want to display.

```rb
Tamber.project_key = 'your_project_key'

begin
  d = Tamber::Discover.recommended(
    user: 'user_rlox8k927z7p',
    number: 10
  )
  d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
rescue TamberError => error
  puts error.message
end
```


##### `continuation`

Recommendations are optimized for the exact moment and context of the user at the time of request, but sometimes a user wants to see more recommended items than are shown by default. In order to 'Show More', Tamber supports automatic continuation. 

When you want to add more recommendations to those currently displayed to the user, just set the `continuation` field to `true`. Tamber will automatically generate the set of items that should be appended to the current user-session's list. The user-session is reset when `Discover.recommended` or `Discover.next` is called without `continuation`.

```rb
Tamber.project_key = 'your_project_key'

begin
  d = Tamber::Discover.next(
    user: 'user_rlox8k927z7p',
    number: 10,
    continuation: true
  )
  d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
rescue TamberError => error
  puts error.message
end
```


#### Trending

Help your users keep their fingers on the pulse of your platform by showing them the hottest, most popular, newest, or most up-and-coming items.

```rb
begin
  d = Tamber::Discover.hot() // the hottest (trending) items
  d.each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
end

begin
  d = Tamber::Discover.popular() // the hottest (trending) items
end

# BETA endpoints
begin
  d = Tamber::Discover.uac() // the most up-and-coming items
end

begin
  d = Tamber::Discover.new() // the newest items
end
```

#### Build Your Own Features

Tamber allows you to use lower-level methods to get lists of recommended items, similar item matches, and similar items for a given user with which you can build your own discovery experiences. Importantly, these methods return raw recommendation data and are not intended to be pushed directly to users.

```rb
begin
  Tamber::Discover::Basic.recommended(user: 'user_rlox8k927z7p').each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
rescue TamberError => error
  puts error.message
end

begin
  Tamber::Discover::Basic.Similar(item: 'item_wmt4fn6o4zlk').each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
rescue TamberError => error
  puts error.message
end

begin
  Tamber::Discover::Basic.RecommendedSimilar(
    user: 'user_rlox8k927z7p',
    item: 'item_wmt4fn6o4zlk'
  ).each { |rec| puts "item: #{rec.item}, score: #{rec.score}"}
rescue TamberError => error
  puts error.message
end
```

### Sync Items (optional)

Keep Tamber in sync with your item data in order to use recommendation filtering. Just call `Item.update` wherever you create and update items in your backend. If you have a Database module, we recommend adding this method there.

```rb
require 'tamber'
Tamber.project_key = 'your_project_key'

begin
  Tamber::Item.update(
    id: 'item_wmt4fn6o4zlk',
    updates: {
      add: {
        properties: {
          'available_large': false,
          'stock': 89
        }
      }
    }
  )
rescue TamberError => error
  puts error.message
end
```

### Timeout Configuration

Open and read timeouts are configurable:

```rb
Tamber.open_timeout = 1
Tamber.read_timeout = 5
```

See [Tests](https://github.com/tamber/tamber-ruby/tree/master/test) for more examples.

[homepage]: https://tamber.com
[quickstart]: https://tamber.com/docs/start/
[reference]: https://tamber.com/docs/api
[dashboard]: https://dashboard.tamber.com/
[tamber-ios]: https://github.com/tamber/tamber-ios
[tamber-node]: https://github.com/tamber/tamber-node
[tamber-js]: https://github.com/tamber/tamber.js
