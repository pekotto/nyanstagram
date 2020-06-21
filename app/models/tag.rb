class Tag < ApplicationRecord
  before_save :downcase_tag_name

  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :tag_name, presence: true, uniqueness: true, length: { maximum: 20 }

    private
    # タグ名を小文字に変換
    def downcase_tag_name
      self.tag_name.downcase!
    end
end