class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = 'Logado com sucesso'
      redirect_to user_path(user.id)
    else
      flash.now[:alert] = 'Email ou Senha inválido'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Usuário desconectado'
    redirect_to root_path
  end
end
