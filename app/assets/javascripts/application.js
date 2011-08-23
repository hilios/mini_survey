//= require jquery
//= require jquery_ujs
//= require_tree .
$(function() {
  $('p.flash').hide().slideDown();
  // Add fields
  $('a[data-nested="add"]').live('click', function() {
      var $this = $(this),
          $parent = $this.parent(),
          $fields = $this.data('fields'),
          $association;
      $parent.find('a:last').before(function() {
        var new_id = new Date().getTime(),
            fields = $fields.toString().replace(/new_fields/g, new_id);
        return fields;
      });
      return false;
    });
  // Remove fields
  $('a[data-nested="remove"]').live('click', function() {
    var $this = $(this),
        $parent = $this.parent(),
        $_destroy = $parent.find('input[name*="_destroy"]');
    $parent.hide();
    $_destroy.prop('value', 1);
    return false;
  });
  // Animate the percentages on Answers
  $('div[data-percentage]').each(function(i) {
    var $this = $(this),
        percentage = $this.data('percentage') + "%";
    $('<div />').appendTo($this).delay(i * 5).animate({width: percentage});
  });
});