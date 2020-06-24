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

  def save_tags(tag_list)
    delete_count = 0
    if tag_list.empty?

      if post_tag = PostTag.where(post_id: self.id)
        post_tag.delete_all
      end
    end
    tag_list.uniq.each do |tag|
      # 受け取った値を小文字に変換して、DBを検索して存在しない場合は
      # find_tag に nil が代入され　nil となるのでタグの作成が始まる
      unless find_tag = Tag.find_by(tag_name: tag.downcase)
        begin
          # create メソッドでタグの作成
          # create! としているのは、保存が成功しても失敗してもオブジェクト
          # を返してしまうため、例外を発生させたい
          self.tags.create!(tag_name: tag)

        # 例外が発生すると rescue 内の処理が走り nil となるので
        # 値は保存されないで次の処理に進む
        rescue
          nil
        end
      else

        if delete_count == 0
        post_tag = PostTag.where(post_id: self.id)
        post_tag.delete_all
        delete_count = 1
        end
            # DB にタグが存在した場合、中間テーブルにブログ記事とタグを紐付けている
        PostTag.create!(post_id: self.id, tag_id: find_tag.id)

      end
    end
  end

end