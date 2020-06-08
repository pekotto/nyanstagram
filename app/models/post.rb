class Post < ApplicationRecord

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  attachment :image
  belongs_to :user


  validates :title, presence: true
  validates :content, presence: true, length: {maximum: 200}

 def liked_by?(user)
      likes.where(user_id: user.id).exists?
 end

  def save_tags(tag_list)
    tag_list.each do |tag|
      unless find_tag = Tag.find_by(tag_name: tag.downcase)
        begin
          self.tags.create!(tag_name: tag)
        rescue
          nil
        end
      else
            # DB にタグが存在した場合、中間テーブルにブログ記事とタグを紐付けている
        PostTag.create!(post_id: self.id, tag_id: find_tag.id)
      end
    end
  end

end
