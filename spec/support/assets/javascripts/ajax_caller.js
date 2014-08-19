// FIXME doublewrap to get around issue #19 for the time being
$(function() {
  $(window).load(function() {
    $.get('/test/ajax_flash');
    $('<span>Page loaded</span>').appendTo('body');
  });
});
