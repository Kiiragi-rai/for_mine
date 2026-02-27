// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

// // CharacterData
// const chart1 = document.getElementById('chart1').getContext('2d');
// const myChart1 = new Chart(chart1, {
//   type: 'line',
//   data: {
//     labels: ['monday', 'tuesday','wednesday', 'thursday', 'friday','saturday', 'suday'],
//     datasets: [{
//       label: 'Last Week',
//       backgroundColor: '#8c68cd',
//       borderColor: '#8c68cd',
//       data: [3000, 4000, 2500, 7000, 5500, 9000, 2000],

//     }]
//   },
//   options: {
//     scales: {
//       y: {
//         beginAtZero: true
//       }
//     }
//   }
// })



// document.addEventListener("turbo:load", ()=> {
//   const slide = document.getElementById('slide');
//   const prev = document.getElementById('prev');
//   const next = document.getElementById('next');
//   const indicator = document.getElementById('indicator');
//   const lists = document.querySelectorAll('.list');
//   const totalSlides = lists.length;
//   let count = 0;
//   let autoPlayInterval;
//   function updateListBackground() {
//     for (let i = 0; i < lists.length; i++) {
//       lists[i].style.backgroundColor = i === count % totalSlides ? '#000' : '#fff';
//     }
//   }
//   function nextClick() {
//     slide.classList.remove(`slide${count % totalSlides + 1}`);
//     count++;
//     slide.classList.add(`slide${count % totalSlides + 1}`);
//     updateListBackground();
//   }
//   function prevClick() {
//     slide.classList.remove(`slide${count % totalSlides + 1}`);
//     count--;
//     if (count < 0) count = totalSlides - 1;
//     slide.classList.add(`slide${count % totalSlides + 1}`);
//     updateListBackground();
//   }
//   function startAutoPlay() {
//     autoPlayInterval = setInterval(nextClick, 3000);
//   }
//   function resetAutoPlayInterval() {
//     clearInterval(autoPlayInterval);
//     startAutoPlay();
//   }
//   next.addEventListener('click', () => {
//     nextClick();
//     resetAutoPlayInterval();
//   });
//   prev.addEventListener('click', () => {
//     prevClick();
//     resetAutoPlayInterval();
//   });
//   indicator.addEventListener('click', (event) => {
//     if (event.target.classList.contains('list')) {
//       const index = Array.from(lists).indexOf(event.target);
//       slide.classList.remove(`slide${count % totalSlides + 1}`);
//       count = index;
//       slide.classList.add(`slide${count % totalSlides + 1}`);
//       updateListBackground();
//       resetAutoPlayInterval();
//     }
//   });
//   startAutoPlay();
// })
