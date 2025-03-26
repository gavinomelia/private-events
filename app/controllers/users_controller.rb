class UsersController < ApplicationController
  def index
  end

  def show
    @events = Event.where(creator_id: params[:id])
    @user = User.find(params[:id])
  end
end
