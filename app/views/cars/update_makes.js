$('#car_make').html("<%= escape_javascript(options_for_select(@makes)) %>").prop("disabled", false);
adjust_fields();
