import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const elements = this.element.querySelectorAll(".fadein")
    
    elements.forEach((el, index) => {
      setTimeout(() => {
        el.classList.add("show")
      }, index * 300)
    })

  }
}
  
  