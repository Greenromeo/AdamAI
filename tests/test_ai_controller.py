import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

import unittest
from core.ai_controller import AIController

class TestAIController(unittest.TestCase):
    def setUp(self):
        self.controller = AIController()

    def test_interact_with_ai(self):
        response = self.controller.interact_with_ai('Hello, AdamAI!')
        self.assertTrue(len(response) > 0, 'Response should not be empty')

if __name__ == '__main__':
    unittest.main()
