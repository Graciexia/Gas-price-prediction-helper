$('#car_model').html("<%= escape_javascript(options_for_select(@models)) %>");
$('#car_model').prop("disabled", false);
$('#car_trany').val("Select transmission...").prop("disabled", true);
$('#car_submit').prop("disabled", true);
