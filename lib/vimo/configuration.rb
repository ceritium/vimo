# frozen_string_literal: true

module Vimo
  class Configuration
    attr_accessor :authentication_method
    attr_accessor :owner_method
    attr_accessor :entities_method

    def initialize
      @authentication_method = nil
      @owner_method = nil
      @entities_method = :vimo_entities
    end
  end
end
