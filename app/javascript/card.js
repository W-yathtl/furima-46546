const pay = () => {
  console.log("ok")
  if (document.getElementById('charge-form') == null) return;
  const form = document.getElementById('charge-form');
  // フォームが存在しない、または公開鍵がなければ処理を終了
  if (!form || !gon.public_key) {
    return;
  }

  const payjp = Payjp(gon.public_key); // PAY.JPテスト公開鍵
  // Pay.jpの初期化がすでに行われていれば、多重実行を防ぐ
  if (form.dataset.payjpInitialized) {
    return;
  }
  form.dataset.payjpInitialized = "true";

  const payjp = Payjp(gon.public_key);
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');
  const expiryElement = elements.create('cardExpiry');
  const cvcElement = elements.create('cardCvc');

  // 各フォーム要素をマウント
  numberElement.mount('#number-form');
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');

  const form = document.getElementById('charge-form');
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        // エラーハンドリングはここで必要に応じて追加
        // エラー発生時はフォームの送信を中断し、ボタンを有効化
        form.querySelector("input[type='submit']").disabled = false;
      } else {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
        // フォームにトークンを埋め込んで送信
        const tokenInput = document.createElement("input");
        tokenInput.setAttribute("type", "hidden");
        tokenInput.setAttribute("name", "token");
        tokenInput.setAttribute("value", token);
        form.appendChild(tokenInput);

        // カード情報をクリアしてフォームを送信
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
        form.submit();
      }
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);