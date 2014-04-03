class GalleryActivity < Activity 

  def user_email
    subject.user.email
  end


  def gallery_name
    target.gallery_name
  end
end