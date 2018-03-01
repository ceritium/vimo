# frozen_string_literal: true

account = Account.create!(name: "foo", api_key: "bar")
entity = account.vimo_entities.create!(name: "post")
entity.fields.create!(name: "title", kind: "string", required: true)
entity.fields.create!(name: "content", kind: "string", required: false)
