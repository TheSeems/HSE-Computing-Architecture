from enum import Enum

from src.utils.file_wrapper import FileWrapper


def read_int_expect_eof(file: FileWrapper, name: str = None, min_value:int = 0, max_value: int = 10 ** 9):
    name = "Target" if (name is None) else name

    try:
        value = int(file.read())
    except ValueError as e:
        raise ValueError(F'Incorrect value given: {name} expected to be integer', e)

    if value is None or value < min_value or value > max_value:
        raise ValueError(F'Incorrect value given:'
                         F' {name} expected to be in range [{min_value};{max_value}], given: {value}')

    return value


def read_int(file: FileWrapper, name: str = None, min_value: int = 0, max_value: int = 10 ** 9):
    try:
        return read_int_expect_eof(file, name, min_value, max_value)
    except EOFError:
        raise ValueError("Unexpected EOF")


def read_str(file: FileWrapper, name: str = None, min_length: int = 1, max_length: int = 10 ** 3):
    try:
        value = str(file.read())
    except EOFError:
        raise ValueError("Unexpected EOF")

    name = "Target" if (name is None) else name

    if value is None or len(value) < min_length or len(value) > max_length:
        raise ValueError(F'Incorrect value given:'
                         F' {name} expected to have length in range [{min_length};{max_length}], given: {value}')

    return value


