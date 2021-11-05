import random
import string


def random_enum(cls):
    return random.choice(list(cls.__members__.items()))[0]


def random_str(min_length=1, max_length=51, alpha=string.ascii_lowercase):
    length = random.randint(min_length, max_length)
    return ''.join(random.choice(alpha) for _ in range(length))
