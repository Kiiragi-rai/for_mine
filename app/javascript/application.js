// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import Swiper from 'swiper'
import 'swiper/css'


// // プレゼント提案の結果が出るまでの間
// document.addEventListener("DOMContentLoaded", () => {
//     const form = document.querySelector("form");
//     const submitButton = document.getElementById("gift-submit-button");
//     const loadingIndicator = document.getElementById("loading-indicator");
  
//     if (form) {
//       form.addEventListener("submit", () => {
//         submitButton.disabled = true;
//         submitButton.value = "考え中...";
//         loadingIndicator.classList.remove("hidden");
//       });
//     }
//   });


// how_toshowのselect-optionの画面遷移用
  document.addEventListener("turbo:load", () => {
    const selectbox = document.querySelector(".how_to_items");
    const searchKey = "itemId";

  
    const url = new URL(window.location.href);
    /** セレクトボックス初期値を検索クエリに合わせてセット */
    selectbox.value = url.searchParams.get(searchKey) || "1";
  /** セレクトボック ス値変更時に検索クエリを変更してページ遷移 */
    selectbox.addEventListener("change", (event) => {
      const url = new URL(window.location.href);
      url.searchParams.set(searchKey, event.target.value);
      window.location.href = url.toString();
    });
  });


  // fade-in 　how_toで使用
//   const scrollFade = () => {

//     const fadeElem = document.querySelectorAll(".ef");
//     const elemLength = fadeElem.length;
//     for (let i = 0; i < elemLength; i++) {
//       fadeElem[i].style.opacity = 0;
//     }
  
//     window.addEventListener("scroll", (event) => {
//       fadeElem.forEach((fadeElem) => {
//         const ePos = fadeElem.offsetTop;
//         const scroll = window.scrollY;
//         const windowHeight = window.innerHeight;
//         if (scroll > ePos - windowHeight + windowHeight/5){
//           fadeElem.style.opacity = 1;
//         }
//       });
//     });
  
//   }
//   scrollFade();


//   // fade -in 2
//   //要素をフェードインする処理
// const showElements = () => {
//   //フェードインする要素を全て取得
//   const elements = document.querySelectorAll(".fadein");
//   //ブラウザの高さの80%を計算
//   const displayPos = window.innerHeight * 0.8;
  
//   elements.forEach((element) => {
//     //ブラウザの上から要素の上までの距離
//     const elementPos = element.getBoundingClientRect().top;
//    //要素がブラウザの下から20%の位置よりも上に到達したら実行する
//     if(displayPos > elementPos) {
//       //要素に「show」クラスを追加
//       element.classList.add("show");
//     }
//   });
// };

// window.addEventListener("load", showElements);
// window.addEventListener("scroll", showElements);



// モーダル
   document.addEventListener("turbo:load", function() {
    const deleteBtn = document.getElementById("delete-btn");
    const modal = document.getElementById("confirmation-modal");
    const confirmNoBtn = document.getElementById("confirm-no");
  
    deleteBtn.addEventListener("click", function(e) {
      e.preventDefault();
      modal.style.display = "block";
    });
  
    confirmNoBtn.addEventListener("click", function() {
      modal.style.display = "none";
    });
  }); 


  // Swiper
//初期設定
