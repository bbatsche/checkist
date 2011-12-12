class TodosController < ApplicationController
  def index
    if signed_in?
      @page_title = "Home"
      
      @assigned_todos = current_user.assigned_todos.where(:complete => false, :pending_owner => nil)
      @incoming_todos = current_user.incoming_todos
      
      @todo_item = Todo.new
    else
      render 'pages/home'
    end
  end
  
  def accept
    todo_item = current_user.incoming_todos.where(:id => params[:id]).first
    
    if !todo_item.nil?
      todo_item.owner = current_user
      todo_item.pending_owner = nil;
      todo_item.save
    end
    
    redirect_to root_path
  end
  
  def reject
    todo_item = current_user.incoming_todos.where(:id => params[:id]).first
    
    if !todo_item.nil?
      todo_item.pending_owner = nil;
      todo_item.save
    end
    
    redirect_to root_path
  end
  
  def mark_complete
    todo_item = current_user.assigned_todos.where(:id => params[:id]).first
    
    if !todo_item.nil?
      todo_item.complete = true;
      todo_item.save
    end
    
    redirect_to root_path
  end
  
  def create
    @todo_item = Todo.new(params[:todo])
    @todo_item.owner   = current_user
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
    todo_item = current_user.assigned_todos.where(:id => params[:id]).first
    
    if !todo_item.nil?
      todo_item.destroy
    end
    
    redirect_to root_path
  end
  
  def assign
    todo_item = current_user.assigned_todos.where(:id => params[:id]).first
    
    new_user = User.find_by_email(params[:assign_todo][:email])
    
    if !todo_item.nil? and !new_user.nil?
      todo_item.pending_owner = new_user
      todo_item.save
    end
    
    redirect_to root_path
  end
  
  def show_assign
    @todo_item = current_user.assigned_todos.where(:id => params[:id]).first
    
    if @todo_item.nil?
      redirect_to root_path
    end
    
    @page_title = "Home"
  end
end
