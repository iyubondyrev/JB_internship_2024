export CUDA_VISIBLE_DEVICES=0
DATADIR=../../../datasets/method_generation_dataset/kotlin
LITFILE=../../../datasets/method_generation_dataset/kotlin/literals.json
OUTPUTDIR=save_finetuned_phi/
PRETRAINDIR=iyubondyrev/jb_2024_kotlin_phi-1_5
LOGFILE=eval_finetuned_phi.log

python -u ../../code/run.py \
        --data_dir=$DATADIR \
        --output_dir=$OUTPUTDIR \
        --pretrain_dir=$PRETRAINDIR \
        --lit_file=$LITFILE \
        --log_file=$LOGFILE \
        --model_type=phi_1_5 \
        --block_size=512 \
        --lang=kotlin \
        --do_infer \
        --node_index 0 \
        --gpu_per_node 1 \
        --per_gpu_eval_batch_size=1 \
        --num_train_epochs=30 \
        --logging_steps=100 \
        --overwrite_output_dir \
        --seed=42

python ../../code/evaluator.py -a=save_finetuned_phi/test.gold -p=save_finetuned_phi/test.output > eval_result_finetuned_phi-1_5.txt 2>&1

cp save_finetuned_phi/test.output predictions_finetuned_phi-1_5.txt