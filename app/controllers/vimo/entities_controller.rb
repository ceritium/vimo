# frozen_string_literal: true

require_dependency "vimo/application_controller"

module Vimo
  class EntitiesController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :find_entity, only: [:show, :update, :destroy]

    def index
      @entities = entities_scope.page(page).per(per_page)
      respond_with @entities
    end

    def show
      respond_with @entity
    end

    def create
      @entity = entities_scope.create(entity_params)
      respond_with @entity
    end

    def update
      @entity.update(entity_params)
      respond_with @entity
    end

    def destroy
      @entity.destroy
      respond_with @entity
    end

    private

    def find_entity
      @entity = entities_scope.find(params[:id])
    end

    def entity_params
      params.require(:entity).
        permit(:name, :system_name,
          fields_attributes: [:id, :name, :kind, :required, :_destroy])
    end
  end
end
