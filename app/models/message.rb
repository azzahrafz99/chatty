class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit { broadcast_append_to room }

  before_create :confirm_participant

  def confirm_participant
    return unless room.is_private

    is_participant = Participant.where(user_id: user.id, room_id: room.id).first
    throw :abort unless is_participant
  end

  def today?
    created_at.to_date == Date.current
  end

  def display_time
    return created_at.strftime('%H:%M') if today?

    created_at.strftime('%A %H:%M')
  end
end
