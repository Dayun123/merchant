class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :category

  has_attached_file :avatar, styles: { medium: '300x300', thumb: '100x100>' }, default_url: "missing_:style.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true, uniqueness: { scope: :brand_id }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :description, presence: true, length: { minimum: 15 }
  validates :reviews, length: { minimum: 15 }

  validates :brand, :category, presence: true

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
