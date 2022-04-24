document.addEventListener('turbolinks:load', () => {

  let hanba = document.querySelector('.fas')
  let menu = document.querySelector('.menu')

  hanba.onclick = () => {
    menu.classList.toggle("icon");
  }

})