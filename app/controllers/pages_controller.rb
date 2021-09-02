class PagesController < ApplicationController
  def home
    redirect_to articles_path if logged_in?
  end

  def about; end

  def search
    @query = params[:title]
    @articles = Article.where('title like ?', "%#{@query}%").order(:title).page(params[:page])
  end
end
