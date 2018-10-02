#!/usr/bin/env python3
import json
import basic_markov

def write_headers():
    print("Content Type: application/json")
    print() #  empty line ends headers


def write_sentence():
    output = basic_markov.get_sentences(response_filename="cgi_bin/responses.txt")[0]

    json_result = json.dumps({"output": output})

    print(json_result)

if __name__ == "__main__":
    write_headers()
    write_sentence()