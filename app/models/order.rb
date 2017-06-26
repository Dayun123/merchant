class Order < ApplicationRecord
  belongs_to :user
  # Sets up a direct relationship between the order and the line items. If you destroy an order it will destroy the line items along with it.
  has_many :line_items, dependent: :destroy

  validates :name, :address, :user_id, presence: true

  # to get access to this outside of the Order class, use Order::PAYMENT_TYPES
  PAYMENT_TYPES = ['Cash', 'Check', 'PayPal', 'COD', 'Wampum', 'Bitcoin', 'Barter']

  validates :pay_type, inclusion: PAYMENT_TYPES, presence: true

  def add_line_items_from_cart(cart)
    cart.line_items.each do |line_item|
      line_item.cart_id = nil
      # Since we declared a has_many relationship with line_items, that is what this line_items represents.
      line_items << line_item
    end
  end

end

# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  name       :string
#  address    :text
#  pay_type   :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_orders_on_user_id  (user_id)
#
