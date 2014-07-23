class CreateToppings < ActiveRecord::Migration
  def self.up
    create_table :toppings do |t|
      t.string :name, :null => false
      t.boolean :double_order
      t.integer :pizza_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :toppings
  end
end
