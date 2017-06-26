class OrdersController < ApplicationController

  include CurrentCart
  before_action :authenticate_user!
  before_action :set_cart, only: [:new, :create, :index]

  def index
    # Find all the orders in the DB with the current user ID
    @orders = Order.where(user_id: current_user.id)
    @user_email = current_user.email
  end

  def new

    if @cart.line_items.empty?
      # redirect_to doesn't return, so you must call it explicitly!
      redirect_to shop_url, notice: "Your cart is empty."
      return
    end

    @order = Order.new
    @order.user_id = current_user.id
  end

  def create
    @order = Order.new(order_params)
    @order.user_id = current_user.id
    # Totally magic, deletes the cart_id from each line_item and shovels it into the line_items property of the Order model, which exists because of the has_many association we setup with line_items.
    @order.add_line_items_from_cart(@cart)

    # I think this is where the order_id is added to the line_items, but I have no proof!
    if @order.save
      # Destroy the cart
      Cart.destroy(session[:cart_id])
      session[:cart_id] = nil
      # Redirect them to the store
      redirect_to shop_url, notice: "Thanks for your order!"
    else
      render :new
    end
  end

  def show
    # Find the LineItems associated with the order id
    @line_items = LineItem.where(order_id: params[:id])
    @order_subtotal = LineItem.where(order_id: params[:id]).select("SUM(quantity * price) AS sum")[0].sum
    @order_details = params[:order_details]
  end

  private

    def order_params
      params.require(:order).permit(:name, :address, :pay_type)
    end

end
