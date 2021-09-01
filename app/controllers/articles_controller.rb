class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update destroy]

  def show; end

  def index
    @articles = Article.page(params[:page])
  end

  def new
    @article = Article.new
  end

  def edit; end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = 'Artigo criado com sucesso'
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = 'Artigo atualizado com sucesso!'
      redirect_to article_path(@article)

    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    flash[:notice] = 'Artigo Deletado com sucesso!'
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, category_ids: [])
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = 'Você só pode editar seus proprios artigos.'
      redirect_to @article
    end
  end
end
