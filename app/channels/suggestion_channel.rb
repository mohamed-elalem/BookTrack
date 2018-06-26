class SuggestionChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'suggestions'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
