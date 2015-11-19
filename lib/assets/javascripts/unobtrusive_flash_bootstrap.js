// Unobtrusive flash UI implementation with Bootstrap 3
// For sites that use Bootstrap http://getbootstrap.com/
//
// Declare a .unobtrusive-flash-container wherever you want the messages to appear
// Defaults to .container, .container-fluid (core Bootstrap classes), or just the body tag, whichever is present

window.UnobtrusiveFlash.flashOptions = {type: 'notice',
                                        timeout: 0,
                                        clearFlashOnNextRequest: false};

(function() {

  function flashContainer() {
    return $($('.unobtrusive-flash-container')[0] || $('.container')[0] || $('.container-fluid')[0] || $('body')[0]);
  };

  UnobtrusiveFlash.showFlashMessage = function(message, options) {
    options = $.extend(UnobtrusiveFlash.flashOptions, options);

    // Workaround for common Rails flash type to match common Bootstrap alert type
    if (options.type=='notice') {
      options.type = 'info';
    } else if(options.type=='alert') {
      options.type = 'warning';
    } else if(options.type=='error') {
      options.type = 'danger';
    }

    var $flash = $('<div class="alert alert-'+options.type+' fade in"><button type="button" class="close" data-dismiss="alert">&times;</button>'+message+'</div>');

    flashContainer().prepend($flash);

    $flash.hide().delay(300).slideDown(100);

    $flash.alert();

    if (options.timeout>0) {
      setTimeout(function() {
        $flash.alert('close');
      },options.timeout);
    }
  };

  function isCommand(params) {
    return typeof params.command !== "undefined";
  };

  function clearFlash() {
    flashContainer().empty();
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
