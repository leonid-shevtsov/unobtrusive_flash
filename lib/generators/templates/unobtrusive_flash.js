// This requires jQuery at least for now
$(function() {
  $('<div id="flash-messages"></div>').prependTo('body');

  function hideFlash($flash) {
    $flash.slideUp(100,function(){
      $flash.remove();
    });
  }

  $.flash = function(message, options) {
  
    options = $.extend({type: 'notice', timeout: 5000}, options);

    var $flash = $('<div class="flash-message flash-'+options.type+'"><div class="message">'+message+'</div></div>');

    $('#flash-messages').prepend($flash);
    $flash.hide().delay(300).slideDown(100);

    $flash.click(function() {
      hideFlash($flash);
    });

    if (options.timeout>0) {
      setTimeout(function() {
        hideFlash($flash);
      },options.timeout);
    }
  };



  function loadFlashFromCookies() {
    if (document.cookie && document.cookie != '') {
      var cookies = document.cookie.split(';');
      var name = 'flash';
      var cookieValue = null;
      var data = null;

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

      if (data!=null) {
        $.each(data, function(i, d) {
          $.flash(d[1], {type: d[0]});
        });
      }

      host = window.location.hostname;

      if (r = host.match(/([^.]+\.[^.]+$)/))
      {
          host = r[1];
      }

      document.cookie = 'flash=; path=/; domain=' + host;
    }
  }

  loadFlashFromCookies();

  $('html').ajaxSuccess(function(event,request,options) {
    loadFlashFromCookies();
  });
});
