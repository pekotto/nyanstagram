class Post < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image
  belongs_to :user


  validates :title, presence: true
  validates :content, presence: true, length: {maximum: 200}

 def liked_by?(user)
      likes.where(user_id: user.id).exists?
 end

end
