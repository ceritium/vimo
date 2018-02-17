# frozen_string_literal: true

require "application_responder"

module Vimo
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception
    responders Responders::PaginateResponder
    respond_to :json

    before_action :authentication_filter

    def page
      params[:page].to_i
    end

    def per_page
      50
    end

    def max_per_page
      per_page
    end

    private

    def entities_scope
      owner ? owner.send(vimo_conf.entities_method) : Entity
    end

    def owner
      if owner_method
        send(owner_method)
      end
    end

    def authentication_filter
      meth = vimo_conf.authentication_method
      if meth
        send(meth)
      end
    end

    def owner_method
      vimo_conf.owner_method
    end

    # A helper method to access the BlogDashboard::configuration
    # at the class level
    def self.vimo_conf
      Vimo::configuration
    end

    # A helper method to access the BlogDashboard::configuration
    # at the controller instance level
    def vimo_conf
      self.class.vimo_conf
    end
  end
end
