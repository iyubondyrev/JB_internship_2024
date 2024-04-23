export CUDA_VISIBLE_DEVICES=0
LANG=kotlin
DATADIR=../../../datasets/kotlin
LITFILE=../../../datasets/kotlin/literals.json
OUTPUTDIR=../save/
PRETRAINDIR=microsoft/CodeGPT-small-py-adaptedGPT2
LOGFILE=completion_kotlin_eval.log

python -u ../../code/run_lm.py \
        --data_dir=$DATADIR \
        --lit_file=$LITFILE \
        --langs=$LANG \
        --output_dir=$OUTPUTDIR \
        --pretrain_dir=$PRETRAINDIR \
        --log_file=$LOGFILE \
        --model_type=gpt2 \
        --block_size=1024 \
        --do_eval \
        --per_gpu_eval_batch_size=16 \
        --logging_steps=100 \
        --seed=42

python ../../code/evaluator.py -a=../../../datasets/kotlin/test.txt -p=../save/predictions.txt > eval_result.txt 2>&1

cp ../save/predictions.txt .