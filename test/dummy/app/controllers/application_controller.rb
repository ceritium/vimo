# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate!
    @account ||= Account.find_by!(api_key: params[:api_key])
  end

  helper_method :authenticate!

  def current_account
    @account || authenticate!
  end
end
