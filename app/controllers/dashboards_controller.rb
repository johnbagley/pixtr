class DashboardsController < ApplicationController

  def show 
    @activities = current_user.activities.includes(:actor, :subject, :target) 
  end

end
