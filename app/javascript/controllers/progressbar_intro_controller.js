import { Controller } from "@hotwired/stimulus"
import { end } from "@popperjs/core"

// Connects to data-controller="progressbar-intro"
export default class extends Controller {
  static targets = ["name","intro"]
  connect() {
    // console.log("Hello, I'm issen_controller.js!!!")
    
     const value = this.nameTarget.value
    //  console.log(value)
     if (value){
      this.introTarget.classList.remove('d-none')
      // console.log("とれてる？？")
     } else{
      // console.log("ない")
     }
  }

  appear(e) {
   const  value = e.target.value
    console.log(value)
    if (value){
      this.introTarget.classList.remove("d-none")
    } else {
      this.introTarget.classList.add("d-none")
    }
  }
}


// まずnameをの値が取れているかどうか確認
// その後すでにnameがある時文章が出るようにしよう（editのみ）

// その後newの時でもきくようにしよっか
