// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
$(function() {

  $('.btn').click(function(){
  	$('.modal .errors').hide()
  });

  $.datepicker.regional['es'] = {
    closeText: 'Ok',
    prevText: '',
    nextText: '',
    currentText: 'Ahora',
    monthNames: ['Enero','Febrero','Marzo','Abril','Mayo','Junio', 'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'],
    monthNamesShort: ['Ene','Feb','Маr','Аbr','Маy','Jun', 'Jul','Аgo','Sep','Оct','Nov','Dic'],
    dayNames: ['Lunes','Martes','Miercoles','Jueves','Viernes','Sabado','Domingo'],
    dayNamesShort: ['Lun','Mar','Mie','Jue','Vie','Sab','Dom'],
    dayNamesMin: ['Lu','Ma','Mi','Ju','Vi','Sa','Do'],
    weekHeader: 'Не',
    dateFormat: 'dd/mm/yy',
    firstDay: 1,
    isRTL: false,
    showMonthAfterYear: false,
    yearSuffix: ''
  };

  $.datepicker.setDefaults($.datepicker.regional['es']);

  $.timepicker.regional['es'] = {
    timeOnlyTitle: 'tiempo',
    timeText: 'Tiempo',
    hourText: 'Hora',
    minuteText: 'Minuto',
    secondText: 'Segundo',
    millisecText: 'Milisegundo',
    timezoneText: 'Timezone',
    currentText: 'Ahora',
    closeText: 'Ok',
    timeFormat: 'HH:mm',
    amNames: ['AM', 'A'],
    pmNames: ['PM', 'P'],
    isRTL: false
  };
  $.timepicker.setDefaults($.timepicker.regional['es']);

  $('#datetimepicker').datetimepicker({
    timezone: "-0500"
  });
});