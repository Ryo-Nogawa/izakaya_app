function pullDown() {
  const target = document.getElementById("comment-content");
  target.scrollIntoView(false);
};

window.addEventListener('load', pullDown)