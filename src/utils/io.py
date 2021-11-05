def read_int_expect_eof(file, name=None, min_value=0, max_value=10 ** 9):
    name = "Target" if (name is None) else name

    try:
        value = int(file.read())
    except ValueError as e:
        raise ValueError(F'Incorrect value given: {name} expected to be integer', e)

    if value is None or value < min_value or value > max_value:
        raise ValueError(F'Incorrect value given:'
                         F' {name} expected to be in range [{min_value};{max_value}], given: {value}')

    return value


def read_int(file, name=None, min_value=0, max_value=10 ** 9):
    try:
        return read_int_expect_eof(file, name, min_value, max_value)
    except EOFError:
        raise ValueError("Unexpected EOF")


def read_str(file, name=None, min_length=1, max_length=10 ** 3):
    try:
        value = str(file.read())
    except EOFError:
        raise ValueError("Unexpected EOF")

    name = "Target" if (name is None) else name

    if value is None or len(value) < min_length or len(value) > max_length:
        raise ValueError(F'Incorrect value given:'
                         F' {name} expected to have length in range [{min_length};{max_length}], given: {value}')

    return value


def read_enum(file, cls, name=None):
    name = "Target" if (name is None) else name
    value = read_str(file, name)
    for key, genre in cls.__members__.items():
        if key == value:
            return key
    raise ValueError(F'Incorrect value given: {name} expected to be part of {cls.__name__}, given: {value}')


