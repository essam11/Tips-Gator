class CategoriesController < ApplicationController
  before_action :'require_admin',except: [:show,:index]
  def index

  @categories=Category.all.order("created_at DESC").paginate(page:params[:page], per_page: 4 )
  end

  def new
  @category=Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
      flash[:success]="New Category has been Created"
    else
      render 'new'
    end

  end

  def show

  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    if !logged_in? || (logged_in? and !current_user.admin?)
      flash[:danger]="Only admin User can Deal with Categories"
      redirect_to categories_path
    end

  end
end
