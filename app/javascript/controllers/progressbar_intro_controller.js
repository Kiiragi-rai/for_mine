import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="progressbar-intro"
export default class extends Controller {
  static targets = ["name","pbintro"]
  connect() {
    console.log("Hello, I'm issen_controller.js!!!")
  }
}
