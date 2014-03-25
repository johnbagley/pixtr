class LikeActivity < Activity

  def email
    subject.user.email
  end

  def likable_name
    subject.likable.name
  end

  def likable
    subject.likable
  end



end