# frozen_string_literal: true

module Vimo
  class Engine < ::Rails::Engine
    isolate_namespace Vimo

    require "kaminari"
    require "responders"
    require "paginate-responder"


    initializer "model_core.factories", after: "factory_bot.set_factory_paths" do
      FactoryBot.definition_file_paths << File.expand_path("../../../test/factories/", __FILE__) if defined?(FactoryBot)
    end
  end
end
