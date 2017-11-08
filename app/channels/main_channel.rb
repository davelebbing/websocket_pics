class MainChannel < ApplicationCable::Channel
  def subscribed
    stream_from "pics"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_image(data)
    ActionCable.server.broadcast 'pics', {image_data: data['content']}
  end
end
