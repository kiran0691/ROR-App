class UsersController < ApplicationController
  skip_before_action :session_verify, only: [:login, :validate_login, :new, :create]

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save
      redirect_to :action => "index"
    else
      render "new"
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update(user_params)
      redirect_to :action => "index"
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    redirect_to :action => "index"
  end

  def show
    @user = User.find params[:id]
  end

  def validate_login
    @user = User.authenticate(params[:email], params[:password])
    if not @user.blank?
      session[:user_id] = @user.id
      redirect_to :action => "index"
    else
      flash[:notice] = "Email or password is incorrect"
      render "login"
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_users_path
  end

  private

  def user_params
    params.require(:user).permit!
  end
end
