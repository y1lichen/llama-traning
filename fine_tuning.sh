
#!/bin/bash



./finetune --model-base models/chinese-alpaca-2-7b-hf/ggml-model-q4_0.gguf \
    --train-data data/training_data.txt \
    --sample-start "<s>"
