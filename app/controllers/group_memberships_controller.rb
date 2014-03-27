class GroupMembershipsController < ApplicationController

  def create
    @group = Group.find(params[:id])
    current_user.join @group
    render :change
  end

  def delete
    @group = Group.find(params[:id])
    current_user.leave @group
    render :change
  end


end