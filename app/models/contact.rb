class Contact < ApplicationRecord

  validates :email, presence: true, length: {maximum:255}
  validates :message, presence: true
end
