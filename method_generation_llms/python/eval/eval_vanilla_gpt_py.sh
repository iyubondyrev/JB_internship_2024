export CUDA_VISIBLE_DEVICES=0
DATADIR=../../../datasets/method_generation_dataset/python
LITFILE=../../../datasets/method_generation_dataset/python/literals.json
OUTPUTDIR=save/
PRETRAINDIR=microsoft/CodeGPT-small-py-adaptedGPT2
LOGFILE=eval.log

python -u ../../code/run.py \
        --data_dir=$DATADIR \
        --output_dir=$OUTPUTDIR \
        --pretrain_dir=$PRETRAINDIR \
        --lit_file=$LITFILE \
        --log_file=$LOGFILE \
        --model_type=gpt2 \
        --block_size=1024 \
        --do_infer \
        --node_index 0 \
        --gpu_per_node 1 \
        --per_gpu_eval_batch_size=12 \
        --num_train_epochs=30 \
        --logging_steps=100 \
        --overwrite_output_dir \
        --seed=42