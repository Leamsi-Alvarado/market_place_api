class Api::V1::OrdersController < ApplicationController
  before_action :check_login, only: %i[index]
  include Paginable
  def index
    @orders = current_user.orders.page(current_page).per(per_page)
    options = get_links_serializer_options('api_v1_orders_path', @orders)
    render json: OrderSerializer.new(current_user.orders, options).serializable_hash
  end

  def show
    order = current_user.orders.find(params[:id])

    if order
      options = {include: [:products]}
      render json: OrderSerializer.new(order, options).serializable_hash
    else
      head 404
    end
  end

  def create
    order = Order.create! user: current_user
    order.build_placements_with_product_ids_and_quantities(order_params[:product_ids_and_quantities])
    if order.save
      OrderMailer.send_confirmation(order).deliver
      render json: order, status: 201
    else
      render json: {errors: order.errors}, status: 422
    end
  end

  private
  def order_params
    params.require(:order).permit(product_ids_and_quantities: [:product_id, :quantity])
  end

end

