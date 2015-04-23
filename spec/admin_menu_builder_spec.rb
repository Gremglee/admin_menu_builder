require 'spec_helper'

class Course
end

describe AdminMenuBuilder do
  let(:admin) { double(:admin) }

  describe 'base DSL' do
    before do
      allow(Course).to receive(:readable_by?).and_return(true)

      AdminMenuBuilder.main_menu do
        menu 'Main menu title' do
          menu :courses
        end
      end
    end

    it 'builds main menu' do
      main_menu = AdminMenuBuilder.menu_items_for(admin)

      expect(main_menu.first.has_submenu?).to be true
      expect(main_menu.first.label).to eq 'Main menu title'
    end
  end
end