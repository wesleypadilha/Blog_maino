# app/controllers/register_controller.rb

class RegisterController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: "Usuário criado com sucesso. Por favor, faça login."
    else
      flash.now[:alert] = "Ocorreram erros ao criar o usuário."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
