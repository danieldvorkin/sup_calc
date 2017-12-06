class UserMailer < ApplicationMailer
  default from: 'news@premecalc.com'

  def products_updated(count, updated)
    @count = count
    @updated = updated
    
    mail(to: "", bcc: User.all.map(&:email).uniq, subject: 'PremeCalc :: New Product Alerts', from: 'news@premecalc.com') do |format|
      format.html
    end
    
  end

  def no_products_updated
    mail(to: 'dvorkin212@gmail.com', subject: 'No Products Updated', from: 'news@premecalc.com')
  end
end
