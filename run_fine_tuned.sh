#!/bin/bash

SYSTEM='You are my friend. 你是我的朋友。'
# SYSTEM='You are a helpful assistant. 你是一个乐于助人的助手。'
FIRST_INSTRUCTION=$1

./main --model models/Taiwan-LLM-7B-v2.0.1-chat/ggml-model-q4_0.bin \
    --lora ggml-lora-LATEST-f32.gguf \
    --lora-base models/Taiwan-LLM-7B-v2.0.1-chat/ggml-model-f16.gguf
    --in-prefix ' [INST] ' --in-suffix ' [/INST]' -p \
    "[INST] <>
    $SYSTEM
    <>
    $FIRST_INSTRUCTION [/INST]"



