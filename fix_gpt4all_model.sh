#!/bin/bash
# Fix script to handle local model loading

# Update llm/engine.py to check for the local model
cat << 'EOF2' > ~/Projects/AdamAI/llm/engine.py
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
EOF2

# Create a models directory if it doesn't exist
mkdir -p ~/Projects/AdamAI/models

echo 'Fix applied! Please download the model manually and place it in ~/Projects/AdamAI/models/'
