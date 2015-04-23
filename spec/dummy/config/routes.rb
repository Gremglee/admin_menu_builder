Rails.application.routes.draw do

  mount AdminMenuBuilder::Engine => "/admin_menu_builder"
end
