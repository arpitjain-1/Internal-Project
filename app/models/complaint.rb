class Complaint < ApplicationRecord
  belongs_to :user
  belongs_to :complaint_type

  has_one_attached :proof_image

  validates :complaint_type, :description, :complaint_type, presence: true
end
