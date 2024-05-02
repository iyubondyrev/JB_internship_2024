LANG=kotlin                  
DATADIR=../../../datasets/token_completion_dataset/kotlin
LITFILE=../../../datasets/token_completion_dataset/kotlin/literals.json
OUTPUTDIR=save/
PRETRAINDIR=microsoft/CodeGPT-small-py-adaptedGPT2
LOGFILE=completion_kotlin_train_vanilla_gpt_py.log
PER_NODE_GPU=1      # modify YOUR_GPU_NUM
WANDB_PROJECT=JB_internship_2024
WANDB_RUN=GPT_PY_FINETUNE

python -u ../../code/run_lm.py \
        --data_dir=$DATADIR \
        --lit_file=$LITFILE \
        --langs=$LANG \
        --output_dir=$OUTPUTDIR \
        --pretrain_dir=$PRETRAINDIR \
        --log_file=$LOGFILE \
        --model_type=gpt2 \
        --block_size=1024 \
        --do_train \
        --gpu_per_node $PER_NODE_GPU \
        --learning_rate=8e-5 \
        --weight_decay=0.01 \
        --evaluate_during_training \
        --per_gpu_train_batch_size=4 \
        --per_gpu_eval_batch_size=8 \
        --gradient_accumulation_steps=4 \
        --num_train_epochs=5 \
        --logging_steps=100 \
        --save_steps=1000 \
        --seed=42 \
        --overwrite_output_dir \
        --not_pretrain \
        --wandb_project_name=$WANDB_PROJECT \
        --wandb_run=$WANDB_RUN \
