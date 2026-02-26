import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ["slide", "indicator"]

  connect() {
    this.lists = this.indicatorTarget.querySelectorAll(".list")
    this.totalSlides = this.lists.length
    this.count = 0

    this.updateIndicator()
    this.startAutoPlay()
  }

  disconnect() {
    clearInterval(this.autoPlayInterval)
  }

  next() {
    this.changeSlide(1)
  }

  prev() {
    this.changeSlide(-1)
  }

  changeSlide(direction) {
    this.slideTarget.classList.remove(`slide${this.count + 1}`)

    this.count += direction

    if (this.count >= this.totalSlides) this.count = 0
    if (this.count < 0) this.count = this.totalSlides - 1

    this.slideTarget.classList.add(`slide${this.count + 1}`)

    this.updateIndicator()
    this.resetAutoPlay()
  }

  select(event) {
    if (!event.target.classList.contains("list")) return

    this.slideTarget.classList.remove(`slide${this.count + 1}`)

    this.count = Array.from(this.lists).indexOf(event.target)

    this.slideTarget.classList.add(`slide${this.count + 1}`)

    this.updateIndicator()
    this.resetAutoPlay()
  }

  updateIndicator() {
    this.lists.forEach((el, i) => {
      el.style.backgroundColor =
        i === this.count ? "#000" : "#fff"
    })
  }

  startAutoPlay() {
    this.autoPlayInterval = setInterval(() => {
      this.next()
    }, 3000)
  }

  resetAutoPlay() {
    clearInterval(this.autoPlayInterval)
    this.startAutoPlay()
  }
  }

