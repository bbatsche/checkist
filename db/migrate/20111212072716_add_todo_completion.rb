class AddTodoCompletion < ActiveRecord::Migration
  def up
    add_column :todos, :complete, :boolean, :default => false
  end

  def down
    remove_column :todos, :complete
  end
end
