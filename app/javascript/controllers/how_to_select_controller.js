import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="how-to-select"
export default class extends Controller {
  static targets = ["select"]
  connect() {
    const searchKey =  "itemId"
    const url = new URL(window.location.href)

    this.selectTarget.value  = url.searchParams.get(searchKey) || "1";
  }

  change(evnet){
    const searchKey = "itemId"
    const url = new URL(window.location.href)


  url.searchParams.set(searchKey, event.target.value)
  window.location.href = url.toString()
  }

}
  // document.addEventListener("turbo:load", () => {
  //   const selectbox = document.querySelector(".how_to_items");
  //   const searchKey = "itemId";

  
  //   const url = new URL(window.location.href);
  //   /** セレクトボックス初期値を検索クエリに合わせてセット */
  //   selectbox.value = url.searchParams.get(searchKey) || "1";
  // /** セレクトボック ス値変更時に検索クエリを変更してページ遷移 */
  //   selectbox.addEventListener("change", (event) => {
  //     const url = new URL(window.location.href);
  //     url.searchParams.set(searchKey, event.target.value);
  //     window.location.href = url.toString();
  //   });
  // });