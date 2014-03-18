class ImagesController < ApplicationController

  def new
    @gallery = current_user.galleries.find(params[:gallery_id])
    @image = Image.new
  end

  def create
    @gallery = current_user.galleries.find(params[:gallery_id])
    @image = @gallery.images.new(image_params)
    if @image.save
      redirect_to @gallery
    else
      render :new
    end
  end

  def show
    @image = Image.find(params[:id])
    @comment = Comment.new
    @comments = @image.comments.recent.page(params[:page]).per(2)
  end

  def edit
    @image = current_user.images.find(params[:id])
  end

  def update
    @image = current_user.images.find(params[:id])
    if @image.update(image_params)
      redirect_to @image
    else 
      render :edit
    end
  end

  def destroy
    image = current_user.images.find(params[:id])
    image.destroy
    redirect_to gallery_path(image.gallery_id)
  end

  private

  def image_params
    params.require(:image).permit(
      :name,
      :url,
      :description
    )
  end

end