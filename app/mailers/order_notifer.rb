class OrderNotifer < ActionMailer::Base
  default from: "Sam Ruby <depot@example.com>"

  def received(order)
    @order = order

    mail to: order.email, subject: 'Confirmation of the order in Pragmatic Store'
  end
  
  def shipped
    @order = order

    mail to: order.email, subject: 'Order of Pragmatic Store sent'
  end
end
