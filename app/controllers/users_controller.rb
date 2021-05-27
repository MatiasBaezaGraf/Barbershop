class UsersController < ApplicationController
  load_and_authorize_resource
  
  def index
    if params[:phone_number] && params[:first_name]
      @users = User.find_everything(params[:phone_number], params[:first_name])
    else
      @users = User.all
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @admin = {"Si" => 1, "No" => 0}
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_index_path
  end

  def update
    @user.update(params.require(:user).permit(:first_name, :last_name, :admin, :phone_number, :email))
    redirect_to users_index_path
  end

 

  def user_params
    params.require(:user).permit(:first_name, :last_name, :admin, :phone_number, :email, :password, :password_confirmation)
  end
end
