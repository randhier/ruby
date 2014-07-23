class AddOrderPlacedFlagToPizzas < ActiveRecord::Migration
  def self.up
    add_column :pizzas, :ordered, :boolean
  end

  def self.down
    drop_column :pizzas, :ordered
  end
end
