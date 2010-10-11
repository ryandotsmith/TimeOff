jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function() {
    var button      = $(this).find("input[type=submit]");
    var origanlText = button.val();
    button.val("loading...");
    $.post(this.action, $(this).serialize(), function(){button.val(origanlText)}, "script");
    return false;
  })
  return this;
};

$(document).ready(function() {

  $(".ajax-form").livequery(function() {
    $(this).submitWithAjax();
  });

  $("a[rel=facebox]").livequery(function(){
    $(this).facebox();
  });

 $("a[rel=fancybox]").fancybox();

  $("#more_link").morePaginate({ container: "#archive-table-body" });

  $('#mini_calendar').fullCalendar({
    height: 50,
    width: 50,
    events: DAYSOFF_URL
  });

  $('#fullcalendar').fullCalendar({
    height: 500,
    buttonText: {
      prev: '&larr;',
      next: '&rarr;'
    },
    events: DAYSOFF_URL,
    eventClick: function(event){
      if (event.current_user_is_manager == true){
        var url = '/users/' + event.user_id + '.js'
        $.facebox({ ajax: url });
      };
    }
  });

  $("#menu > a").click(function(){
    var iD = $(this).attr('href');
    $(this).toggleClass('active');
    $(iD).slideToggle();
    return false;
  });

  $("input[name='dayoff[leave_length]']").livequery(function(){
    $(this).click( function() {
      if ($("input[name='dayoff[leave_length]']:checked").val() == 'many') {
        $(".end_time").show();
      } else if ($("input[name='dayoff[leave_length]']:checked").val() == 'whole') {
        $(".end_time").hide();
        $("input[id=dayoff_end_time]").val("")
      } else if ($("input[name='dayoff[leave_length]']:checked").val() == 'half'){
        $(".end_time").hide();
        $("input[id=dayoff_end_time]").val("")
      }
      $(this).blur();
    })
  });


});

