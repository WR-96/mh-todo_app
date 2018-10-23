class AddDefaultToItemsCompletedColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :completed, :boolean, :default => false
  end
end
