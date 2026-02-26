import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fade"
export default class extends Controller {
  connect() {
    this.scrollFade()
    this.showElements()

    window.addEventListener("scroll",this.handleScroll)
  }
  
  disconnect(){
    window.removeEventListener("scroll", this.handleScroll)
  }

  handleScroll = () => {
    this.scrollFade()
    this.showElements()
  }

  scrollFade() {
    const fadeElem = this.element.querySelectorAll(".ef")

    fadeElem.forEach((el) => {

      const ePos = el.offsetTop
      const scroll = window.scrollY
      const windowHeight = window.innerHeight

      if (scroll > ePos - windowHeight + windowHeight / 5) {
        el.style.opacity = 1
      }
    })
  }

  showElements() {
    const elements = this.element.querySelectorAll(".fadein")
    const displayPos = window.innerHeight * 0.8

    elements.forEach((element) => {
      const elementPos = element.getBoundingClientRect().top

      if (displayPos > elementPos) {
        element.classList.add("show")
      }
    })
  }
}
// const scrollFade = () => {

//   const fadeElem = document.querySelectorAll(".ef");
//   const elemLength = fadeElem.length;
//   for (let i = 0; i < elemLength; i++) {
//     fadeElem[i].style.opacity = 0;
//   }

//   window.addEventListener("scroll", (event) => {
//     fadeElem.forEach((fadeElem) => {
//       const ePos = fadeElem.offsetTop;
//       const scroll = window.scrollY;
//       const windowHeight = window.innerHeight;
//       if (scroll > ePos - windowHeight + windowHeight/5){
//         fadeElem.style.opacity = 1;
//       }
//     });
//   });

// }
// scrollFade();


// // fade -in 2
// //要素をフェードインする処理
// const showElements = () => {
// //フェードインする要素を全て取得
// const elements = document.querySelectorAll(".fadein");
// //ブラウザの高さの80%を計算
// const displayPos = window.innerHeight * 0.8;

// elements.forEach((element) => {
//   //ブラウザの上から要素の上までの距離
//   const elementPos = element.getBoundingClientRect().top;
//  //要素がブラウザの下から20%の位置よりも上に到達したら実行する
//   if(displayPos > elementPos) {
//     //要素に「show」クラスを追加
//     element.classList.add("show");
//   }
// });
// };

// window.addEventListener("load", showElements);
// window.addEventListener("scroll", showElements);

