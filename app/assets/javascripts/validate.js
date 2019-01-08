$(function() {
  $(document).on('click', 'input[type=submit]', function() {
    if (($('input[type=text]').val() == '') && ($('input[type=file]').val() == '')){
      return false;
    }
  })
})

