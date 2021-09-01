class CategoriesController < ApplicationController
  before_action :require_admin, except: %i[index show]

  def index
    @categories = Category.page(params[:page])
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Categoria criada com sucesso!'
      redirect_to @category
    else
      render 'new'
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    unless logged_in? && current_user.admin?
      flash[:alert] = 'Página disponivel apenas para Administradores'
      redirect_to categories_path
    end
  end
end
