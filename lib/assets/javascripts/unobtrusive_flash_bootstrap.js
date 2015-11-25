// Unobtrusive flash UI implementation with Bootstrap 3
// For sites that use Bootstrap http://getbootstrap.com/
//
// Declare a .unobtrusive-flash-container wherever you want the messages to appear
// Defaults to .container, .container-fluid (core Bootstrap classes), or just the body tag, whichever is present

window.UnobtrusiveFlash.flashOptions = {
  type: 'notice',
  timeout: 0,
  mapping: {
    notice: 'info',
    alert: 'warning',
    error: 'danger'
  }
};

(function() {

  UnobtrusiveFlash.showFlashMessage = function(message, options) {
    options = $.extend(UnobtrusiveFlash.flashOptions, options);

    // Workaround for common Rails flash type to match common Bootstrap alert type
    switch (options.type) {
      case 'notice':
      case 'alert':
      case 'error':
        options.type = options.mapping[options.type]
    }

    var $flash = $('<div class="alert alert-'+options.type+' fade in"><button type="button" class="close" data-dismiss="alert">&times;</button>'+message+'</div>');

    var $flashContainer = $($('.unobtrusive-flash-container')[0] || $('.container')[0] || $('.container-fluid')[0] || $('body')[0]);
    $flashContainer.prepend($flash);

    $flash.hide().delay(300).slideDown(100);

    $flash.alert();

    if (options.timeout>0) {
      setTimeout(function() {
        $flash.alert('close');
      },options.timeout);
    }
  };

  var flashHandler = function(e, params) {
    UnobtrusiveFlash.showFlashMessage(params.message, {type: params.type});
  };

  $(window).bind('rails:flash', flashHandler);

})();
