class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar

  validates :avatar, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                     allow_nil: true

  scope :all_except, ->(user) { where.not(id: user) }

  after_create_commit { broadcast_append_to 'users' }

  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :messages
  # rubocop:enable Rails/HasManyOrHasOneDependent
end
