document.addEventListener('turbolinks:load', () => {

  // MainImagePreview
  const MainImageModule =(() => {
    const inputElement = document.getElementById('image')
    const previewElement = document.getElementById('main-preview')

    inputElement.addEventListener("change", event => {
      event.preventDefault();     // デフォルトイベントのキャンセル
      event.stopPropagation();    // イベントのバブリングを防ぐ

      // type="file"を指定されたinput要素のchangeイベントは「ファイルのリスト」を返す
      const file = event.target.files[0];

      // ファイルが存在しないか、ファイル形式が"image/*"ではないとき
      if (!file || !file.type.match(/image\/*/)) {
        alert('画像ファイルではありません。')
        return false;
      }

      // FileReaderのインスタンスを生成（ローカルファイルを読み込むオブジェクト）
      const reader = new FileReader();

      // FileReaderの読み込みが完了した結果（アップロードした画像ファイルのデータ）を、img要素のsrcにセット
        reader.addEventListener('load', event => {
            // event.target.resultは、base64エンコードされた画像データ
            previewElement.setAttribute('src', event.target.result);
        })

      // セットされたオブジェクトを読み込む
        reader.readAsDataURL(file);
    });
  })();

  // DressImagePreview
  const DressImageModule =(() => {
    const inputElement = document.getElementById('dress-image')
    const previewElement = document.getElementById('dress-preview')

    inputElement.addEventListener("change", event => {
      event.preventDefault();     // デフォルトイベントのキャンセル
      event.stopPropagation();    // イベントのバブリングを防ぐ

      // type="file"を指定されたinput要素のchangeイベントは「ファイルのリスト」を返す
      const file = event.target.files[0];

      // ファイルが存在しないか、ファイル形式が"image/*"ではないとき
      if (!file || !file.type.match(/image\/*/)) {
        alert('画像ファイルではありません。')
        return false;
      }

      // FileReaderのインスタンスを生成（ローカルファイルを読み込むオブジェクト）
      const reader = new FileReader();

      // FileReaderの読み込みが完了した結果（アップロードした画像ファイルのデータ）を、img要素のsrcにセット
      reader.addEventListener('load', event => {
        // event.target.resultは、base64エンコードされた画像データ
        previewElement.setAttribute('src', event.target.result);
      })

      // セットされたオブジェクトを読み込む
      reader.readAsDataURL(file);
    });
  })();

  const Dress2ImageModule =(() => {
    const inputElement = document.getElementById('dress-image2')
    const previewElement = document.getElementById('dress-preview2')

    inputElement.addEventListener("change", event => {
      event.preventDefault();     // デフォルトイベントのキャンセル
      event.stopPropagation();    // イベントのバブリングを防ぐ

      // type="file"を指定されたinput要素のchangeイベントは「ファイルのリスト」を返す
      const file = event.target.files[0];

      // ファイルが存在しないか、ファイル形式が"image/*"ではないとき
      if (!file || !file.type.match(/image\/*/)) {
        alert('画像ファイルではありません。')
        return false;
      }

      // FileReaderのインスタンスを生成（ローカルファイルを読み込むオブジェクト）
      const reader = new FileReader();

      // FileReaderの読み込みが完了した結果（アップロードした画像ファイルのデータ）を、img要素のsrcにセット
      reader.addEventListener('load', event => {
        // event.target.resultは、base64エンコードされた画像データ
        previewElement.setAttribute('src', event.target.result);
      })

      // セットされたオブジェクトを読み込む
        reader.readAsDataURL(file);
    });
  })();

  const Dress3ImageModule =(() => {
    const inputElement = document.getElementById('dress-image3')
    const previewElement = document.getElementById('dress-preview3')

    inputElement.addEventListener("change", event => {
      event.preventDefault();     // デフォルトイベントのキャンセル
      event.stopPropagation();    // イベントのバブリングを防ぐ

      // type="file"を指定されたinput要素のchangeイベントは「ファイルのリスト」を返す
      const file = event.target.files[0];

      // ファイルが存在しないか、ファイル形式が"image/*"ではないとき
      if (!file || !file.type.match(/image\/*/)) {
        alert('画像ファイルではありません。')
        return false;
      }

      // FileReaderのインスタンスを生成（ローカルファイルを読み込むオブジェクト）
      const reader = new FileReader();

      // FileReaderの読み込みが完了した結果（アップロードした画像ファイルのデータ）を、img要素のsrcにセット
      reader.addEventListener('load', event => {
        // event.target.resultは、base64エンコードされた画像データ
        previewElement.setAttribute('src', event.target.result);
      })

      // セットされたオブジェクトを読み込む
      reader.readAsDataURL(file);
    });
  })();

})