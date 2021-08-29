class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]

  def new
    @user = User.new
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(article_params)
    if @user.save
      flash[:notice] = "Bem vindo #{@user.username} ao Blog Alpha, usuário criado com sucesso"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(article_params)
      flash[:notice] = 'Usuário atualizado com sucesso!'
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    @articles = @user.articles
  end

  private

  def article_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end
end