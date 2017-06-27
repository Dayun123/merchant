class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def sub_total

    # Runs the SQL query and stores the SUM of the quantity and price of each line item in a property :sum (the AS sum portion). An array is returned (with one LineItem object), so we grab it ([0]) and select the :sum property on it.
    line_items.select("SUM(quantity * price) AS sum")[0][:sum]

    # sub_total = 0.0
    # line_items.each do |item|
    #   sub_total += item.total_price
    # end
    # sub_total
  end

  # Makes it so we can update our quantity if a product is already in the cart.
  def add_product(product_id)
    product = Product.find(product_id)
    current_item = line_items.find_by(product_id: product_id)

    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product: product, price: product.price)
    end

    current_item
  end

end

# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
