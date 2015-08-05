# Searchbox

## INSTALL

Gemfile
```ruby
gem 'searchbox', github: 'tracersoft/searchbox'
```

## USAGE

```ruby
class DummySearch < Searchbox::Search
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

`email: teste@searchbox.com.br is:active Fulltextsearch`
