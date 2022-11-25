class UsersController < ApplicationController
  #rescue error
rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def show
    user = User.find_by(id: params[:id])
    render json: user, include: :items
  end

  
  private

  #Handle not_found errors
  def handle_not_found
    render json: {error: "User not found"}, status: :not_found
  end

end
