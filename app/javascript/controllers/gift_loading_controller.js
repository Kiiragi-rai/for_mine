import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gift-loading"
export default class extends Controller {
  connect() {
  }
}
document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("form");
  const submitButton = document.getElementById("gift-submit-button");
  const loadingIndicator = document.getElementById("loading-indicator");

  if (form) {
    form.addEventListener("submit", () => {
      submitButton.disabled = true;
      submitButton.value = "考え中...";
      loadingIndicator.classList.remove("hidden");
    });
  }
});

