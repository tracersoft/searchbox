# Searchbox

## INSTALL

Gemfile
```ruby
gem 'searchbox', github: 'tracersoft/searchbox'
```

## GETTING STARTED

```ruby
class DummySearch < Searchbox::Search
  klass Dummy #scopes will execute in the class context

  scope :fulltext, -> (text) {
    search_by_name(text) # sameas Dummy.search_by_name(text)
  }

  scope :search_by_name

  fields :email, :name #active-record only

  is :active # if is:active is in the query, will execute the method: Dummy.active
  has :attachment, -> {
  }

  in :trash, -> {
  }
end
```

will parse

`email: teste@searchbox.com.br is:active Fulltextsearch`
