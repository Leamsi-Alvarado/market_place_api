class EnoughProductsValidator < ActiveModel::Validator
  def validate(record)
    record.placements.each do |placement|
      product = placement.product
      if placement.quantity.to_i > product.quantity
        record.errors.add(product.title, "Is out of stock, only #{product.quantity} left")
      end
    end
  end
end
