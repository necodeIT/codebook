if (window.matchMedia && window.matchMedia("(prefers-color-scheme: dark)").matches) {
  var r = document.querySelector(":root");
  r.style.setProperty("--primary", "#1d1d1d");
  r.style.setProperty("--secondary", "#2a2a2a");
  r.style.setProperty("--tertiary", "#444444");
  r.style.setProperty("--accent", "#8e45f6");
  r.style.setProperty("--text", "#fff");
  r.style.setProperty("--button-text", "#fff");
}
