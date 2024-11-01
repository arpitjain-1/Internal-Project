class ComplaintType < ApplicationRecord
    has_many :complaints
  
    validates :name, presence: true, uniqueness: true
  end
  