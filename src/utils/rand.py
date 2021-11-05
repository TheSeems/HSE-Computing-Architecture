import random
import string


def random_str(min_length: int = 1, max_length: int = 51, alpha: str = string.ascii_lowercase):
    length = random.randint(min_length, max_length)
    return ''.join(random.choice(alpha) for _ in range(length))
