class Like < ActiveRecord::Base
  belongs_to :likable, polymorphic: true
  belongs_to :user

  has_many :activities, as: :subject, dependent: :destroy

  validates :user, presence: true, uniqueness: { scope: [:likable_id, :likable_type] }
  validates :likable, presence: true
    

end