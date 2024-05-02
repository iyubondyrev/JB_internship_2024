
LANG=kotlin                  
DATADIR=../../../datasets/method_generation_dataset/kotlin
LITFILE=../../../datasets/method_generation_dataset/kotlin/literals.json
OUTPUTDIR=save_gpt/
PRETRAINDIR=iyubondyrev/jb_2024_kotlin_gpt
LOGFILE=method_gen_kotlin_train_my_gpt_py.log
PER_NODE_GPU=1 

python -u ../../code/run.py \
        --data_dir=$DATADIR \
        --output_dir=$OUTPUTDIR \
        --pretrain_dir=$PRETRAINDIR \
        --lit_file=$LITFILE \
        --log_file=$LOGFILE \
        --lang=$LANG \
        --model_type=gpt2 \
        --block_size=1024 \
        --do_train \
        --node_index 0 \
        --gpu_per_node $PER_NODE_GPU \
        --learning_rate=3e-5 \
        --weight_decay=0.01 \
        --evaluate_during_training \
        --per_gpu_train_batch_size=4 \
        --per_gpu_eval_batch_size=12 \
        --gradient_accumulation_steps=1 \
        --num_train_epochs=6 \
        --logging_steps=100 \
        --save_steps=1000 \
        --warmup_steps=1000 \
        --overwrite_output_dir \
        --seed=42
