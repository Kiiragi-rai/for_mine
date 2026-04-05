import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification"
export default class extends Controller {
  static targets = ["date", "result","frequency"]

  connect() {

    const checked = this.element.querySelector("input[value='true']:checked")
    if (checked) {
      this.resultTarget.classList.remove('d-none')
    }
  }

  toggle(event){
    const value = event.target.value

    if (value == "true") {
      this.resultTarget.classList.remove("d-none")
      this.frequencyTarget.classList.remove("d-none")
      this.calculate()
    } else {
      this.resultTarget.classList.add("d-none")
      this.frequencyTarget.classList.add("d-none")
    }
  }
  calculate() {
    const dateValue = this.dateTarget.value
    if (!dateValue) {
      this.resultTarget.textContent = ""
      this.frequencyTarget.textContent = ""
      return
    }
  
    const [_year, month, day] = dateValue.split("-").map(Number)
  
    const today = new Date()
  
    const anniversaryDateForYear = (year, month, day) => {
      if (month === 2 && day === 29) {
        const isLeap = new Date(year, 1, 29).getDate() === 29
        return new Date(year, 1, isLeap ? 29 : 28)
      }
      return new Date(year, month - 1, day)
    }
  
    let next = anniversaryDateForYear(today.getFullYear(), month, day)
  
    if (next < today) {
      next = anniversaryDateForYear(today.getFullYear() + 1, month, day)
    }
  
    const yyyy = next.getFullYear()
    const mm = String(next.getMonth() + 1).padStart(2, "0")
    const dd = String(next.getDate()).padStart(2, "0")
  
    this.resultTarget.textContent = `ここで設定した日から${yyyy}-${mm}-${dd}まで通知が届きます`
    this.frequencyTarget.textContent = `通知開始日から${yyyy}-${mm}-${dd}まで指定した頻度で通知が来ます`
  }
}

