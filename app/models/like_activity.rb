class LikeActivity < Activity

  def email
    actor.email
  end

  def likable_name
    target.name
  end

  def likable
    target
  end
end