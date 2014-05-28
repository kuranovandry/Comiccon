/**
* SHOW TABS
**/
function showPop(objectId,e){
xOffset = -10;
        yOffset = -40;        

$("#"+objectId).css("display","inline");
        $("#"+objectId)
            .css("top",(e.pageY - xOffset) + "px")
            .css("left",(e.pageX + yOffset) + "px")
            .fadeIn("slow");    

}

/* Senthil added this to use the parent() function to operate of the current go create pop  */
function showPopGoCreate(objectId,e,obj){
        xOffset = -10;
        yOffset = -40;        

        $(obj).parent().find("#"+objectId).css("display","inline");
        $(obj).parent().find("#"+objectId)
            .css("top",(e.pageY - xOffset) + "px")
            .css("left",(e.pageX + yOffset) + "px")
            .fadeIn("fast");    

}

this.imagePreview = function(matter,matter_id){    
    /* CONFIG */
        
        xOffsetX = 12;
        yOffsetY = 40;
        var differenceWidth=0;
                
    /* END CONFIG */
    $(".preview").hover(function(e){
        //if ($(this).find('td.sload').length == 0){
        //  $('td.sload').remove();
        //    $(this).prepend('<td class="sload"><img src="/images/icons/sload.gif"></td>');
          $("#preview").remove();
        //}
//        $.data(this, "timer", setTimeout($.proxy(function() {
        
            this.title='';
            if (typeof matter_id === "undefined"){
              var id = $(this).data(matter + "_id");
            }
            else{
              var id = matter_id
            }
            var type=$(this).data("type");
            
            $.get('/' + matter +'_hover/' + id,function(reply,obj){
                var bodyContent = reply;
                differenceWidth=parseInt($(window).width())-parseInt(e.pageX);
                if(differenceWidth<450){
                    yOffsetY=-400;
                }else{
                    yOffsetY=-500;
                    }
                /* TYPE SHOULD BE (E,T,F) like data-type="E" */
                
               
                $("body").append('<div  class="otbox" id="preview"><img src="/images/icons/quit.png" class="close-pre fr" width=24/>'+bodyContent+'</div>');                                 
                
                if(type!="E"){
                    $("#preview").css("width","320px");
                    $(".previewBox").css("width","280px");
                    yOffsetY=-400;
                }else{
                    $("#preview").css("width","730px");
                    $(".previewBox").css("width","700px");
                }
        
                $("#preview")
                    .css("top",(e.pageY - xOffsetX) + "px")
                    .css("left",(e.pageX + yOffsetY) + "px")
                    .fadeIn("fast");
               
            });
//        $('td.sload').remove();
//        clearTimeout($.data(this, "timer"));
//        }, this), 1500));
        

    },function(){
          //clearTimeout($.data(this, "timer"));
//          $('td.sload').remove();
          
          $(".close-pre").click(function(){
                $("#preview").remove();
            });
    });
    
    /*
    $(".preview").mousemove(function(e){
        differenceWidth=parseInt($(window).width())-parseInt(e.pageX);
        if(differenceWidth<450){
            yOffsetY=-400;
        }else{
            yOffsetY=40;
            }
        $("#preview")
            .css("top",(e.pageY - xOffsetX) + "px")
            .css("left",(e.pageX + yOffsetY) + "px");
    });        */

};

function storeThemeInSession(){ 

          var themeColor = selectColorData("theme");
          var bgColor = selectColorData("bg");
          var waColor = selectColorData("wa");
          $.cookie('themeColor', themeColor , { path: '/' });
          $.cookie('bgColor', bgColor , { path: '/' });
          $.cookie('waColor', waColor , { path: '/' });          
          info("Message","Saved your selection!.\ Theme Color : " + themeColor + ", Background Color : " + bgColor + ", Work Area Color : " + waColor);

}

function selectColorData(what){
  var temp = $("ul#" + what + "-color > li.theme-colrs-active > span").data(what);
  if (what == "bg"){
    var sub = "background";
  }else if (what == "theme"){
    var sub = "accent";
  }else if (what == "wa"){
    var sub = "workarea";
  }
  
  if (temp == null){
    info('Select a color for ' + sub,'You have not chosen a color for ' + sub + ', Please choose!');
    throw "stop execution";
  }else{
    return temp;
  }
}
function activateTheme(removeClass,objectId,what){

/* REMOVE ALL ACTIVE THEME MENU CLASS NAME */
    $("#"+objectId).parent().parent().find("li").removeClass("theme-colrs-active");
    /* ADD ACTIVE THEME MENU CLASS NAME */
    $("#"+objectId).parent().addClass("theme-colrs-active");
    var col = $("#"+objectId).data(what);
    if (what == "theme"){ setThemeColor(col); }
    else if (what == "bg"){ setBGColor(col); }
    else if (what == "wa"){ setWAColor(col); }

}

unction setThemeColor(theme){
    /* APPLY THEMES */
    switch(theme){
        case "yellow":{
            mainColor="#FFC20E";
            thickColor="#DDA600";
            lightColor="#FFCD37";
            lightestColor="#FFFFCD";
            break;
        }
        case "blue":{
            mainColor="#2A88C8";
            thickColor="#00336C";
            lightColor="#3BA7F2";
            lightestColor="#E8F0FD";
            break;
        }
        case "orange":{
            mainColor="#FF6501";
            thickColor="#EA7500";
            lightColor="#FF9E3E";
            lightestColor="#FFEFDF";
            break;
        }
        case "green":{
            mainColor="#22B14C";
            thickColor="#177232";
            lightColor="#37D968";
            lightestColor="#D5FFD5";
            break;
        }
        case "violet":{
            mainColor="#713F98";
            thickColor="#682C91";
            lightColor="#915BBB";
            lightestColor="#EBE1F2";
            break;
        }
        case "pink":{
            mainColor="#C8158D";
            thickColor="#A61176";
            lightColor="#DF27AA";
            lightestColor="#FAD1ED";
            break;
        }
        case "red":{
            mainColor="#cc0000";
            thickColor="#a40000";
            lightColor="#d95151";
            lightestColor="#f5e8e8";
            break;
        }
        case "darkorange":{
            mainColor="#ce5c00";
            thickColor="#853010";
            lightColor="#eecdaa";
            lightestColor="#FFEFDF";
            break;
        }
    }
    $("#header").css({"background":mainColor,"border-bottom-color":thickColor});
    $(".btnp").css({"background":mainColor,"border-color":thickColor});
    $(".theme").css({"background":mainColor});
    $(".uibox").css({"background":lightColor,"border-color":mainColor});
    $(".otbox,.tab-content,.tab-menus .active-tab,.tab-menus li:hover,.tab-menus1 .active-tab,.tab-menus1 li:hover").css({"background":lightestColor});
    $(".btnpd").css({"background":lightColor,"border-color":mainColor,"color":mainColor});
    $(".tb-stylev tr th,.theme-l,theme-ls").css({"background":lightColor,"color":thickColor});


    
    $(".uibox").hover(function(){
        $(this).css({"background":"#fff"});
            $(".uiboxs").css({"background":"#fff"});
        },function(){
            $(".uibox").css({"background":lightColor,"border-color":mainColor});
    });
    
    $(".tab-menus li,.tab-menus1 li").click(function(){
        $(".tab-menus li,.tab-menus1 li").css({"background":"#EAEAEA"});
        $(".tab-menus .active-tab,.tab-menus1 .active-tab").css({"background":lightestColor});
    },function(){
        $(this).css({"background":lightestColor});
    });
}