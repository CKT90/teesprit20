class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Teesprit, Account Activation"
  end

  def empty(user)
    @user = user
    mail to: user.email, subject: "Teesprit, Account Activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user_id)
    user = User.find(user_id)
    @user = user
    mail to: user.email, subject: "Teesprit, Password Reset"
  end

  def notify_admin(user)
    @user = user
    mail to: "teesprit20@gmail.com", subject: 'Teesprit, New User Created!'
  end
end
