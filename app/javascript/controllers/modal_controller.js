import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ["modal"]
  open(event) {
    event.preventDefault()
    this.modalTarget.style.display = "block"
  }
  close(){
    this.modalTarget.style.display = "none"
  }
}
// モーダル
// document.addEventListener("turbo:load", function() {
//   const deleteBtn = document.getElementById("delete-btn");
//   const modal = document.getElementById("confirmation-modal");
//   const confirmNoBtn = document.getElementById("confirm-no");

//   deleteBtn.addEventListener("click", function(e) {
//     e.preventDefault();
//     modal.style.display = "block";
//   });

//   confirmNoBtn.addEventListener("click", function() {
//     modal.style.display = "none";
//   });
// }); 