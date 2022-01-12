const initToggles = () => {
  const instructions = document.querySelector('#instructions');
  instructions.addEventListener('click', (e) => {
    const instructionsList = document.querySelector('#instructions-list');
    instructionsList.classList.toggle("hidden");
    window.location.hash = '#instructions-list';
  });
}

export { initToggles }
