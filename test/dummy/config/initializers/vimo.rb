# frozen_string_literal: true

Vimo.configure do |config|
  # The name of the before filter we'll call to authenticate the current user.
  # Defaults to :login_required
  config.authentication_method = :authenticate!

  # The name of the controller method we'll call to return the current_user.
  config.owner_method = :current_account
end
