const initToggles = () => {
  const instructions = document.querySelector('#instructions');
  instructions.addEventListener('click', (e) => {
    const instructionsList = document.querySelector('#instructions-list');
    instructionsList.classList.toggle("hidden");
    if (!instructionsList.classList.contains("hidden")) {
      $('html,body').animate({
        scrollTop: $("#instructions-list").offset().top
      },
        'slow');
    };
  });
}

export { initToggles }
