document.addEventListener('turbolinks:load', () => {

  // フォーム文字数カウント
  let input = document.getElementById("count");
  let span = document.getElementById("inputCounter");
  input.addEventListener("keyup", function() {
    span.textContent = input.value.length;
  });

})