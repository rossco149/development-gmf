$( document ).ready( function() {
   if($("a.popup").length > 0)
    $("a.popup").lightBox({fixedNavigation: true});

   $(".featured").click();
   prepareContact();

   prepareFilters();

   if ($("#bannerRotator").length > 0)
    bannerRotator('#bannerRotator', 6000, 6000, null);//null results in NO nav bar - true otherwise

   $("a.popup2").click(function(){
      $("a.popup").click()
      
       return false;
   });

   $("#no_js").hide();
   $(".with_js").show();

   if($("#map-canvas").length >0){
    google.maps.event.addDomListener(window, 'load', initialize);
   }

} );


function prepareFilters(){
    $("#remove_filter").hide();
    $("#quote_filter").change(function(){
       $("#quotes li").hide();
       var value = $(this).val();

       if(value == "All"){
           $("#quotes li").show()
       }else
       {
        $("#quotes li."+value).show();
       }

    });

    $("#fireplace_filter").change(function(){
       var path = $(this).attr("path")
       var filter = $(this).val();
       $.get(path+"?filter="+filter, null, function(data){
           $("#fireplace_list").html(data)
       });

    });
}

function prepareContact(){

    var show = ""
    if($("input:hidden[name='show']").length > 0)
        show = $("input[name='show']").val();

   if(show == "")
       show = "map"
   
   $("#map, #form").hide();
   $("#map_show, #form_show").click(function(){
       $("#map, #form").hide();
       var id_to_find = $(this).attr("id").replace("_show", "");
       $("#"+id_to_find).show();

       if(id_to_find == "map")
       {
            $("#map-canvas").show();

            initialize();
       }else
       {
           $("#map-canvas").hide();
       }
       return false;
   });
   
   if(show == "map" || show == "form")
       $("#"+show+"_show").click();
}

function initialize() {
        var mcalpineLatLng = new google.maps.LatLng(55.8517898, -4.2774765);
        var mapOptions = {
          center: mcalpineLatLng,
          zoom: 15
        };
        var map = new google.maps.Map(document.getElementById("map-canvas"),mapOptions);

        var marker = new google.maps.Marker({position: mcalpineLatLng,
                                            map: map,
                                            title:"90 Seaward Street: 0141 420 1392"
        });

        var contentString = '<h4>George McAlpine Fireplaces</h4>';

        var infowindow = new google.maps.InfoWindow({content: contentString});

        marker.setMap(map);

        google.maps.event.addListener(marker, 'click', function() {
            infowindow.open(map,marker);
        });
      }