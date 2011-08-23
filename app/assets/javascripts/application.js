//= require jquery
//= require jquery_ujs
//= require_tree .
$(function() {
  $('p.flash').hide().slideDown();
  
  var question  = $('div.question:last').first().clone(),
      choice    = $('div.choice:last').first().clone();
  
  $('a[data-nested="add"]').live('click', function() {
      var $this = $(this),
          $parent = $this.parent()
          $inputs = $parent.find('div');
      // $inputs..insertAfter($inputs);
      return false;
    });
  // Remove an field
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