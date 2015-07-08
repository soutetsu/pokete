class UsersController < ApplicationController
  def rank
    @users = User.order_by_evaluation_points
  end
end
