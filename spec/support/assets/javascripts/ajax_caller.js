$(function() {
  $.get('/test/ajax_flash');
  $('<span>Page loaded</span>').appendTo('body');
});
