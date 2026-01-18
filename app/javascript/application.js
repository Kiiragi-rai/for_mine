// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

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