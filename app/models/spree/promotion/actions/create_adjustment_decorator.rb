Spree::Promotion::Actions::CreateAdjustment.class_eval do

  def perform(options = {})
    order = options[:order]
    promotion = options[:promotion]

    return unless promotion.eligible?(order)
    create_unique_adjustment(order, order)
  end

end
