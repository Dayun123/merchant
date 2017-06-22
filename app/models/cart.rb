class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def sub_total

    line_items.select("SUM(quantity * price) AS sum")[0].sum

    # sub_total = 0.0
    # line_items.each do |item|
    #   sub_total += item.total_price
    # end
    # sub_total
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
