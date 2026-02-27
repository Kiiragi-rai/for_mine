import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = [ "slide", "prev", "next", "indicator","list"]
  connect() {
    const slide = this.slideTarget;
  const prev = this.prevTarget
  const next = this.nextTarget
  const indicator =  this.indicatorTarget
  const lists = this.listTargets

  const totalSlides = lists.length
  let count = 0;
  let autoPlayInterval;
  function updateListBackground() {
    for (let i = 0; i < lists.length; i++) {
      lists[i].style.backgroundColor = i === count % totalSlides ? '#000' : '#fff';
    }
  }
  function nextClick() {
    slide.classList.remove(`slide${count % totalSlides + 1}`);
    count++;
    slide.classList.add(`slide${count % totalSlides + 1}`);
    updateListBackground();
  }
  function prevClick() {
    slide.classList.remove(`slide${count % totalSlides + 1}`);
    count--;
    if (count < 0) count = totalSlides - 1;
    slide.classList.add(`slide${count % totalSlides + 1}`);
    updateListBackground();
  }
  function startAutoPlay() {
    autoPlayInterval = setInterval(nextClick, 3000);
  }
  function resetAutoPlayInterval() {
    clearInterval(autoPlayInterval);
    startAutoPlay();
  }
  next.addEventListener('click', () => {
    nextClick();
    resetAutoPlayInterval();
  });
  prev.addEventListener('click', () => {
    prevClick();
    resetAutoPlayInterval();
  });
  indicator.addEventListener('click', (event) => {
    if (event.target.classList.contains('list')) {
      const index = Array.from(lists).indexOf(event.target);
      slide.classList.remove(`slide${count % totalSlides + 1}`);
      count = index;
      slide.classList.add(`slide${count % totalSlides + 1}`);
      updateListBackground();
      resetAutoPlayInterval();
    }
  });
  startAutoPlay();
  }
}
