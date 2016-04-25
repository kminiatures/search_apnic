# SearchApnic

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/search_apnic`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'search_apnic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install search_apnic

## Usage

### Dump

```
search_apnic -c 'JP' --dump
```

👇🏼

```
1.0.16.0/21
1.0.64.0/19
1.1.64.0/19
1.5.0.0/17
1.21.0.0/17
1.33.0.0/17
1.66.0.0/16
......
```

### Seach


#### Found.

```
search_apnic -c 'JP' -i '1.0.16.10'
```

👇🏼

```
1.0.16.0/21
```

#### Not Found.

```
 search_apnic -c 'JP' -i '1.0.116.0'
```
👇🏼
```
 Not Match
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/search_apnic. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

