class RandomGalleriesController < ApplicationController

  def show
    gallery = Gallery.all.sample
    redirect_to "/galleries/#{gallery.id}"
  end



end