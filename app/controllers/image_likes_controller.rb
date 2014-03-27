class ImageLikesController < ApplicationController

  def create
    @image = Image.find(params[:id])
    current_user.like @image
  end

  def destroy
    @image = find_image
    current_user.unlike @image
  end

  private

  def find_image
    Image.find(params[:id])
  end
end