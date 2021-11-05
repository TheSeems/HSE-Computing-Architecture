from typing import IO


class FileWrapper:
    @staticmethod
    def generate(file: IO):
        word = ''
        while True:
            char = file.read(1)
            if char.isspace():
                if word:
                    yield word
                    word = ''
            elif char == '':
                if word:
                    yield word
                break
            else:
                word += char

    def __init__(self, stream):
        self.generator = self.generate(stream)

    def read(self):
        try:
            return next(self.generator)
        except StopIteration:
            raise EOFError()
