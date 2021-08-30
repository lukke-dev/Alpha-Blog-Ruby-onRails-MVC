class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update]

  def new
    @user = User.new
  end

  def index
    @users = User.page params[:page]
  end

  def create
    @user = User.new(article_params)
    if @user.save
      flash[:notice] = "Bem vindo #{@user.username} ao Blog Alpha, usuário criado com sucesso"
      redirect_to articles_path
      session[:user_id] = @user.id
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(article_params)
      flash[:notice] = 'Usuário atualizado com sucesso!'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @articles = @user.articles.page params[:page]
  end

  private

  def article_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = 'Você só pode editar seu proprio usuário.'
      redirect_to @user
    end
  end
end
