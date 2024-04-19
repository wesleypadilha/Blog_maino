# app/mailers/user_mailer.rb

class UserMailer < ApplicationMailer
    def password_reset_email
      @user = params[:user]
      mail(to: @user.email, subject: "Instruções para redefinir a senha")
    end
  end
  