import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMapbox = () => {
  const mapElement = document.getElementById('map');


  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 14, duration: 0 });
  };

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup({ closeOnClick: false, closeButton: false}).setHTML(marker.info_window);
      new mapboxgl.Marker({ color: "#63320F"})
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(map);
    });

    fitMapToMarkers(map, markers);

    const start = [markers[0].lng, markers[0].lat];
    const end = [markers[1].lng, markers[1].lat];

    async function getAndDisplayRoute(start, end) {
      // an arbitrary start will always be the same
      // only the end or destination will change
      const query = await fetch(
        `https://api.mapbox.com/directions/v5/mapbox/driving-traffic/${start[0]},${start[1]};${end[0]},${end[1]}?steps=true&geometries=geojson&language=fr&access_token=${mapboxgl.accessToken}`,
        { method: 'GET' }
      );
      const json = await query.json();
      const data = json.routes[0];
      const route = data.geometry.coordinates;
      const geojson = {
        type: 'Feature',
        properties: {},
        geometry: {
          type: 'LineString',
          coordinates: route
        }
      };
      // if the route already exists on the map, we'll reset it using setData
      if (map.getSource('route')) {
        map.getSource('route').setData(geojson);
      }
      // otherwise, we'll make a new request
      else {
        map.addLayer({
          id: 'route',
          type: 'line',
          source: {
            type: 'geojson',
            data: geojson
          },
          layout: {
            'line-join': 'round',
            'line-cap': 'round'
          },
          paint: {
            'line-color': '#FF8906',
            'line-width': 5,
            'line-opacity': 0.75
          }
        });
      }
      // add turn instructions here at the end
      const instructions = document.getElementById('instructions');

      const distance = Math.floor(data.distance / 1000)
const steps = data.legs[0].steps;

let tripInstructions = '';
for (const step of steps) {
  tripInstructions += `<li>${step.maneuver.instruction}</li>`;
}
instructions.innerHTML = `<p><strong>Temps de trajet: ${time_convert(Math.floor(
  data.duration / 60
))} min 🚚 </strong></p><p class="faux-lien">Voir l'itinéraire</p> <p> Distance : ${Math.floor(
  data.distance / 1000)} km</p><ul class="hidden" id="instructions-list">${tripInstructions}</ol>`;
    }

    map.on('load', () => {
      // make an initial directions request that
      // starts and ends at the same location
      getAndDisplayRoute(start, end);
    });
  }
};

function time_convert(num) {
  var hours = Math.floor(num / 60);
  var minutes = num % 60;
  return hours + "h" + minutes;
}

export { initMapbox };
