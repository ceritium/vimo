# Vimo

Rails engine that allow to your users create and customize their own virtual models.

## Warning

This engine is in a very early stage and the DSL and APIs could change, if you
are interested on use it you can emailme: `ceritium@gmail.com`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'vimo'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install vimo
```

## Usage

### Expose the manage API

Add `mount Vimo::Engine => "/vimo"` in `config/routers.rb` to expose an restfull
API to manage the virtual models and their contents.

CRUD of entities, where `:entity` is the `id` or `system_name` of the entity.
```
GET    /vimo/entities
POST   /vimo/entities
GET    /vimo/entities/:entity
PATCH  /vimo/entities/:entity
PUT    /vimo/entities/:entity
DELETE /vimo/entities/:entity
```

Entity attributes:
```
{
  "name": "posts",          # required
  "system_name": "posts",   # unique per owner
  "field_attributes": {
    "id": 42,               # just for update
    "name": "title",        # required
    "kind": "string",       # required, options: string, integer, float, boolean, date or datetime
    "required": true,       # options: true or false
    "_destroy": false,      # just for update, mark to destroy the field, options: true or false
  }
}

```

Create an entity curl example:
```
curl localhost:3000/vimo/entities -X POST -H 'Content-Type: application/json' -d '{"entity": {"name": "comments", "fields_attributes": [{"name": "title", "kind": "string", "required": true}]}}'
```

CRUD for your virtual models:
```
GET    /vimo/entities/:entity/items
POST   /vimo/entities/:entity/items
GET    /vimo/entities/:entity/items/:id
PATCH  /vimo/entities/:entity/items/:id
PUT    /vimo/entities/:entity/items/:id
DELETE /vimo/entities/:entity/items/:id
```

Create an item curl example:
```
curl localhost:3000/vimo/entities/comments/items -X POST -H 'Content-Type: application/json' -d '{"item" : {"title": "a title"}}'
```

Short path version
```
GET    /vimo/resources/:entity
POST   /vimo/resources/:entity
GET    /vimo/resources/:entity/:id
PATCH  /vimo/resources/:entity/:id
PUT    /vimo/resources/:entity/:id
DELETE /vimo/resources/:entity/:id
```

### API authentication

Vimo allow you to authenticate and set ownership to your models.

```ruby
Vimo.configure do |config|

  # The name of the before filter we'll call to authenticate the current user.
  # Defaults to :login_required
  config.authentication_method = :authenticate!

  # The name of the controller method we'll call to return the owner for
  # the virtual models.
  config.owner_method = :current_account
end
```

Setting a `owner` scope the uniquenes constraints.

The owner should respond to `vimo_entities`

```ruby
class Account < ApplicationRecord
  vimo_owner
end
```


### Expand your models

Having a model like `Post` that belongs to an `Account` you can allow to your
users expand it.

```ruby
class Post < ApplicationRecord
  belongs_to :account

  vimo_expand owner: :account
end
```

Now can manage the virtual attributes of the model `Post` with the identifier `_expand_posts`.


## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
