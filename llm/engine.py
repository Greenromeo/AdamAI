import os
from gpt4all import GPT4All

class AdamLLM:
    def __init__(self, model_name='gpt4all-13b-snoozy'):
        model_path = f'./models/{model_name}'
        if not os.path.exists(model_path):
            raise ValueError(f'Model {model_name} not found in {model_path}')
        self.model = GPT4All(model_path=model_path)

    def ask(self, prompt):
        return self.model.chat_completion(prompt)
