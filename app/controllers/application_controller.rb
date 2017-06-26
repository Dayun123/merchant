class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :num_cart_items

  # displays in the _navbar_links view, so it made since to put this here.
  def num_cart_items
    if session[:cart_id]
      # Get the cart associated with this session, then create an array of the quantities of each line item, then sum this to get the total items in the cart.
      @num_items = Cart.find(session[:cart_id]).line_items.map { |item| item.quantity }.sum.to_s
    else
      @num_items = '0'
    end
  end

end
