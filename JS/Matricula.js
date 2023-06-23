// Obtén la referencia al botón de abrir la ventana modal
var abrirModal = document.getElementById("abrir-modal");

// Obtén la referencia a la ventana modal
var modal = document.querySelector(".modal-overlay");

// Obtén la referencia a los botones de cerrar la ventana modal
var seleccionarModal = modal.querySelectorAll(".seleccionar-modal");

// Agrega un evento de clic al botón de abrir la ventana modal
abrirModal.addEventListener("click", function () {
  modal.style.display = "flex";
});

seleccionarModal.forEach(function (boton) {
  boton.addEventListener("click", function () {
    modal.style.display = "none";
  });
});
// Obtén la referencia al botón de cerrar la ventana modal
var cerrarModal = modal.querySelector(".cerrar-modal");

// Agrega un evento de clic al botón de cerrar la ventana modal
cerrarModal.addEventListener("click", function () {
  modal.style.display = "none";
});

//para confirmar
// Obtén la referencia a los botones de  confirmar la ventana modal
var confirmarModal = document.getElementById("confirmar-modal");
var modalOverlay1 = document.querySelector(".modal-overlay1");
var cerrarModal1 = document.querySelector(".cerrar-modal1");

confirmarModal.addEventListener("click", function() {
  modalOverlay1.style.display = "flex";
});

cerrarModal1.addEventListener("click", function() {
  modalOverlay1.style.display = "none";
});