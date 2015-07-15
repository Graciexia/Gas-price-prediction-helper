$('#car_trany').html("<%= escape_javascript(options_for_select(@tranies)) %>");
$('#car_trany').prop("disabled", false);
$('#car_submit').prop("disabled", true);
