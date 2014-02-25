// Unobtrusive flash UI implementation with Bootstrap 3
// For sites that use Bootstrap http://getbootstrap.com/
//
// Declare a .unobtrusive-flash-container wherever you want the messages to appear
// Defaults to .container, .container-fluid (core Bootstrap classes), or just the body tag, whichever is present
$(function() {
  var $flashContainer = $($('.unobtrusive-flash-container')[0] || $('.container')[0] || $('.container-fluid')[0] || $('body')[0]);

  $.showFlashMessage = function(message, options) {
    options = $.extend({type: 'notice', timeout: 5000}, options);

    // Workaround for common Rails flash type to match common Bootstrap alert type
    if (options.type=='notice') {
      options.type = 'info';
    } else if(options.type=='alert') {
      options.type = 'warning';
    } else if(options.type=='error') {
      options.type = 'danger';
    }

    var $flash = $('<div class="alert alert-'+options.type+'"><button type="button" class="close" data-dismiss="alert">&times;</button>'+message+'</div>');

    $flashContainer.prepend($flash);

    $flash.hide().delay(300).slideDown(100);

    $flash.alert();

    if (options.timeout>0) {
      setTimeout(function() {
        $flash.alert('close');
      },options.timeout);
    }
  };

  flashHandler = function(e, params) {
    $.showFlashMessage(params.message, {type: params.type});
  };

  $(window).bind('rails:flash', flashHandler);
});