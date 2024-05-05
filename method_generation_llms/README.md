
# Method Generation

This directory contains scripts for training and evaluating language model (LLM) models on method generation datasets for Kotlin and Python. For detailed insights about these datasets, refer to the `datasets/` folder. The training and evaluation code originates from the [CodeXGLUE project](https://github.com/microsoft/CodeXGLUE/tree/main/Code-Code/Method-Generation), with minor adaptations to integrate Kotlin-style docstring support and Microsoft phi-1_5 model compatibility. You can find the code in the `/code` directory.

## Kotlin

### Training Procedure

To initiate the training pipeline, ensure that the corresponding dataset is present in the `datasets/` directory.

Execute one of the following commands based on the model you wish to train:

```bash
bash train_my_gpt_py.sh
```

or

```bash
bash train_my_phi-1_5.sh
```

These scripts manage the training processes for the finetuned [phi-1_5 model](https://huggingface.co/iyubondyrev/jb_2024_kotlin_phi-1_5) and the finetuned [gpt-py model](https://huggingface.co/iyubondyrev/jb_2024_kotlin_gpt), which were originally adapted from their respective vanilla versions: [small gpt py](https://huggingface.co/microsoft/CodeGPT-small-py-adaptedGPT2/discussions) and [phi-1_5](https://huggingface.co/microsoft/phi-1_5). These models were specifically finetuned on the [token completion dataset](https://huggingface.co/iyubondyrev/token_completion_kotlin) for the Kotlin language. For comprehensive details on the finetuning stage, see the `token_completion_llms/` directory. For in-depth training information (e.g., hyperparameters), consult the scripts `train_my_phi-1_5.sh` and `train_my_gpt_py.sh`. 

You can see the logs of the training in the `/train` folder

Links to the resulting models, first finetuned on the Kotlin token completion dataset and subsequently trained on the method generation datasets with functions strictly containing docstrings, are as follows:

- [Gpt-py](https://huggingface.co/iyubondyrev/jb_2024_kotlin_method_gen_gpt)
- [Phi-1_5](https://huggingface.co/iyubondyrev/jb_2024_kotlin_method_gen_gpt)

### Evaluation

To evaluate the four models, execute the following commands, which pertain to the models developed in the previous training phase:

```bash
bash eval_kotlin_method_gen_gpt_py.sh
```

```bash
bash eval_kotlin_method_gen_phi-1_5.sh
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

The table below shows the evaluation metrics for models tested on Python:

| Model Description                                                       | Edit Similarity | BLEU  |
|-------------------------------------------------------------------------|-----------------|-------|
| GPT-Py Vanilla                                                          | 3.29            | 0.06  |
| Phi-1_5 Vanilla                                                         | 2.99            | 0.41  |
| GPT-Py Trained on Token Completion & Method Gen (Kotlin)                | 19.78           | 0.00  |
| Phi-1_5 Trained on Token Completion & Method Gen (Kotlin)               | 13.01           | 0.01  |

Observations: The vanilla versions of both models performed modestly, but notably worsened in terms of the BLEU metric after fine-tuning on Kotlin data. While Edit Similarity (ES) improved, the significance of this metric diminishes given the low BLEU scores.

### Kotlin

The table below shows the evaluation metrics for models tested on Kotlin:

| Model Description                                                       | Edit Similarity | BLEU  |
|-------------------------------------------------------------------------|-----------------|-------|
| GPT-Py Vanilla                                                          | 4.20            | 0.01  |
| Phi-1_5 Vanilla                                                         | 5.70            | 1.69  |
| GPT-Py Trained on Token Completion & Method Gen (Kotlin)                | 3.88            | 0.08  |
| Phi-1_5 Trained on Token Completion & Method Gen (Kotlin)               | 36.06           | 6.32  |

Observations: The vanilla Phi-1_5 model produced a respectable BLEU score of 1.7, indicating some success relative to other vanilla models. After fine-tuning, while the GPT-Py model showed marginal improvement, the Phi-1_5 model demonstrated significantly better performance, achieving impressive scores for both BLEU and ES.

## Brief Conclusion

The strategy of sequential fine-tuning—first on token completion and then on method generation datasets—appears promising as it enhances the model's understanding of the Kotlin language (because the first dataset has much more data and it is not so uniform). However, the final phase of fine-tuning seems to have led to some overfitting, particularly with the Phi-1_5 model, which often generated excessive function declarations, indicating potential overfitting to patterns seen in the method generation dataset. Additionally, the GPT-Py model exhibited unusual behavior, repetitively generating text that seemed like a constant stream of redundant phrases. This pattern suggests that the last stage of fine-tuning (on the method generation dataset) may have trapped the model in a suboptimal local minimum regarding the loss function. Optimizing parameters such as weight decay, learning rate and other parametrs in the final training phase could mitigate these issues, improving model robustness and preventing the model from settling into these problematic behaviors.


