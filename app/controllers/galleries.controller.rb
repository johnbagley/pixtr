
class GalleriesController < ApplicationController
  before_action :authorize, except: [:show]
  # after_action :method <-- never used
  # around_action :method <-- never used

  def index
    @galleries = current_user.galleries
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = current_user.galleries.new(gallery_params)
    if @gallery.save
      current_user.followers.each do |follower|
      follower.activities.create(
        subject: @gallery,
        type: 'GalleryActivity'
      )
    end
      redirect_to @gallery
    else
      render :new
    end
  end

  def edit
    @gallery = current_user.galleries.find(params[:id])
  end

  def update
    @gallery = current_user.galleries.find(params[:id])
    if @gallery.update(gallery_params)
      redirect_to gallery_path(@gallery)
    else
      render :edit
    end
  end

  def destroy
    gallery = current_user.galleries.find(params[:id])
    gallery.destroy
    redirect_to root_path
  end

  private

  def gallery_params
    params.require(:gallery).permit(:name)
  end
end