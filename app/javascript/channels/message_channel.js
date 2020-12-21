import consumer from "./consumer"

consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const html = `
                <div class="mymessage">
                <div class="mymessage-nickname">
                  <a href="/users/${messages.user_id}>${messages.nickname}</a>
                </div>
                <div class="mymessage-content">
                  ${messages.content}
                </div>
                <div class="mymessage-daytime">
                  ${messages.created_at.strftime("%Y/%m/%d %H:%M")}
                </div>
              </div>
      `;
    const messages = document.getElementById('messages');
    const newMessage = document.getElementById('message_content');
    messages.insertAdjacentHTML('afterbegin', html);
    newMessage.value = '';
  },
});
