class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :likes, dependent: :destroy, foreign_key: 'user_id'
  has_many :like_items, through: :likes, source: :item

  has_many :browsing_histories, dependent: :destroy
  has_many :browsing_history_items, through: :browsing_histories, source: :item

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  def like(item)
    like_items << item
  end

  def unlike(item)
    like_items.destroy(item)
  end

  def like?(item)
    like_items.include?(item)
  end

  def my_object?(object)
    object.user_id == id
  end
end
