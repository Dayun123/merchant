class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, optional: true
  # This is super important, you can't create a line item without an order if you don't do this.
  belongs_to :order, optional: true

  def total_price
    price * quantity
  end

end

# == Schema Information
#
# Table name: line_items
#
#  id         :integer          not null, primary key
#  product_id :integer
#  quantity   :integer          default(1)
#  price      :decimal(, )
#  cart_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order_id   :integer
#
# Indexes
#
#  index_line_items_on_cart_id     (cart_id)
#  index_line_items_on_order_id    (order_id)
#  index_line_items_on_product_id  (product_id)
#
