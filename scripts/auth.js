code = window.location.href.split("?code=")[1];
window.location.assign(`codebook://?code=${code}`);
