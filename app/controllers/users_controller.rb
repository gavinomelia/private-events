class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @created_events = Event.where(creator_id: params[:id])
    @attending_events = @user.events
  end
end
