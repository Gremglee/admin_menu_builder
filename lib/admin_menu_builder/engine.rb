module AdminMenuBuilder
  class Engine < ::Rails::Engine
    initializer 'admin_menu_builder.load_routes' do |app|
      Menu.include app.routes.url_helpers
    end
  end
end
