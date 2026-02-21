// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"


// プレゼント提案の結果が出るまでの間
document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form");
    const submitButton = document.getElementById("gift-submit-button");
    const loadingIndicator = document.getElementById("loading-indicator");
  
    if (form) {
      form.addEventListener("submit", () => {
        submitButton.disabled = true;
        submitButton.value = "考え中...";
        loadingIndicator.classList.remove("hidden");
      });
    }
  });


// how_toshowのselect-optionの画面遷移用
  document.addEventListener("DOMContentLoaded", () => {
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
