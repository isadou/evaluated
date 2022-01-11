const initPlusMinusButtons = () => {
const buttonPlus = document.querySelector('.plus');

  buttonPlus.addEventListener('click', (e) => {
    e.preventDefault();
    let divPlus = e.target.parentElement.parentElement;
    let input = divPlus.previousElementSibling.firstElementChild.firstElementChild;
    input.value = parseInt(input.value, 10) + 1;
  });
}

export { initPlusMinusButtons };
