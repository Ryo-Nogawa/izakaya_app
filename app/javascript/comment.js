function comment() {
  const submit = document.getElementById("submit");
  submit.addEventListener("click", (e) => {
    const formData = new FormData(document.getElementById("form"));
    const XHR = new XMLHttpRequest();
    const url = document.getElementById("form").getAttribute("action") + ".json";
    XHR.open("POST", url, true);
    XHR.responseType = "json";
    XHR.send(formData);
    XHR.onload = () => {
      if (XHR.status != 200) {
        alert(`Error ${XHR.status}: ${XHR.statusText}`);
        return null;
      };
      const comment = XHR.response.blog;
      const list = document.getElementById("list");
      const formText = document.getElementById("content");
      const HTML = `
      <p><a href="/users/${comment.user_id}">${comment.nickname}</a></P>
      <p>${comment.comment}</p>
      <P>${comment.created_at}</p>
            `;
    list.insertAdjacentHTML("afterend", HTML);
    formText.value = '';
    };
    e.preventDefault();
  });
};
window.addEventListener('load', comment);