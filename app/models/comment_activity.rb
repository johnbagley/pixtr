class CommentActivity < Activity

  def email 
    actor.email 
  end

  def image_name
    target.name
  end 

  def image
    target
  end

end