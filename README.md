# AdminMenuBuilder

DSL для создания админского меню.

## Installation

Добавить в Gemfile:

```ruby
gem 'admin_menu_builder', git: 'ssh://git@stash.netology-group.ru:7999/gems/admin_menu_builder.git'
```

## Usage

По-умолчанию авторайзер берётся из названия ресурса,
label из локали `ru.activerecord.models.course.other`,
а url генерируется в :admin namespace

`AdminMenuBuilder.menu_items_for(current_admin)` - элементы меню для текующего пользователя
Для элементов главного меню применяются все авторайзеры его подэлементов. Если хоть один из
подэлементов доступен пользователю, то элемент главного меню выводится

Опциональные параметры:

    :label - Заголовок меню
    :authorizer_resource - ресурс для авторайзера. nil - авторайзер не применяется
    :path - урл
    :counter - лямбда для каунтера
  
``` ruby
AdminMenuBuilder.main_menu do
  menu 'Обучение' do
    menu :courses, authorize_resource: nil
    menu :tasks, authorize_resource: Task
    menu :disciplines, path: admin_disciplines_path
    menu :trainings
  end
  menu :themes, label: 'ТЕМЫ!'
  menu [:marketing, :source_groups]
  menu :schools, counter: -> { City.moderated.count }
end
```  

Пример вывода меню в шаблоне:

```slim
ul.nav.navbar-nav
  - AdminMenuBuilder.menu_items_for(current_admin).each do |item|
    - if item.has_submenu?
      li.dropdown
        a.dropdown-toggle aria-expanded="false" data-toggle="dropdown" href="#" role="button"
          = item.label
          '
          span.caret
        ul.dropdown-menu.nav role="menu"
          - item.submenu.menu_items_for(current_admin).each do |subitem|
            li
              = link_to subitem.path do
                = subitem.label
                - if subitem.counter > 0
                  '
                  span.badge = subitem.counter
    - else
      li = link_to item.label, item.path
```