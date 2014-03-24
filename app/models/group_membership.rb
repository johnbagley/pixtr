class GroupMembership < ActiveRecord::Base

  belongs_to :member, class_name: "User"
  belongs_to :group

  validates :group_id,
    uniqueness: { scope: :member_id }


end