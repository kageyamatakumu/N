class Brand < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  mount_uploader :brand_image, BrandImageUploader
  mount_uploader :instagram_image, InstagramUploader

  validates :name, presence: true
  validates :instagram_user_name, presence: true
  validates :instagram_user_name, uniqueness: true
  validates :start_up, presence: true
  validates :brand_description, length: { maximum: 150 }
end
