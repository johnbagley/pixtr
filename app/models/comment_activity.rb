class CommentActivity < Activity

  def user_email 
    subject.user.email 
  end

  def image_name
    subject.image.name
  end 

  def image
    subject.image
  end

end