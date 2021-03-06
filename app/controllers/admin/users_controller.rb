class Admin::UsersController < ApplicationController
before_action :admin_user

  def index
    @users = User.all.includes(:tasks)
    
    @users = @users.page(params[:page]).per(5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザーを登録しました"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: "ユーザーを編集しました"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました"
    else
      redirect_to admin_users_path, notice: "管理者は2人以上必要です"
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def admin_user
    redirect_to root_path , notice: "管理者以外はアクセスできません" unless current_user.admin?
  end
  
end
