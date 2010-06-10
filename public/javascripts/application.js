$(document).ready(function() {
  $('#mini_calendar').fullCalendar({
    header: {
      left: '',
      center: '',
      right: ''
    },
    events: DAYSOFF_URL
  });
  $('#calendar').fullCalendar({
    events: DAYSOFF_URL
  });
});

