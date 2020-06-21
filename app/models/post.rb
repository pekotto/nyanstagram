class Post < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  attachment :image
  belongs_to :user


  validates :title, presence: true
  validates :content, presence: true, length: {maximum: 200}

 def liked_by?(user)
      likes.where(user_id: user.id).exists?
 end

  def save_tags(tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # Destroy old taggings:
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tag_name:old_name)
    end

    # Create new taggings:
    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(tag_name:new_name)
      self.tags << post_tag
    end
  end

end