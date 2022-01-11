const initPlusMinusButtons = () => {
const buttonPlus = document.querySelector('.plus');

  buttonPlus.addEventListener('click', (e) => {
    e.preventDefault();
    let divPlus = e.target.parentElement.parentElement
    let divInput = divPlus.previousElementSibling.firstElementChild
    console.log(divPlus.previousElementSibling.firstElementChild);
  });
}

export { initPlusMinusButtons };
