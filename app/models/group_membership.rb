class GroupMembership < ActiveRecord::Base

  belongs_to :member, class_name: "User"
  belongs_to :group

  has_many :activities, as: :subject, dependent: :destroy
  
  validates :group_id,
    uniqueness: { scope: :member_id }


end