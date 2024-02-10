*資管三 110306017 陳奕利*

## 1. 取得llama.cpp

```
git clone https://github.com/ggerganov/llama.cpp.git  
```

## 2. 編譯llama.cpp

```
cd llama.cpp
make
```

這裡的make依能作業系統會有所不同
以下以linux為例：
- OpenBLAS - 只用cpu
```
make LLAMA_OPENBLAS=1
```
- hipBLAS - 使用AMD gpu
```
make LLAMA_HIPBLAS=1
```
- cuBLAS - 使用nvidia gpu
```
make LLAMA_CUBLAS=1
```
詳細請閱：[https://github.com/ggerganov/llama.cpp](https://github.com/ggerganov/llama.cpp)

**注意：如果是直接將資料夾直接上傳到雲端平台進行fine-tune，可以先執行make clean**

## 3. 安裝套件

```
python3 -m pip install -r requirements.txt
```

## 4. 下載模型

```
mkdir models && cd models
git lfs install
git clone <huggingface-url>
```
以Taiwan-LLM為例…
```
mkdir models && cd models
git lfs install
git clone https://huggingface.co/yentinglin/Taiwan-LLM-7B-v2.0.1-chat
```

- 把下載的模型統一放到models方便管理
- lfs是large file storage的縮寫，讓git能夠處理大型檔案
- 下載huggingface模型要先使用huggiceface的cli工具登入，並先在網頁要求模型存取權限。
- 模型檔型較大，需耐心等待

## 5. 量化壓縮模型

```
python3 convert.py <folder_path_of_model>
./quantize <model_path new_model_path> q4_0
```

以Taiwan-LLM為例
```
python convert.py models/Taiwan-LLM-7B-v2.0.1-chat
./quantize models/Taiwan-LLM-7B-v2.0.1-chat/ggml-model-f16.gguf q4_0
```

- 可選用q4_0或q8_0，q8_0會使用較多記憶體空間，但效果較佳

## 6. 準備fine-tuning訓練資料

可使用.txt、.csv、.json、.xml等格式檔案

以下為一筆使用txt檔範例：
```
<s>Below is an instruction that describes a task. Write a response that appropriately completes the request.
### Instruction:
HUMAN: 我心情好差

### Response:
BOT: 怎麼了 期中考考爛了嗎
```

## 7. 開始fine-tune

```
./finetune --model-base models/Taiwan-LLM-7B-v2.0.1-chat/ggml-model-q4_0.bin --train-data trainfile.txt --threads 26 --sample-start "<s>" --ctx 512
```

1. 此時會開始訓練，會花上數小時。需耐心等待
2. 以上訓練參數視情況而定，--sample-start "<s>"只在使用以上訓練檔案格式中適用
3. fine-tuning過程會產生不同時間點之checkpoint lora檔，最終訓練結果為ggml-lora-LATEST-f32.gguf

## 8. 使用fine-tuned模型
```
./main --model models/Taiwan-LLM-7B-v2.0.1-chat/ggml-model-q4_0.bin --lora ggml-lora-LATEST-f32.gguf --lora-base models/Taiwan-LLM-7B-v2.0.1-chat/ggml-model-f16.gguf --promt "<文字內容>"
```