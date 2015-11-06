window.UnobtrusiveFlash = {};

(function() {
  // Delete the cookie regardless of the domain it was set from
  // Partial credit to http://stackoverflow.com/a/2959110/6678
  function nukeCookie(cookieName) {
      var yesterday = new Date();
      yesterday.setDate(yesterday.getDate() - 1);
      var hostParts = window.location.hostname.split('.').reverse();
      var expireHost = hostParts.shift();
      $.each(hostParts, function(i,part) {
        expireHost = part + '.' + expireHost;
        document.cookie = cookieName+'=; path=/;expires='+yesterday+'; domain='+expireHost;
      });
      document.cookie = cookieName+'=; path=/;expires='+yesterday+'; domain=';
  }

  // Extracts flash array stored in cookie and clears the cookie
  function extractFlashFromCookies() {
    var data = null;
    if (document.cookie && document.cookie !== '') {
      var cookies = document.cookie.split(';');
      var name = 'flash';
      var cookieValue = null;

      for (var i = 0; i < cookies.length; i++) {
          var cookie = jQuery.trim(cookies[i]);
          if (cookie.substring(0, name.length + 1) == (name + '=')) {
            // replace fixes problems with Rails escaping. Duh.
            cookieValue = decodeURIComponent(cookie.substring(name.length + 1).replace(/\+/g,'%20'));
            if (cookieValue.length > 0) break; // there might be empty "flash=" cookies
          }
      }

      try {
        data = $.parseJSON(cookieValue);
      } catch(e) {
      }

      nukeCookie('flash');
    }

    return data;
  }

  window.UnobtrusiveFlash.showFlash = function(flashMessages) {
    if (flashMessages !== null) {
      $.each(flashMessages, function(_, flashMessage) {
        $(window).trigger('rails:flash', {type: flashMessage[0], message: flashMessage[1]});
      });
    }
  };

  // Reads flash messages from cookies and fires corresponding events
  window.UnobtrusiveFlash.showFlashFromCookies = function() {
    UnobtrusiveFlash.showFlash(extractFlashFromCookies());
  };

  // We want to remove cookies from the flash as soon as possible, but we only want to show then after all the scripts have loaded,
  // including any flash handlers
  var pageCookies = extractFlashFromCookies();
  $(window).load(function() {
    UnobtrusiveFlash.showFlash(pageCookies);
  });

  $(document).on('page:change page:load', UnobtrusiveFlash.showFlashFromCookies);

  $(document).ajaxComplete(function(event,request,options) {
    UnobtrusiveFlash.showFlashFromCookies();
  });
})();
