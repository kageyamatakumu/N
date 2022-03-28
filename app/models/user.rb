class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  # validates :reset_password_token, uniqueness: true, allow_nil: true

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  def my_object?(object)
    object.user_id == id
  end
end
