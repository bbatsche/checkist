class AddTodoCompletion < ActiveRecord::Migration
  def up
    add_column :todos, :complete, :boolean, :default => 0
  end

  def down
    remove_column :todos, :complete
  end
end
