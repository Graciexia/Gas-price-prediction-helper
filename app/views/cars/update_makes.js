$('#car_make').html("<%= escape_javascript(options_for_select(@makes)) %>").prop("disabled", false);
$('#car_model').val("Select model...").prop("disabled", true)
$('#car_trany').val("Select transmission...").prop("disabled", true);
$('#car_submit').prop("disabled", true);
