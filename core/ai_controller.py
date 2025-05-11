from llm.engine import AdamLLM

class AIController:
    def __init__(self):
        self.llm = AdamLLM()

    def interact_with_ai(self, prompt):
        return self.llm.ask(prompt)

