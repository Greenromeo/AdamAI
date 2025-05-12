# core/ai_controller.py

class AIController:
    def __init__(self, engine):
        self.engine = engine

    def execute(self):
        try:
            model_data = self.engine.get_model()
            return model_data
        except Exception as e:
            print(f"Error in execution: {e}")
            return None
