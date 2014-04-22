class OrderMailer < ActionMailer::Base

  def new_message(order)
    @order = order
    mail(to: @order.user.email, from: "test@test.com", subject: "Dinner Dash Order Confirmation")
  end

end
