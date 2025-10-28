// Mark a visitor as "human" so Nginx can relax rate limits
$(function() {
  if (document.cookie.indexOf("hs=") === -1) {
    $.ajax({
      url: "/_hs",
      method: "POST",
      xhrFields: { withCredentials: true }
    });
  }
});