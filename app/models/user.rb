class User < ActiveRecord::Base
  include Clearance::User

  has_many :activities

  has_many :galleries
  
  has_many :images, 
    through: :galleries

  has_many :group_memberships, 
    foreign_key: :member_id
  
  has_many :groups,  # 4 methods: groups, groups=, group_ids, group_ids=
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
    source: :image

  def follow(user)

    # followed_users << user 
    followed_user_relationship = followed_user_relationships.create(
      followed_user: user
    )
    notify_followers(followed_user_relationship, "FollowingRelationshipActivity")
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
    notify_followers(group_membership, "JoinGroupMembershipActivity")
    # followers.each do |follower|
    #   follower.activities.create(
    #     subject: group_membership,
    #     type: "JoinGroupMembershipActivity")
    # end
  end

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

  def like(image)
    # liked_images << image
    like = likes.create(image: image)
    notify_followers(like, "LikeActivity")

    # followers.each do |follower|
    #   follower.activities.create(
    #     subject: like, 
    #     type: "LikeActivity")
    # end

  end

  def likes?(image)
    liked_image_ids.include? image.id
  end

  def unlike(image)
    liked_images.destroy(image)
  end

  def notify_followers(subject, type)
    followers.each do |follower|
      follower.activities.create(
        subject: subject, 
        type: type
        )
    end
  end

end
