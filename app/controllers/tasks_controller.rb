class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: [:index, :new, :edit, :show]
  before_action :authenticate_user, only: [:index]

  def index
      @tasks = current_user.tasks
    #  @tasks = Task.all.order(created_at: :desc)
    
    if params[:sort_expired]
      # @tasks = Task.all.order(deadline: :desc)
      @tasks = current_user.tasks.order(deadline: :desc)
    else
      #  @tasks = Task.all.order(created_at: :desc)
       @tasks = current_user.tasks.order(created_at: :desc)
    end  

    if params[:sort_priority]
      @tasks = Task.all.order(priority: :desc)
    end  

    if params[:name].present? && params[:status].present?
      @tasks = Task.where('name LIKE ?', "%#{params[:name]}%")
      @tasks = @tasks.where(status: params[:status])
    elsif params[:name].present?
          @tasks = Task.where('name LIKE ?', "%#{params[:name]}%")
      
    elsif params[:status].present?
          @tasks = Task.where(status: params[:status])
      end
    
      @tasks = @tasks.page(params[:page]).per(5)
  end

  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました！"
    else
      render :new
    end
  end

  def Show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました"
  end

  private
  def task_params
    params.require(:task).permit(:name, :content, :deadline, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
