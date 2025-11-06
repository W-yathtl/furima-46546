const pay = () => {
  // フォームが存在しない、または公開鍵がなければ処理を終了
  const form = document.getElementById('charge-form');
  if (!form || !gon.public_key) {
    return;
  }

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

  form.addEventListener("submit", (e) => {
    e.preventDefault();

    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
        // エラー発生時はフォームの送信を中断し、ボタンを有効化
        form.querySelector("input[type='submit']").disabled = false;
      } else {
        const token = response.id;
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
    });
  });
};

window.addEventListener("turbo:load", pay);
