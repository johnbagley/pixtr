class LikeActivity < Activity

  def email
    subject.user.email
  end

  def image_name
    subject.image.name
  end

  def image
    subject.image
  end



end