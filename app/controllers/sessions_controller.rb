class SessionsController < ApplicationController
    def new
    end
  
    def create
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:success] = 'Logado com sucesso!'
        redirect_to root_path
      else
        flash.now[:error] = 'Usuário ou senha incorretos.'
        render 'new'
      end
    end
  
    def destroy
      session[:user_id] = nil
      flash[:success] = 'Deslogado com sucesso!'
      redirect_to login_path
    end
end
  