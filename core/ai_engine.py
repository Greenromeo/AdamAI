# core/ai_engine.py

import os

class AIEngine:
    def __init__(self, model_filename="ggml-gpt4all-l13b-snoozy.bin"):
        self.model_path = os.path.join("models", model_filename)

    def get_model(self):
        if not os.path.isfile(self.model_path):
            raise FileNotFoundError(f"Model file not found at {self.model_path}")
        with open(self.model_path, "rb") as f:
            return f.read()
