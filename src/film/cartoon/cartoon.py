import random

from enum import Enum
from typing import IO

from src.utils import io
from src.film.film import Film
from src.utils.file_wrapper import FileWrapper


class CartoonGenre(Enum):
    DRAWING = "DRAWING"
    PUPPET = "PUPPET"
    PLASTICINE = "PLASTICINE"


class Cartoon(Film):
    def __init__(self):
        super().__init__()
        self.genre = None

    @staticmethod
    def read_genre(file):
        name = "Cartoon genre"
        value = io.read_str(file, name)
        for key, genre in [(meta.name, meta.value) for meta in CartoonGenre]:
            if key == value:
                return key
        raise ValueError(F'Incorrect value given: {name} expected to be part of '
                         F'{[meta.value for meta in CartoonGenre]}, given: {value}')

    def read_from_file(self, file: FileWrapper):
        super(Cartoon, self).read_from_file(file)
        self.genre = self.read_genre(file)

    def fill_stochastic(self):
        super(Cartoon, self).fill_stochastic()
        self.genre = random.choice([meta.value for meta in CartoonGenre])

    def write_to_file(self, file: IO):
        file.write('Cartoon{' + F'title={self.title},year={self.year},genre={self.genre}' + '}')
