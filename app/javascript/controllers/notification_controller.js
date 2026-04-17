import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notification"
export default class extends Controller {
  static targets = ["date", "result","frequency"]

  connect() {

    const checked = this.element.querySelector("input[value='true']:checked")
    if (checked) {
      this.resultTarget.classList.remove('d-none')
      this.frequencyTarget.classList.remove("d-none")
    }
      this.calculate()
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
      // this.frequencyTarget.textContent = "この設定は反映されません"
    }
  }
  // nextanniversryと同じ処理
  calculate() {
    const dateValue = this.dateTarget.value
    if (!dateValue) {
      this.resultTarget.textContent = "記念日を入力してください"
      return
    }
 
  
    const [_year, month, day] = dateValue.split("-").map(Number)
  
    const today = new Date()
  // 閏年
    const anniversaryDateForYear = (year, month, day) => {
      if (month === 2 && day === 29) {
        const isLeapYear = new Date(year, 1, 29).getDate() === 29
        return new Date(year, 1, isLeapYear ? 29 : 28)
      }
      return new Date(year, month - 1, day)
    }
  
    let next_anniversary = anniversaryDateForYear(today.getFullYear(), month, day)
  
    if (next_anniversary < today) {
      next_anniversary = anniversaryDateForYear(today.getFullYear() + 1, month, day)
    }
  
    const yyyy = next_anniversary.getFullYear()
    const mm = String(next_anniversary.getMonth() + 1).padStart(2, "0")
    const dd = String(next_anniversary.getDate()).padStart(2, "0")
  
    this.resultTarget.textContent = `ここで設定した日から${yyyy}-${mm}-${dd}まで通知が届きます`
    this.frequencyTarget.textContent = `通知開始日から${yyyy}-${mm}-${dd}まで指定した頻度で通知が来ます`
  }
}

