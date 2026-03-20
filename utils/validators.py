import re

def is_valid_email(email):
    return re.match(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$", email)

def is_strong_password(password):
    return len(password) >= 6

def is_safe_name(name):
    return re.match(r"^[A-Za-z]+$", name)