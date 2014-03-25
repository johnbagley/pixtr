class FollowingRelationship < ActiveRecord::Base
  belongs_to :followed_user, class_name: "User"
  belongs_to :follower, class_name: "User"

  has_many :activities, as: :subject, dependent: :destroy

  validates :followed_user_id,
    uniqueness: {scope: :follower}

  validate :cannot_follow_yourself

  private

  def cannot_follow_yourself
    if followed_user_id == follower_id
      errors.add(:cannot_follow_yourself, "You can't follow yourself.")
    end
  end
  
end
