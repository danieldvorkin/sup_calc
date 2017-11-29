class UserMailer < ApplicationMailer
  default from: 'news@premecalc.com'

  def products_updated(count)
    @count = count
    mail(to: User.pluck(:email).join(", "), subject: 'Welcome to My Awesome Site', from: 'news@premecalc.com')
  end
end
