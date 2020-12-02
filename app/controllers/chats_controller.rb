class ChatsController < ApplicationController
  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:name, user_ids: [])
  end
end
