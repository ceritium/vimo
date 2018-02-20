# frozen_string_literal: true

require_dependency "vimo/application_controller"

module Vimo
  class ItemsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :find_entity
    before_action :find_item, only: [:show, :update, :destroy]

    def index
      @items = @entity.items.page(page).per(per_page)
      respond_with @entity, @items
    end

    def show
      respond_with @entity, @item
    end

    def create
      @item = items.build
      save_and_respond
    end

    def update
      save_and_respond
    end

    def destroy
      @item.destroy
      respond_with @entity, @item
    end

    private

    def save_and_respond
      @item.data = params[:item]
      @item.save

      respond_with @entity, @item
    end

    def find_entity
      entity_id = params[:entity_id]

      @entity = entities_scope.find_by(id: entity_id) ||
        entities_scope.find_by!(system_name: entity_id)
    end

    def find_item
      @item = items.find(params[:id])
    end

    def items
      @entity.items
    end

    def not_found
      render json: { error: "not_found" }, status: :not_found
    end
  end
end
