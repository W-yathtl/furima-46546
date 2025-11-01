document.addEventListener("turbo:load", () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const price = Number(priceInput.value);

    if (price >= 300 && price <= 9999999) {
      const fee = Math.floor(price * 0.1);
      const gain = Math.floor(price - fee);

      addTaxPrice.textContent = fee.toLocaleString();
      profit.textContent = gain.toLocaleString();
    } else {
      addTaxPrice.textContent = "0";
      profit.textContent = "0";
    }
  });
});