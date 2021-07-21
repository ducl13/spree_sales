Spree::LineItem.class_eval do
  
  extend Spree::DisplayMoney
  money_methods :original_amount

  def original_amount
    current_currency ||= Spree::Config[:currency]
    variant.original_price_in(current_currency).amount * quantity
  end

end
