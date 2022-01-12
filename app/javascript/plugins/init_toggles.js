const initToggles = () => {
  const instructions = document.querySelector('#instructions');
  instructions.addEventListener('click', (e) => {
    const instructionsList = document.querySelector('#instructions-list');
    instructionsList.classList.toggle("hidden");
    $('html,body').animate({
      scrollTop: $("#instructions-list").offset().top
    },
      'slow');
  });
}

export { initToggles }
