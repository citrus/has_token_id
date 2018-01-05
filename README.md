# has_token_id [![Build Status](https://travis-ci.org/citrus/has_token_id.svg?branch=master)](https://travis-ci.org/citrus/has_token_id)

Identify your active records with random tokens when you don't want your users to see a sequential ID.


------------------------------------------------------------------------------
Installation
------------------------------------------------------------------------------

Add has_token_id to your Gemfile like so:

```ruby
gem 'has_token_id', '~> 0.5.0'
```

Now run `bundle install` and you're good to go!


------------------------------------------------------------------------------
Usage
------------------------------------------------------------------------------

First, add a token to your model's table with a migration:

```ruby
# Upgrade and existing table
class AddTokenToItems < ActiveRecord::Migration
  add_column :items, :token, :string
end

# Add to a new table
class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.token
      t.string :name

      t.timestamps
    end
  end
end
```


Now make sure your model knows to use it's token by calling `has_token_id`

```ruby
class Item < ActiveRecord::Base
  has_token_id  
end
```

That's basically it! Your Items will now know to use their token as their identifier.

Try it out in your `rails console`

```ruby
@item = Item.create(name: "Tokenz!")
#<Item id: 1, token: "Iccfa4bb1613e80097ba9495", name: "Tokenz!", created_at: "2012-01-26 20:17:13", updated_at: "2012-01-26 20:17:13">
@item.to_param
# Iccfa4bb1613e80097ba9495
@item == Item.find("Iccfa4bb1613e80097ba9495")
# true
@item.short_token
# Iccfa4bb
```


------------------------------------------------------------------------------
Options
------------------------------------------------------------------------------

You can customize has_token_id by setting a few options. Here's the defaults:

```ruby
{
  prefix:             nil, # if nil use first letter of class name
  length:             24,
  short_token_length: 8,
  param_name:         'token',
  case_sensitive:     false
}
```


Options can be set globally by overwriting the `HasTokenId.default_token_options`

```ruby
# config/initializers/has_token_id.rb

# for one option
HasTokenId.default_token_options[:prefix] = "OMG"

# for multiple options
HasTokenId.default_token_options.merge!(
  case_sensitive: true,
  length:         8
)
```


Options can also be set on a per-class level:

```ruby
class List < ActiveRecord::Base
  has_token_id prefix: "LI", length: 10
end

class Item < ActiveRecord::Base
  has_token_id prefix: "ITM"
end
```


------------------------------------------------------------------------------
Demo
------------------------------------------------------------------------------

Try out the demo to get a real clear idea of what has_token_id does.

```bash
git clone git://github.com/citrus/has_token_id.git
cd has_token_id
bundle install
bundle exec dummier
cd test/dummy
rails s
```

Now open your browser to [http://localhost:3000](http://localhost:3000)


------------------------------------------------------------------------------
Testing
------------------------------------------------------------------------------

Testing is done with [minitest](https://github.com/seattlerb/minitest), [minitest_should](https://github.com/citrus/minitest_should) and [dummier](https://github.com/citrus/dummier).

To get setup, run the following commands:

```bash
git clone git://github.com/citrus/has_token_id.git
cd has_token_id
bundle install
bundle exec dummier
```

Now run the tests with:

```bash
bundle exec rake
```


------------------------------------------------------------------------------
License
------------------------------------------------------------------------------

Copyright (c) 2011 - 2018 Spencer Steffen and Citrus, released under the New BSD License All rights reserved.
