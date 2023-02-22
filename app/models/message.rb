class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create_commit { broadcast_append_to room }

  before_create :confirm_participant

  has_many_attached :attachments, dependent: :destroy

  def chat_attachment(index)
    target = attachments[index]
    return unless attachments.attached?
    return target if %w[image/gif].include?(target.content_type)

    target.variant(resize_to_limit: [150, 150]).processed
  end

  def confirm_participant
    return unless room.is_private

    is_participant = Participant.where(user_id: user.id, room_id: room.id).first
    throw :abort unless is_participant
  end

  def today?
    created_at.to_date.eql? Date.current
  end

  def this_week?
    created_at >= Date.current.at_beginning_of_week
  end

  def this_year?
    created_at.year.eql? Date.current.year
  end

  def display_time
    return created_at.strftime('%H:%M') if today?
    return created_at.strftime('%A %H:%M') if this_week?
    return created_at.strftime('%d %b %H:%M') if this_year?

    created_at.strftime('%d %b %Y %H:%M')
  end
end
