class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category

  has_many :line_items

  # before we call the destroy method on this model, it will check to see if the product_id is in any line_items. This is so we don't delete a product from the DB while someone has it in a line_item. So, if someone bought this product, we would want to keep it in the DB, even if we weren't selling it anymore.
  before_destroy :did_anyone_buy_this_thing?

  has_attached_file :avatar, styles: { medium: '300x300', thumb: '100x100>' }, default_url: "missing_:style.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true, uniqueness: { scope: :brand_id }
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :description, presence: true, length: { minimum: 15 }
  validates :reviews, length: { minimum: 15 }

  validates :brand, :category, presence: true

  def self.search_by_name_or_description(search_term)
    where("name LIKE ? OR description LIKE ?", "%#{search_term}%", "%#{search_term}%")
  end

  private

    def did_anyone_buy_this_thing?
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items Present')
        return false
      end
    end

end

# == Schema Information
#
# Table name: products
#
#  id                  :integer          not null, primary key
#  name                :string
#  price               :decimal(, )
#  quantity            :integer
#  description         :text
#  reviews             :text
#  brand_id            :integer
#  category_id         :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  avatar_file_name    :string
#  avatar_content_type :string
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#
# Indexes
#
#  index_products_on_brand_id     (brand_id)
#  index_products_on_category_id  (category_id)
#
