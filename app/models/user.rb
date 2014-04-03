class User < ActiveRecord::Base
  include Clearance::User


  has_many :comments

  has_many :activities

  has_many :galleries
  
  has_many :images, 
    through: :galleries

  has_many :group_memberships, 
    foreign_key: :member_id
  
  has_many :groups,  
    through: :group_memberships

  has_many :followed_user_relationships, 
    foreign_key: :follower_id, 
    class_name: "FollowingRelationship"
  
  has_many :followed_users, 
    through: :followed_user_relationships

  has_many :follower_relationships, 
    foreign_key: :followed_user_id, 
    class_name: "FollowingRelationship"

  has_many :followers, 
    through: :follower_relationships

  has_many :likes, dependent: :destroy
  has_many :liked_images, through: :likes,
    source: :likable, source_type: "Image"

  def follow(user)

    # followed_users << user 
    followed_user_relationship = followed_user_relationships.create(
      followed_user: user
    )
    delay.notify_followers(followed_user_relationship, user, "FollowingRelationshipActivity")
    # followed_users.each do |followed_user| 
    #   followed_user.activities.create(
    #     subject: followed_user_relationship,
    #     type: "FollowingRelationshipActivity")
    # end
  end

  def following?(user)
    followed_user_ids.include? user.id
  end

  def unfollow(user)
    followed_users.destroy(user)
  end

  def join(group)
    # groups << group 
    group_membership = group_memberships.create(group: group)
    delay.notify_followers(group_membership, group, "JoinGroupMembershipActivity")
  end
    # followers.each do |follower|
    #   follower.activities.create(
    #     subject: group_membership,
    #     type: "JoinGroupMembershipActivity")
    # end
  

  def leave(group)
    group_membership_ids.include? group.id
    groups.destroy(group)
  end

  def joined?(group)
    group_ids.include? group.id
  end

  # def like(image)
  #   likes.create(image_id: image.id)
  # end

  def like(target)
    # liked_images << image
    like = likes.create(likable: target)
    delay.notify_followers(like, target, "LikeActivity")

    # followers.each do |follower|
    #   follower.activities.create(
    #     subject: like, 
    #     type: "LikeActivity")
    # end

  end

  def likes?(target)
    # liked_image_ids.include? image.id
    likes.exists?(likable: target)
  end

  def unlike(target)
    like = likes.find_by(likable: target)
    like.destroy
  end

  def notify_followers(subject, target, type)
    if subject.persisted?
      followers.each do |follower|
        follower.activities.create(
          subject: subject, 
          type: type,
          target: target,
          actor: self
          )
        ActivityMailer.activity_email(subject).deliver
      end
    end
  end

  def member?(group)
    group_ids.include? group.id
  end
end
