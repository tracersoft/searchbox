# Waldo

## INSTALL

Gemfile
```ruby
gem 'waldo', github: 'tracersoft/waldo'
```

## USAGE

```ruby
class DummySearch < Waldo::Search
  model Dummy #scopes will execute in the model instance

  scope :fulltext, -> (text) {
    search_by_name(text)
  }

  scope :search_by_name

  fields :email, :name #active-record only

  is :active, -> {
    active
  }

  has :attachment, -> {
  }

  in :trash, -> {
  }
end
```

will parse

`email: teste@waldo.com.br is:active Fulltextsearch`
