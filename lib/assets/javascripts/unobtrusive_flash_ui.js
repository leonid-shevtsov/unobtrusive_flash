// Unobtrusive flash UI implementation, design agnostic
// Remember to link unobtrusive_flash_ui.css as well
//
// Shows flash messages as translucent bars on top of the page
window.UnobtrusiveFlash.flashOptions = {type: 'notice',
                                        timeout: 0,
                                        clearFlashOnNextRequest: false};

(function() {

  function hideFlash($flash) {
    $flash.slideUp(100,function(){
      $flash.remove();
    });
  }

  function flashContainer() {
    return $('#unobtrusive-flash-messages');
  };

  UnobtrusiveFlash.showFlashMessage = function(message, options) {
    options = $.extend(UnobtrusiveFlash.flashOptions, options);

    var $flash = $('<div class="unobtrusive-flash-message-wrapper unobtrusive-flash-'+options.type+'"><div class="unobtrusive-flash-message">'+message+'</div></div>');
    var $flashContainer  = flashContainer();
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

  function isCommand(params) {
    return typeof params.command !== "undefined";
  };

  function clearFlash() {
    flashContainer().children('div.unobtrusive-flash-message-wrapper').remove();
  };

  UnobtrusiveFlash.executeCommand = function(commandName) {
    switch (commandName) {
      case "clear flash":
        if (UnobtrusiveFlash.flashOptions.clearFlashOnNextRequest) {
          clearFlash();
        }
        break;
    }
  }

  flashHandler = function(e, params) {
    if (isCommand(params)) {
      UnobtrusiveFlash.executeCommand(params.command);
    } else {
      UnobtrusiveFlash.showFlashMessage(params.message, {type: params.type});
    }
  };

  $(window).bind('rails:flash', flashHandler);

})();
