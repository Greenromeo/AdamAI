# tests/test_engine.py

import pytest
from core.ai_controller import AIController
from core.ai_engine import AIEngine

class MockSuccessEngine:
    def get_model(self):
        return b"mock model data"

class MockFailEngine:
    def get_model(self):
        raise Exception("Simulated model fetch failure")

def test_controller_success():
    controller = AIController(MockSuccessEngine())
    result = controller.execute()
    assert result == b"mock model data"

def test_controller_failure():
    controller = AIController(MockFailEngine())
    result = controller.execute()
    assert result is None
