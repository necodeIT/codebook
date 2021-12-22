const codeKeyword = "?code=";
const paramSplitter = "&";
const url = window.location.href;

var code = "";

if (url.includes(paramSplitter) && url.includes(codeKeyword)) code = url.substring(url.indexOf(codeKeyword) + codeKeyword.length, url.lastIndexOf(paramSplitter));
else if (url.includes(codeKeyword)) code = url.substring(url.indexOf(codeKeyword) + codeKeyword.length);

function openCodeBook() {
  window.location.assign(`codebook://${codeKeyword}${code}`);
}

window.onload = openCodeBook;
