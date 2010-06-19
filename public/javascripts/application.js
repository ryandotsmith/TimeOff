$(document).ready(function() {
  $('#mini_calendar').fullCalendar({
    height: 50,
    width: 50,
    events: DAYSOFF_URL
  });

  $('#calendar').fullCalendar({
    height: 500,
    events: DAYSOFF_URL
  });

  $("#menu > a").click(function(){
    var iD = $(this).attr('href');
    $(iD).slideToggle();
    return false;
  });

  $("input[name='dayoff[leave_length]']").click( function() {
    if ($("input[name='dayoff[leave_length]']:checked").val() == 'many')
    $("#end_time").show();

		else if ($("input[name='dayoff[leave_length]']:checked").val() == 'whole')
		{
			$("#end_time").hide();
			$("input[id=dayoff_end_time]").val("")
		}
		else if ($("input[name='dayoff[leave_length]']:checked").val() == 'half')
		{
			$("#end_time").hide();
			$("input[id=dayoff_end_time]").val("")			
		}
		$(this).blur();
	});		


});

