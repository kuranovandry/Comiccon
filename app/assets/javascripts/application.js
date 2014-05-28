// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap
//= require turbolinks
//= require_tree .
//= require fullcalendar_engine/application

function showInstitution(obj){
   if (obj.options[obj.selectedIndex].text == "Institution"){
    $('.institution').fadeIn(1000);
   }else{
    $('.institution').fadeOut(1000);
   }
}

function selectUpdate(itemId,urlTo,destSel){
  if (itemId.length != 0){
    $(destSel).fadeOut(1000);
                $.ajax({
                    url: urlTo,
                    type: 'GET',
                    dataType: "JSON",
                    success: function( json ) {
                        $(destSel).empty();
                        $(destSel).append('<option value= selected="selected">--Choose--</option>');
                        $.each(json, function(i,value) {                          
                          $(destSel).append($('<option>').text(value.name).attr('value', value.id));
                        });
                    }
                });
    $(destSel).fadeIn(1000); 
  }
}
