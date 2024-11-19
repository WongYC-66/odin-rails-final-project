class UserMailer < ApplicationMailer
  default from: ENV["GMAIL_USERNAME"]
  layout "mailer"

  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome to my rails-final-project Site")
  end
end
