# HexletCode
[![CI](https://github.com/antonsmolko/rails-project-lvl1/actions/workflows/main.yml/badge.svg)](https://github.com/antonsmolko/rails-project-lvl1/actions/workflows/main.yml)
[![hexlet-check](https://github.com/antonsmolko/rails-project-lvl1/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/antonsmolko/rails-project-lvl1/actions/workflows/hexlet-check.yml)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/hexlet_code`. To experiment with that code, run `bin/console` for an interactive prompt.

This gem is for generating html form. [Struct](https://ruby-doc.org/core-2.7.3/Struct.html) is used to generate an entity.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hexlet_code'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hexlet_code

## Usage

```ruby
Entity = Struct.new :name, :job, :gender, keyword_init: true

entity = Entity.new name: 'rob', job: 'hexlet', gender: 'm'

form = HexletCode.form_for entity do |f|
  f.input :name
  f.input :job, as: :text
  f.input :gender, as: :select, collection: %w[m f]
  f.submit
end

p form

# <form action="#" method="post">
# <label for="name">Name</label>
# <input type="text" name="name" value="rob"/>
# <label for="job">Job</label>
# <textarea cols="20" rows="40" name="job">hexlet</textarea>
# <label for="gender">Gender</label>
# <select name="gender">
# <option value="m" selected>m</option>
# <option value="f">f</option>
# </select>
# <input type="submit" name="commit" value="Save"/>
# </form>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hexlet_code. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/hexlet_code/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the HexletCode project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/hexlet_code/blob/master/CODE_OF_CONDUCT.md).
