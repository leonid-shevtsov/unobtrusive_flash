//=require turbolinks
//=require unobtrusive_flash
//=require_self

// simple handler to log all flashes into a variable accessible from the test suite
loggingFlashHandler = function(e, params) {
  if (typeof(window.flashMessages) == 'undefined') window.flashMessages = [];
  window.flashMessages.push(params);
};

$(window).bind('rails:flash', loggingFlashHandler);
