class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def ensure_correct_user
    @user = User.find_by(id:params[:id])
    if @user.id != current_user.id
      flash[:notice] = "このユーザーは編集できません"
      redirect_to user_path(current_user)
    end
  end


  def index
  	@users = User.all
  	@book = Book.new
    @user = current_user
  end

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
    render 'edit'
    end
  end


  private

  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
