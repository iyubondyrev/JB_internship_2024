export CUDA_VISIBLE_DEVICES=0
DATADIR=../../../datasets/method_generation_dataset/python
LITFILE=../../../datasets/method_generation_dataset/python/literals.json
OUTPUTDIR=save/
PRETRAINDIR=microsoft/phi-1_5
LOGFILE=eval.log

python -u ../../code/run.py \
        --data_dir=$DATADIR \
        --output_dir=$OUTPUTDIR \
        --pretrain_dir=$PRETRAINDIR \
        --lit_file=$LITFILE \
        --log_file=$LOGFILE \
        --model_type=phi_1_5 \
        --block_size=512 \
        --do_infer \
        --node_index 0 \
        --gpu_per_node 1 \
        --per_gpu_eval_batch_size=1 \
        --logging_steps=100 \
        --overwrite_output_dir \
        --seed=42

python ../../code/evaluator.py -a=save/test.gold -p=save/test.output > eval_result_vanilla_phi-1_5.txt 2>&1

cp save/test.output predictions_vanilla_phi-1_5.txt