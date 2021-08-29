class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user_id
      flash[:notice] = 'logado com sucesso'
      redirect_to user_path(user.id)
    else
      flash.now[:alert] = 'Email ou Senha inválido'
      render 'new'
    end
  end

  def destroy; end
end
