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
  after_update_commit { broadcast_update }

  enum status: { offline: 0, away: 1, online: 2 }

  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :messages
  # rubocop:enable Rails/HasManyOrHasOneDependent

  def broadcast_update
    broadcast_replace_to 'user_status', partial: 'users/status', user: self
  end

  def status_to_css
    case status
    when 'online'
      'bg-success'
    when 'away'
      'bg-warning'
    else
      'bg-dark'
    end
  end

  def display_avatar
    return avatar if avatar.attached?

    'avatar.svg'
  end
end
