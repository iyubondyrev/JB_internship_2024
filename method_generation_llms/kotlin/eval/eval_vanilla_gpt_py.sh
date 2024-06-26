export CUDA_VISIBLE_DEVICES=0
DATADIR=../../../datasets/method_generation_dataset/kotlin
LITFILE=../../../datasets/method_generation_dataset/kotlin/literals.json
OUTPUTDIR=save_vanilla_gpt_py/
PRETRAINDIR=microsoft/CodeGPT-small-py-adaptedGPT2
LOGFILE=eval_vanilla_gpt_py.log

python -u ../../code/run.py \
        --data_dir=$DATADIR \
        --output_dir=$OUTPUTDIR \
        --pretrain_dir=$PRETRAINDIR \
        --lit_file=$LITFILE \
        --log_file=$LOGFILE \
        --model_type=gpt2 \
        --block_size=1024 \
        --lang=kotlin \
        --do_infer \
        --node_index 0 \
        --gpu_per_node 1 \
        --per_gpu_eval_batch_size=1 \
        --num_train_epochs=30 \
        --logging_steps=100 \
        --overwrite_output_dir \
        --seed=42

python ../../code/evaluator.py -a=save_vanilla_gpt_py/test.gold -p=save_vanilla_gpt_py/test.output > eval_result_vanilla_gpt_py.txt 2>&1

cp save_vanilla_gpt_py/test.output predictions_vanilla_gpt_py.txt