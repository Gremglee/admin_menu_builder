require 'admin_menu_builder/version'
require 'admin_menu_builder/engine'
require 'admin_menu_builder/menu'
require 'admin_menu_builder/menu_item'

module AdminMenuBuilder
  # TODO: Несколько ресурсов для авторайзера (?)
  # TODO: Методы для авторайзера
  # TODO: namespace для урлов подменю (?)
  # По-умолчанию авторайзер берётся из названия ресурса,
  # label из локали ru.activerecord.models.course.other,
  # а url генерируется в :admin namespace
  #
  # AdminMenuBuilder.menu_items_for(current_admin) - элементы меню для текующего пользователя
  # Для элементов главного меню применяются все авторайзеры его подэлементов. Если хоть один из
  # подэлементов доступен пользователю, то элемент главного меню выводится
  #
  # Опциональные параметры:
  # :label - Заголовок меню
  # :authorizer_resource - ресурс для авторайзера. nil - авторайзер не применяется
  # :path - урл
  # :counter - лямбда для каунтера
  #
  # @example
  #   AdminMenuBuilder.main_menu do
  #     menu 'Обучение' do
  #       menu :courses, authorize_resource: nil
  #       menu :tasks, authorize_resource: Task
  #       menu :disciplines, path: admin_disciplines_path
  #       menu :trainings
  #     end
  #     menu :themes, label: 'ТЕМЫ!'
  #     menu [:marketing, :source_groups]
  #     menu :schools, counter: -> { City.moderated.count }
  #   end
  def self.main_menu(&block)
    @main_menu = Menu.new(&block)
  end

  def self.menu_items_for(admin)
    @main_menu.menu_items_for(admin)
  end

  def self.counters_for(admin)
    @main_menu.counters_for(admin)
  end
end