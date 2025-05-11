echo "import argparse
from llm.engine import AdamLLM

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('prompt', type=str, help='Ask AdamAI something')
    args = parser.parse_args()

    ai = AdamLLM()
    response = ai.ask(args.prompt)
    print('AdamAI:', response)

if __name__ == '__main__':
    main()" > ~/Projects/AdamAI/cli/main.py
