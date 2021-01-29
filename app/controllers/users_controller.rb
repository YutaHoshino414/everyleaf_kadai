class UsersController < ApplicationController
  before_action :logged_in?, only: [:index, :new, :show]
  before_action :ensure_correct_user, only: [:show, :edit, :update]

  def new
    if logged_in?
      redirect_to tasks_path, notice: "新規ユーザー作成は、一度ログアウトしてください"
    else
    @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "ユーザーを編集しました"
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password,
                                 :password_confirmation)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to tasks_path, notice: "権限がありません"
    end
  end
end
