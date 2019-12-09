module V1
  class UsersController < ApplicationController
    def homepage_thumbnail
      @item = Item.order('RANDOM()').limit(1)
    end

    def endless_item
      @items = Item.all
    end
  end
end
