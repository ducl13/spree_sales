Spree::Promotion::Actions::CreateLineItems.class_eval do

  def perform(options = {})
    order = options[:order]
    promotion = options[:promotion]

    return unless promotion.eligible?(order)

    action_taken = false
    promotion_action_line_items.each do |item|
      current_quantity = order.quantity_of(item.variant)
      next unless current_quantity < item.quantity && item_available?(item)

      line_item = Spree::Dependencies.cart_add_item_service.constantize.call(order: order,
                                                                             variant: item.variant,
                                                                             quantity: item.quantity - current_quantity).value
      action_taken = true if line_item.try(:valid?)
    end
    action_taken
  end

end
