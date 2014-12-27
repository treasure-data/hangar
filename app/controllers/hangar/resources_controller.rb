module Hangar
  class ResourcesController < ActionController::Base
    respond_to :json

    def create
      created = FactoryGirl.create resource, resource_attributes
      render json: created.as_json(include: includes)
    end

    def new
      attributes = FactoryGirl.attributes_for resource, resource_attributes
      respond_with attributes
    end

    private

    def resource
      request.path.split('/')[1].singularize.to_sym
    end

    def resource_attributes
      params.fetch(resource, {})
    end

    def includes
      params.fetch(:include, [])
    end
  end
end
