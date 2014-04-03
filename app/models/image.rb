class Image < ActiveRecord::Base
  belongs_to :gallery
  has_many :comments, dependent: :destroy

  has_many :group_images, dependent: :destroy
  has_many :groups, through: :group_images

  has_many :likes, as: :likable

  has_many :taggings
  has_many :tags,
    through: :taggings

  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true

  def user
    gallery.user
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(tag_string)
    tag_string.split(",").each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name.strip.downcase)
      tags << tag
    end
  end
end