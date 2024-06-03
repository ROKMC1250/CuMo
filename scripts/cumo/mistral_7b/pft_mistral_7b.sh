#!/bin/bash

deepspeed cumo/train/train_mem.py \
    --deepspeed ./scripts/zero3.json \
    --model_name_or_path mistralai/Mistral-7B-Instruct-v0.2 \
    --version mistral_instruct_system \
    --data_path $CuMo_DIR/data/jsons/cumo_pft_allava.json \
    --image_folder $CuMo_DIR/data \
    --vision_tower openai/clip-vit-large-patch14-336 \
    --vision_tower_dir $CuMo_DIR/checkpoints/clip-vit-large-patch14-336/pytorch_model.bin \
    --scales 1,3 \
    --pretrain_mm_mlp_adapter $CuMo_DIR/checkpoints/cumo-mistral-7b-pretrain/mm_projector.bin \
    --mm_projector_type mlp2x_gelu \
    --pft True \
    --mlp_smoe False \
    --clip_smoe False \
    --mm_vision_select_layer -2 \
    --mm_use_im_start_end False \
    --mm_use_im_patch_token False \
    --image_aspect_ratio pad \
    --group_by_modality_length True \
    --bf16 True \
    --output_dir $CuMo_DIR/checkpoints/cumo-mistral-7b-pft \
    --num_train_epochs 1 \
    --per_device_train_batch_size 4 \
    --per_device_eval_batch_size 4 \
    --gradient_accumulation_steps 2 \
    --evaluation_strategy "no" \
    --save_strategy "steps" \
    --save_steps 50000 \
    --save_total_limit 1 \
    --learning_rate 2e-6 \
    --weight_decay 0. \
    --warmup_ratio 0.03 \
    --lr_scheduler_type "cosine" \
    --logging_steps 1 \
    --tf32 True \
    --model_max_length 4096 \
    --gradient_checkpointing True \
    --dataloader_num_workers 4 \
    --lazy_preprocess True \
    --report_to none