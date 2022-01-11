const initPlusMinusButtons = () => {
const buttonPlus = document.querySelectorAll('.plus');
const buttonMoinsRooms = document.querySelectorAll('.moins-rooms');
const buttonMoinsStuffs = document.querySelectorAll('.moins-stuff')
let i = 0;

  buttonPlus.forEach((btn) => {
  btn.addEventListener('click', (e) => {
    e.preventDefault();
    let divPlus = e.target.parentElement.parentElement;
    let input = divPlus.previousElementSibling.firstElementChild.firstElementChild;
    input.value = parseInt(input.value, 10) + 1;
    i += 1;
    console.log(i);
    });
  });

  buttonMoinsRooms.forEach((btn) => {
    btn.addEventListener('click', (e) => {
      e.preventDefault();
      let divMoins = e.target.parentElement.parentElement;
      let input = divMoins.nextElementSibling.firstElementChild.firstElementChild;
      if (i > 0) {
        input.value = parseInt(input.value, 10) - 1;
        i -= 1;
        console.log(i);
      }
    });
  });

  buttonMoinsStuffs.forEach((btn) => {
    btn.addEventListener('click', (e) => {
      e.preventDefault();
      let divMoins = e.target.parentElement.parentElement;
      let input = divMoins.nextElementSibling.firstElementChild.firstElementChild;
      if (i > 0) {
        input.value = parseInt(input.value, 10) - 1;
        i -= 1;
        console.log(i);
      }
    });
  });


}

export { initPlusMinusButtons };
