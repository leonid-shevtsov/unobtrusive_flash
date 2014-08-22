// Unobtrusive flash UI implementation, design agnostic
// Remember to link unobtrusive_flash_ui.css as well
//
// Shows flash messages as translucent bars on top of the page
window.UnobtrusiveFlash.flashOptions = {type: 'notice', timeout: 0};

(function(){

  function hideFlash($flash) {
    $flash.slideUp(100,function(){
      $flash.remove();
    });
  }

  UnobtrusiveFlash.showFlashMessage = function(message, options) {
    options = $.extend(UnobtrusiveFlash.flashOptions, options);

    var $flash = $('<div class="unobtrusive-flash-message-wrapper unobtrusive-flash-'+options.type+'"><div class="unobtrusive-flash-message">'+message+'</div></div>');
    var $flashContainer  = $('#unobtrusive-flash-messages');
    if ($flashContainer.length==0) {
      $flashContainer = $('<div/>').attr('id', 'unobtrusive-flash-messages').prependTo('body');
    }
    $flashContainer.prepend($flash);
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

  flashHandler = function(e, params) {
    UnobtrusiveFlash.showFlashMessage(params.message, {type: params.type});
  };

  $(window).bind('rails:flash', flashHandler);

})();
