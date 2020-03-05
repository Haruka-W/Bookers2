class BooksController < ApplicationController

before_action :authenticate_user!
before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def ensure_correct_user
    @book = Book.find_by(id:params[:id])
    if @book.user_id != current_user.id
      flash[:notice] = "このbookは編集できません"
      redirect_to books_path
    end
  end

  def index
  	@books = Book.all
  	@book = Book.new
    @user = current_user
  end

  def show
  	@book = Book.find(params[:id])
    @user = User.find(@book.user_id)
    @book_comment = BookComment.new
  end

  def new
  	@book = Book.new
  end

  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have creatad book successfully."
  	redirect_to book_path(@book)
    else
    @books = Book.all
    @user = current_user
    render 'books/index'
    end
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	@book.update(book_params)
    if @book.save
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book)
    else
    render 'books/edit'
    end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
