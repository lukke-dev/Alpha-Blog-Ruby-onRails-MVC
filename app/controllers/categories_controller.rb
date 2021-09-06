class CategoriesController < ApplicationController
  before_action :require_admin, except: %i[index show]

  def index
    @categories = Category.order(:name).page(params[:page])
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = 'Categoria atualizada com succeso!'
      redirect_to @category
    else
      render 'edit'
    end
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.page params[:page]
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
