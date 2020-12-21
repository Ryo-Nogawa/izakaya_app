class MessagesController < ApplicationController

  def index
    @message = Message.new
    @messages = Message.includes(:user).order(created_at: :DESC)
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      # ActionCable.server.broadcast 'message_channel', content: @message
      redirect_to messages_path
    end
  end

  private
  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end
