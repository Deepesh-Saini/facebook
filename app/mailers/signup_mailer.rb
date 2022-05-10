class SignupMailer < ApplicationMailer
	def signup_email
    @user = params[:user]
    mail( :to => @user.email, :subject => 'Thanks for signing up for our amazing app' )
  end
end
