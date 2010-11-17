// This requires jQuery at least for now

$(function() {
  function hideFlash($flash) {
    $flash.slideUp(100,function(){$flash.remove()});
  }

  $.flash = function(message, options) {
  
    options = $.extend({type: 'notice', timeout: 5000}, options);

    var $flash = $('<div class="flash-message flash-'+options.type+' invisible"><div class="message">'+message+'</div></div>');

    $('#flash-messages').prepend($flash);
    $flash.slideDown(100);

    $flash.click(function() {
      hideFlash($flash);
    });

    if (options.timeout>0) {
      setTimeout(function() {
        hideFlash($flash);
      },options.timeout);
    }
  }

  $('html').ajaxSuccess(function(event,request,options) {
    var header = request.getResponseHeader('X-Flash-Messages');
    if (header != null) {
      var data = $.parseJSON(header);
      if (typeof(data)=='object' && data!=null) {
        $.each(data, function(k,v) {
          $.flash(v, {type: k});
        });
      }
    }
  });
});
