# HasTokenId [![Build Status](https://secure.travis-ci.org/citrus/has_token_id.png)](http://travis-ci.org/citrus/has_token_id) [![Dependency Status](https://gemnasium.com/citrus/has_token_id.png)](https://gemnasium.com/citrus/has_token_id)

Identify your active records with random tokens when you don't want your users to see a sequential ID.


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

Play with it in your `rails console`

```ruby
@item = Item.create(:name => "Tokenz!")
#<Item id: 1, token: "Iccfa4bb1613e80097ba9495", name: "Tokenz!", created_at: "2012-01-26 20:17:13", updated_at: "2012-01-26 20:17:13">
@item.to_param
# Iccfa4bb1613e80097ba9495
@item == Item.find("Iccfa4bb1613e80097ba9495")
# true
```


------------------------------------------------------------------------------
Options
------------------------------------------------------------------------------

You can customize has_token_id by setting a few options. Here's the defaults:

```ruby
:prefix         => nil, # if nil use first letter of class name 
:length         => 24,
:param_name     => 'token',
:case_sensitive => false
```


Options can be set globally by overwriting the `HasTokenId.default_token_options`

```ruby
# config/initializers/has_token_id.rb

# for one option
HasTokenId.default_token_options[:prefix] = "OMG"

# for multiple
HasTokenId.default_token_options.merge!(
  :prefix => "OMG",
  :length => 8
)
```


Or options can be set on a class level:

```ruby
class Item < ActiveRecord::Base
  has_token_id :prefix => "OMG", :length => 10
end
```


------------------------------------------------------------------------------
Installation
------------------------------------------------------------------------------

As usual, just use the `gem install` command:

```bash
(sudo) gem install has_token_id
```
    
Or add has_token_id as a gem in your Gemfile:

```bash
gem 'has_token_id', '~> 0.1.0' 
```

Now just run `bundle install` and you're good to go!


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

Copyright (c) 2011 - 2012 Spencer Steffen and Citrus, released under the New BSD License All rights reserved.
