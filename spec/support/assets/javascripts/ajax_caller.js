$(function() {
  $.get('/test/ajax_flash', function() {
    $('<span>Page loaded</span>').appendTo('body');
  });
});
