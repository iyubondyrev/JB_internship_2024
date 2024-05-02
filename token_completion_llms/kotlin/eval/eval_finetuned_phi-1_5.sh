export CUDA_VISIBLE_DEVICES=0
LANG=kotlin
DATADIR=../../../datasets/token_completion_dataset/kotlin
LITFILE=../../../datasets/token_completion_dataset/kotlin/literals.json
OUTPUTDIR=save/
PRETRAINDIR=iyubondyrev/jb_2024_kotlin_phi-1_5
LOGFILE=completion_kotlin_eval.log

python -u ../../code/run_lm.py \
        --data_dir=$DATADIR \
        --lit_file=$LITFILE \
        --langs=$LANG \
        --output_dir=$OUTPUTDIR \
        --pretrain_dir=$PRETRAINDIR \
        --log_file=$LOGFILE \
        --model_type=phi_1_5 \
        --block_size=512 \
        --do_eval \
        --per_gpu_eval_batch_size=16 \
        --logging_steps=100 \
        --seed=42

python ../../code/evaluator.py -a=../../../datasets/token_completion_dataset/kotlin/test.txt -p=save/predictions.txt > eval_result_finetuned_phi-1_5.txt 2>&1

cp save/predictions.txt predictions_finetuned_phi_1_5.txt
