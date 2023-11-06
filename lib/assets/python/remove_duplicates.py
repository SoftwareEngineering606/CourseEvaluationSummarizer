import spacy
import sys

# Load a spaCy model (e.g., 'en_core_web_md')
try:
    nlp = spacy.load("en_core_web_md")
except: # If not present, we download
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
    
    unique_comments = '\n'.join(unique_comments)
    return unique_comments

# Example usage:
# comments = sys.argv[1]
# comments = comments.split('\n')
comments1 = [
    "There were some points in the class where the sheer number of assignments given out made it unclear what was expected.",
    "The requirements for some assignments were vague and sometimes I feel that some requirements weren't conveyed well to us.",
    "I hate the professor",
    "I dislike the professor",
    "A lot of the project requirements and document requirements were confusing because the rubric was not provided in the Canvas assignments",
    "There is so much information on the syllabus and Canvas that there is a bit of overload, complicating what exactly I should be prioritizing in the class",
    "I think there were organization issues but it was fixed towards the middle",
    "While it was clear for the most part, the way the course was structured was confusing"
]


unique_comments = remove_duplicate_comments(comments1)
print(unique_comments)
