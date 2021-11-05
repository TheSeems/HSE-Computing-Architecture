import random
from abc import ABC, abstractmethod
from typing import IO

from src.utils import io, rand
from src.utils.file_wrapper import FileWrapper


class Film(ABC):
    min_year = 1970
    max_year = 3022

    def __init__(self):
        self.year = 1970
        self.title = "Untitled"

    @property
    def sort_key(self):
        return 1.0 * self.year / float(len(self.title))

    @abstractmethod
    def read_from_file(self, file: FileWrapper):
        self.title = io.read_str(file, 'Film title')
        self.year = io.read_int(file, 'Year', min_value=Film.min_year, max_value=Film.max_year)

    @abstractmethod
    def fill_stochastic(self):
        self.title = rand.random_str()
        self.year = random.randint(Film.min_year, Film.max_year)

    @abstractmethod
    def write_to_file(self, file: IO):
        pass
