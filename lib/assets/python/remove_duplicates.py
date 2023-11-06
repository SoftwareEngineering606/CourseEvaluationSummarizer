import spacy
import sys

# Load a spaCy model (e.g., 'en_core_web_md')
try:
    nlp = spacy.load("en_core_web_md")
except:  # If not present, we download
    spacy.cli.download("en_core_web_md")
    nlp = spacy.load("en_core_web_md")

def is_duplicate(comment, unique_comments, similarity_threshold=0.9):
    doc1 = nlp(comment)

    for unique_comment in unique_comments:
        doc2 = nlp(unique_comment)
        similarity = doc1.similarity(doc2)

        if similarity >= similarity_threshold:
            return True

    return False

def remove_duplicate_comments(comments):
    unique_comments = []

    for comment in comments:
        if not is_duplicate(comment, unique_comments):
            unique_comments.append(comment)

    return unique_comments

# Example usage:
if __name__ == "__main__":
    comments_str = sys.argv[1]
    comments = comments_str.split("\n")
    unique_comments = remove_duplicate_comments(comments)
    print("\n".join(unique_comments))
