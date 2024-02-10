#!/bin/bash

# temporary script to chat with Chinese Alpaca-2 model

SYSTEM='You are my friend. 你是我的朋友。'
# SYSTEM='You are a helpful assistant. 你是一个乐于助人的助手。'
FIRST_INSTRUCTION=$1

./main -m models/chinese-alpaca-2-7b-hf/ggml-model-q4_0.gguf \
    -ins -n 512 -t 8 --temp 0.5 --top_k 40 --top_p 0.9 --repeat_penalty 1.1 \
--in-prefix-bos --in-prefix ' [INST] ' --in-suffix ' [/INST]' -p \
"[INST] <>
$SYSTEM
<>

$FIRST_INSTRUCTION [/INST]"

