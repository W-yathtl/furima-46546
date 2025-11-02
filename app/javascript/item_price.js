// app/javascript/item_price.js
// 販売手数料・利益を計算して表示する安全な初期化関数
(function () {
  function initPriceCalculation() {
    const priceInput = document.getElementById("item-price");
    const addTaxPrice = document.getElementById("add-tax-price");
    const profit = document.getElementById("profit");

    // 必要要素が無ければ何もしない
    if (!priceInput || !addTaxPrice || !profit) return;

    // 多重バインド回避：既に初期化済みなら終了
    if (priceInput.dataset.priceInit === "true") return;
    priceInput.dataset.priceInit = "true";

    const calculateAndRender = (value) => {
      const price = Number(value);
      if (!Number.isFinite(price) || price === 0) {
        addTaxPrice.textContent = "0";
        profit.textContent = "0";
        return;
      }

      if (price >= 300 && price <= 9999999) {
        const fee = Math.floor(price * 0.1);    // 手数料（切り捨て）
        const gain = Math.floor(price - fee);   // 利益（切り捨て）
        addTaxPrice.textContent = fee.toLocaleString();
        profit.textContent = gain.toLocaleString();
      } else {
        addTaxPrice.textContent = "0";
        profit.textContent = "0";
      }
    };

    // 入力時
    priceInput.addEventListener("input", (e) => {
      calculateAndRender(e.target.value);
    });

    // 初期値が既にある場合（バリデーションで戻ってきた場合など）に即時実行
    if (priceInput.value) {
      calculateAndRender(priceInput.value);
    }
  }

  // Turbo がある環境では turbo:load と turbo:render の両方を監視
  document.addEventListener("turbo:load", initPriceCalculation);
  document.addEventListener("turbo:render", initPriceCalculation);

  // 万が一 Turbo を使っていなければ DOMContentLoaded もフォールバック
  document.addEventListener("DOMContentLoaded", initPriceCalculation);
})();
