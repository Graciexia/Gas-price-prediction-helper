$('#car_model').html("<%= escape_javascript(options_for_select(@models)) %>");
adjust_fields();
