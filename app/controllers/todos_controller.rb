class TodosController < ApplicationController
  def index
    if signed_in?
      @page_title = "Home"
      @assigned_todos = current_user.assigned_todos.where(:complete => false)
      @todo_item = Todo.new
    else
      render 'pages/home'
    end
  end
  
  def accept
    
  end
  
  def reject
    
  end
  
  def mark_complete
    todo_item = current_user.assigned_todos.where(:id => params[:id]).first()
    
    if !todo_item.nil?
      todo_item.complete = true;
      todo_item.save
    end
    
    redirect_to root_path
  end
  
  def create
    @todo_item = current_user.assigned_todos.build(params[:todo])
    @todo_item.creator = current_user
    
    if @todo_item.save
      @assigned_todos = current_user.assigned_todos
      @todo_item = Todo.new
      redirect_to root_path
    else
      @assigned_todos = current_user.assigned_todos
      render 'list'
    end
  end
  
  def destroy
    todo_item = current_user.assigned_todos.where(:id => params[:id]).first()
    
    if !todo_item.nil?
      todo_item.destroy
    end
    
    redirect_to root_path
  end
  
  def assign
    
  end
  
  def show_assign
    
  end
end
