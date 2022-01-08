import places from 'places.js';

const initAutocomplete = () => {
  const addressOriginInput = document.getElementById('move_depart');
  if (addressOriginInput) {
    places({ container: addressOriginInput });
  }
  const addressDestinationInput = document.getElementById('move_arrivee');
  if (addressDestinationInput) {
    places({ container: addressDestinationInput });
  }
};

export { initAutocomplete };
