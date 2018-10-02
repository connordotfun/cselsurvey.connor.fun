import markovify

# Create markov chain model from text in filename
def generate_model(filename, output_filename=None):
    with open(filename) as f:
        text = f.read()

    model = markovify.Text(text)
    if output_filename is not None:
        model_json = model.to_json()
        with open(output_filename, 'w') as op:
            op.write(model_json)
        
    return model

# will attempt 100 times to make an original sentance, but could return "None" if this can't be done.
def generate_sentences_from_model(text_model, count = 1):
    ret = []
    for i in range(count):
        # override to allow generated sentances to match up to 50% of the original
        sent = text_model.make_sentence(tries = 100, max_overlap_ratio = 0.5) 
        ret.append(sent)

    return ret
    
# Get saved model or create a new one, and return `count` sentances generated from that.
# This is the main function to use.
def get_sentences(response_filename='responses.txt', output_filename=None, count=1):
    if output_filename is None:
        text_model = generate_model(response_filename)
    else:
        try:
            with open(output_filename, 'r') as f:
                text_model = markovify.Text.from_json(f.read())
        except:
            text_model = generate_model(response_filename, output_filename)

    return generate_sentences_from_model(text_model, count=count)


if __name__ == "__main__":
    input_filename = "responses.txt"
    output_filename = "mc_responses.json"
    sent = get_sentences(input_filename, output_filename=output_filename, count = 20)
    for s in sent:
        print(s)





