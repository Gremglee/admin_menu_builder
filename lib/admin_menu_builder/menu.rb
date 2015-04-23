module AdminMenuBuilder
  class Menu
    attr_reader :items

    def initialize(&block)
      @items = []
      instance_exec(&block)
    end

    def add_item(resource, params = {}, &block)
      menu_item = MenuItem.new(resource, params)
      items << menu_item

      if block_given?
        menu_item.submenu = self.class.new(&block)
      end
    end

    alias_method :menu, :add_item

    def menu_items_for(admin)
      return [] if admin.nil?

      items.inject([]) do |m, item|
        m << item if item.readable_by?(admin)
        m
      end
    end

    def counters_for(admin)
      return [] if admin.nil?

      counters.inject([]) do |m, item|
        m << item if item.readable_by?(admin)
        m
      end
    end

    protected

    def counters
      @counters ||=
        items.inject([]) do |m, item|
          m << item if item.has_counter?
          m.push(*item.submenu.counters) if item.has_submenu?
          m
        end
    end
  end
end