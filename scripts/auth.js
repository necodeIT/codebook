code = window.location.href.split("?code=")[1];

function openCodeBook() {
  window.location.assign(`codebook://?code=${code}`);
}
