class CreatePizzas < ActiveRecord::Migration
  def self.up
    create_table :pizzas do |t|
      t.string :name, :null => false
      t.string :size, :null => false
      t.integer :user_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :pizzas
  end
end
