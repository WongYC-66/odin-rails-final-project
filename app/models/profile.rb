class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :uploaded_image

  validate :acceptable_image
  validates :img_url, length: { minimum: 2 }


  def acceptable_image
    return unless uploaded_image.attached?

    unless uploaded_image.blob.byte_size <= 5.megabyte
      errors.add(:uploaded_image, "is too big")
    end
  end
end
