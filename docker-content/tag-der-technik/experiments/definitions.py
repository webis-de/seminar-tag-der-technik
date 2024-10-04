import re

from openai import OpenAI

client = OpenAI(api_key="blah", base_url="https://llm.srv.webis.de/v1")

def fetch_completion(systemprompt: str, userprompt: str, examples: list[tuple[str, str]] = []):
    messages = [{"role": "system", "content": systemprompt}]
    for input, output in examples:
        messages.extend([{"role": "user", "content": input}, {"role": "assistant", "content": output}])
    messages.append({"role": "user", "content": userprompt})
    completion = client.chat.completions.create(
        model="default",
        messages=messages,
    )
    return completion.choices[0].message.content

def extract_between(input: str, left_delim: str, right_delim: str):
    return re.findall(rf'{left_delim}(.*?){right_delim}', input)[0]