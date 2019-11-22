Spree::Promotion.class_eval do

  def eligible?(promotable)
    return false if expired? || usage_limit_exceeded?(promotable) || blacklisted?(promotable) || has_sale_items(promotable)

    !!eligible_rules(promotable, {})
  end

  def has_sale_items(promotable)
    if (promotable.instance_of? Spree::Order)
      promotable.line_items.each do |line_item|
        if line_item.variant.on_sale?
          return true
        end
      end
    elsif (promotable.instance_of? Spree::LineItem)
      return promotable.variant.on_sale?
    end
    
    return false
  end

end