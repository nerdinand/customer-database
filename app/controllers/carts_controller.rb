class CartsController < ApplicationController
  def show
    @cart = Cart.from_session(session)
  end

  def update
    product_id = params['cart']['product_id']
    @cart = Cart.from_session(session)
    @cart.product_ids << product_id

    session[:cart] = @cart

    flash[:notice] = 'Product added to cart.'
    redirect_to products_path
  end

  def check_out
    @cart = Cart.from_session(session)

    if @cart.empty?
      flash[:alert] = 'No products in cart.'

      redirect_to cart_path
    end
  end

  def confirm_check_out
    @cart = Cart.from_session(session)
    @cart.customer_id = params[:cart][:customer_id]
    @cart.check_out!

    flash[:notice] = 'Order created successfully.'
    session[:cart] = Cart.new

    redirect_to products_path
  end
end
