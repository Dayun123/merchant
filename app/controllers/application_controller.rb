class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :num_cart_items

  # displays in the _navbar_links view, so it made since to put this here.
  def num_cart_items
    if session[:cart_id]
      @num_items = Cart.find(session[:cart_id]).line_items.length.to_s
    else
      @num_items = '0'
    end
  end

end
