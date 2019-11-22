module Spree
  HomeController.class_eval do
    def sale
      # TODO: Refactor to include sales in searcher builder
      if params[:id]
        @taxon = Spree::Taxon.find_by!(slug: params[:id])
        @products = Spree::Product.in_sale.in_taxon(@taxon)
      else
        @products = Spree::Product.in_sale
      end
      @taxonomies = Spree::Taxonomy.includes(root: :children)

      if @products.count == 0
        redirect_to root_path
      end
    end
  end
end
