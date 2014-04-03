class FollowingRelationshipActivity < Activity 

  def follower_email
    actor.email
  end

  def followed_user_email
    target.email
  end
end