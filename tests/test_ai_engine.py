# tests/test_ai_engine.py

import os
from core.ai_engine import AIEngine

def test_get_model(tmp_path):
    # Simulate a test model
    test_model_path = tmp_path / "ggml-gpt4all-l13b-snoozy.bin"
    test_model_path.write_bytes(b"test content")

    engine = AIEngine()
    engine.model_path = str(test_model_path)  # Inject test path

    data = engine.get_model()
    assert data == b"test content"
