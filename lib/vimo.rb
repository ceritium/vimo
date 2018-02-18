# frozen_string_literal: true

require "vimo/engine"
require "vimo/configuration"
require "vimo/ownerable"
require "vimo/expandable"

module Vimo
  # Your code goes here...

  class ConfigurationError < StandardError; end

  # Set global configuration options for I18nDashboard
  # @see README.md
  def self.configure(&block)
    block.call(configuration)
  end

  # Returns I18nDashboard's globalconfiguration. Will initialize a new instance
  # if not already set
  def self.configuration
    @configuration ||= Configuration.new
  end
end
