class UsersController < ApplicationController
  def new
    @user = User.new
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

  def edit
    @user = User.find(params[:id])
  end

  def update; end

  private

  def article_params
    params.require(:user).permit(:username, :email, :password)
  end
end
