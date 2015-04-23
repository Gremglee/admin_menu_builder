module AdminMenuBuilder
  class MenuItem
    attr_reader :resource, :params, :submenu

    def initialize(resource, params = {})
      @resource = resource
      @params = params
      @submenu = nil
    end

    def has_submenu?
      @submenu.present?
    end

    def has_counter?
      params[:counter].is_a?(Proc)
    end

    def submenu=(value)
      params.delete(:path)
      @submenu = value
    end

    def label
      return resource if resource.is_a?(String)
      return params[:label] if params[:label].present?

      label = resource.is_a?(Array) ? resource.join('/') : resource.to_s
      I18n.t(label.underscore.singularize, scope: 'activerecord.models', count: 1.1, default: label.titleize)
    end

    def path
      params[:path].present? ? params[:path] : [:admin, *resource]
    end

    def counter
      has_counter? ? params[:counter].call.to_i : 0
    end

    def authorizer_resource
      params.include?(:authorizer_resource) ? params[:authorizer_resource] : resource_class
    end

    def readable_by?(admin)
      return true if authorizer_resource.nil?

      if has_submenu?
        @submenu.items.any? { |item| item.readable_by?(admin) }
      else
        authorizer_resource.readable_by?(admin)
      end
    end

    private

    def resource_class
      return Class if resource.is_a?(String)

      resource_name = resource.is_a?(Array) ? resource.join('/') : resource.to_s
      resource_name.singularize.camelize.constantize
    end
  end
end