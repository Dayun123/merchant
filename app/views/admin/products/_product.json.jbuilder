json.extract! product, :id, :name, :price, :quantity, :description, :reviews, :brand_id, :category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
