# Token completion

This directory contains scripts for training and evaluating language model (LLM) models on token completion datasets for Kotlin and Python. For detailed insights about these datasets, refer to the `datasets/` folder. The training and evaluation code originates from the [CodeXGLUE project](https://github.com/microsoft/CodeXGLUE/tree/main/Code-Code/CodeCompletion-token), with minor adaptations to integrate wandb loging and Microsoft phi-1_5 model compatibility. You can find the code in the `/code` directory.

## Kotlin

### Training Procedure

To initiate the training pipeline, ensure that the corresponding dataset is present in the `datasets/` directory.

Execute one of the following commands based on the model you wish to train:

```bash
bash train_vanilla_gpt_py.sh
```

or

```bash
bash train_vanilla_phi-1_5.sh
```

*Note*: To integrate wandb for logging and tracking experiments, please ensure you are logged into wandb and specify the WANDB_PROJECT and WANDB_RUN variables in the scripts. If you choose not to use wandb, remove the declarations of these variables along with the following lines from the script:

```bash
--wandb_project_name=$WANDB_PROJECT \
--wandb_run=$WANDB_RUN \
```

You can see the logs of the training in the `/train` folder

Links to the resulting models:

- [Gpt-py](https://huggingface.co/iyubondyrev/jb_2024_kotlin_gpt)
- [Phi-1_5](https://huggingface.co/iyubondyrev/jb_2024_kotlin_phi-1_5)


[Link](https://wandb.ai/ivan-bondivan-bond/JB_internship_2024?nw=nwuserivanbondivanbond) to the WandB project with graphs.


### Evaluation

To evaluate the four models, execute the following commands, which pertain to the models developed in the previous training phase:

```bash
bash eval_finetuned_gpt_py.sh
```

```bash
bash eval_finetuned_phi-1_5.sh
```

For the vanilla versions of the models, use:

```bash
bash eval_vanilla_gpt_py.sh
```

```bash
bash eval_vanilla_phi-1_5.sh
```

Each script generates a .txt file containing the results of the evaluations and predictions made by the models. For detailed understanding, refer to the content of these scripts.

You can see results and predictions in the `predictions/` and `results/` folders.

## Python

### Evaluation

The evaluation process for Python follows the same procedure as for Kotlin.


## Results

### Python

The table below shows the evaluation metrics for models tested on Python for the token completion task:

| Model Description                                      | Accuracy |
|--------------------------------------------------------|----------|
| GPT-Py Vanilla                                         | 45.58    |
| Phi-1_5 Vanilla                                        | 56.70    |
| GPT-Py Trained on Token Completion (Kotlin) | 58.04    |
| Phi-1_5 Trained on Token Completion (Kotlin) | 53.04    |

Observations: Vanilla models show a marked improvement in accuracy after fine-tuning on Kotlin data, with GPT-Py showing notable gains. However, Phi-1_5 shows a slight decrease, suggesting potential overfitting or issues with how the model adapts to the new dataset. The improvement in GPT-Py's performance likely stems from the similar structures of the datasets used. For instance, the model becomes more adept at predicting common tokens like <EOL> after fine-tuning on the Kotlin data.

### Kotlin

The table below shows the evaluation metrics for models tested on Kotlin:

| Model Description                                      | Accuracy |
|--------------------------------------------------------|----------|
| GPT-Py Vanilla                                         | 43.96    |
| Phi-1_5 Vanilla                                        | 57.96    |
| GPT-Py Trained on Token Completion (Kotlin) | 76.18    |
| Phi-1_5 Trained on Token Completion (Kotlin) | 80.33    |

Observations: The fine-tuning on Kotlin significantly boosts the performance of both models, with Phi-1_5 achieving an impressive accuracy of over 80%.
 
