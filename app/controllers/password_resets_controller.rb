# app/controllers/password_resets_controller.rb

class PasswordResetsController < ApplicationController
    skip_before_action :require_login
  
    def new
    end
  
    def create
      user = User.find_by(email: params[:email])
      if user
        user.generate_password_reset_token!
        # Aqui você pode enviar um e-mail com instruções para redefinir a senha
        redirect_to root_path, notice: "E-mail de recuperação de senha enviado com sucesso!"
      else
        flash.now[:alert] = "Usuário não encontrado."
        render :new
      end
    end
  
    def edit
      @user = User.find_by(password_reset_token: params[:token])
      if @user
        # Aqui você renderiza o formulário para redefinir a senha
      else
        redirect_to root_path, alert: "Token de recuperação de senha inválido."
      end
    end
  
    def update
      @user = User.find_by(password_reset_token: params[:token])
      if @user&.update(password: params[:password], password_confirmation: params[:password_confirmation])
        redirect_to login_path, notice: "Senha redefinida com sucesso. Faça login com sua nova senha."
      else
        render :edit
      end
    end
  end
  