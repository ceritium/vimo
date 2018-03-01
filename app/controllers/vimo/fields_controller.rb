# frozen_string_literal: true

require_dependency "vimo/application_controller"

module Vimo
  class FieldsController < ApplicationController
    before_action :find_entity
    before_action :find_field, only: [:show, :update, :destroy]

    def index
      @fields = fields_scope.page(page).per(per_page)
      respond_with @entity, @fields
    end

    def show
      respond_with @entity, @field
    end

    def create
      @field = fields_scope.create(field_params)
      respond_with @entity, @field
    end

    def update
      @field.update(field_params)
      respond_with @entity, @field
    end

    def destroy
      @field.destroy
      response_with @entity, @field
    end

    private

    def field_params
      params.require(:field).
        permit(:name, :kind, :required, :system_name)
    end

    def fields_scope
      @entity.fields
    end

    def find_entity
      entity_id = params[:entity_id]

      @entity = entities_scope.find_by(id: entity_id) ||
        entities_scope.find_by!(system_name: entity_id)
    end

    def find_field
      @field = fields_scope.find_by(id: params[:id]) ||
        fields_scope.find_by!(system_name: params[:id])
    end
  end
end
