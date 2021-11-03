import random


def random_enum(cls):
    return random.choice(list(cls.__members__.items()))[0]


def random_int(min_value=0, max_value=10 ** 9):
    return random.randint(min_value, max_value)


def random_str(min_length=1, max_length=51, alpha=range(ord('a'), ord('z'))):
    length = random_int(min_length, max_length)
    return ''.join(random.choice([chr(i) for i in alpha]) for _ in range(length))