# tests/test_ai_controller.py

import unittest
from core.ai_controller import AIController
from core.ai_engine import AIEngine

class TestAIController(unittest.TestCase):
    def setUp(self):
        mock_engine = AIEngine()
        mock_engine.get_model = lambda: b"mock model"
        self.controller = AIController(mock_engine)

    def test_interact_with_ai(self):
        result = self.controller.execute()
        self.assertEqual(result, b"mock model")
