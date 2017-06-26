class Order < ApplicationRecord
  belongs_to :user
  # Sets up a direct relationship between the order and the line items. If you destroy an order it will destroy the line items along with it.
  has_many :line_items, dependent: :destroy

  validates :name, :address, :user_id, presence: true

  # to get access to this outside of the Order class, use Order::PAYMENT_TYPES
  PAYMENT_TYPES = ['Cash', 'Check', 'PayPal', 'COD', 'Wampum', 'Bitcoin', 'Barter']

  validates :pay_type, inclusion: PAYMENT_TYPES, presence: true


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
