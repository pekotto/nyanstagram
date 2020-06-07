class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :like_posts, through: :likes, source: :post
  attachment :plofile_image, destroy: false
  belongs_to :favorite_breed

  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}

end