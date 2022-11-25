class ItemsController < ApplicationController
  #handle 404 exemption
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    #check if the request is from nested route or not
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
    #check if the request is from nested route or not
    if params[:user_id]
      user = User.find(params[:user_id])
      item = user.items.create(item_params)
    else
      item = Item.create(item_params)
    end
    render json: item, status: :created
  end

  private
  #handle not_found error => get the specific model and ID that threw error
  def render_not_found_response(exception)
    render json: {error: "#{exception.model} with ID #{exception.id} not found"}, status: :not_found
  end

  # strong params for create method
  def item_params
    params.permit(:name, :description, :price, :user_id)
  end

end
