Spree::Promotion::Actions::FreeShipping.class_eval do

  def perform(payload = {})
    order = payload[:order]
    promotion = payload[:promotion]

    return unless promotion.eligible?(order)
    create_unique_adjustments(order, order.shipments)
  end

end
