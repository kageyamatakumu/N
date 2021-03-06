class Item < ApplicationRecord
  belongs_to :brand

  has_many :likes, dependent: :destroy
  has_many :like_items, through: :likes, source: :item

  has_many :browsing_histories, dependent: :destroy
  has_many :browsing_history_items, through: :browsing_histories, source: :item

  mount_uploader :item_image, ItemImageUploader
  mount_uploaders :dress_images, DressImageUploader

  validates :name, presence: true
  validates :description, presence: true
  validates :description, length: { maximum: 150 }
  validates :item_image, presence: true
  FILE_NUMBER_LIMIT = 3
  validate  :validate_number_of_files

  enum status: { published: 0, draft: 1 }

  def draft
    self.status = "draft"
  end

  private

  def validate_number_of_files
    return if dress_images.length <= FILE_NUMBER_LIMIT
    errors.add(:dress_images, "に添付できる画像は#{FILE_NUMBER_LIMIT}件までです。")
  end
end
