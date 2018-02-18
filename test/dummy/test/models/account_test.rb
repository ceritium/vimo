# frozen_string_literal: true

require "test_helper"

class AccountTest < ActiveSupport::TestCase
  test "#vimo_entities" do
    account = Account.new
    assert account.vimo_entities
  end
end
