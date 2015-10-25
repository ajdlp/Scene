$(document).ready(function(){
    initializeMap();
});

function initializeMap() {
  var mapOptions = {
    zoom: 8,
    mapTypeId:google.maps.MapTypeId.ROADMAP
    };

    var map = new google.maps.Map(document.getElementById("googleMap"),mapOptions);
    setLocation(map);
  };

  var setLocation = function(map) {
   navigator.geolocation.getCurrentPosition(function(position) {
   var userLocation = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
        map.setCenter(userLocation);
        mapSetup(userLocation, map);
   });
 }

  var mapSetup =  function (userLocation, map){

      var userIcon = {
        url: "images/user_icon.png",
        anchor: new google.maps.Point(14,28)
          };
       var userInfowindow = new google.maps.InfoWindow({
        content: '<img class="c-img73 img-circle img-center center-block fl-st" src="/images/user_anon.png"></img>'+'<div class="c ml-2"> Hi! You are here!</div>'
         });
      var userMarker = new google.maps.Marker({
        position: userLocation,
        icon: userIcon,
        infowindow: userInfowindow
      });
      userMarker.setMap(map);
      google.maps.event.addListener(userMarker, 'click', function(){
        userInfowindow.open(map, this);
      });

      var artistIcon =  '/images/artist_icon.png';
       <% @artists.each do |artist|%>
       var markerLatLong = new google.maps.LatLng(<%= artist.latitude%>, <%= artist.longitude %>);

       var myInfowindow = new google.maps.InfoWindow({
        content: '<img class="c-img73 img-circle img-center center-block fl-st" src="<%= artist.avatar%>"></img>'+'<div class="c ml-2">My name is <%= link_to artist.name,artist_path(artist) %></div>'
         });

       var marker = new google.maps.Marker({
        position: markerLatLong,
        icon: artistIcon,
        map: map,
        infowindow:myInfowindow
       });

      google.maps.event.addListener(marker, 'click', function(){
       this.infowindow.open(map, this);
      });
      <% end %>
}