# config/settings.py

class Settings:
    def __init__(self):
        self.model_url = "http://example.com/model"

    def get_model_url(self):
        return self.model_url
