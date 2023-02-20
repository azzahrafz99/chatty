class Room < ApplicationRecord
  validates :name, uniqueness: true
  validates :name, presence: true

  scope :public_rooms, -> { where(is_private: false) }
end
