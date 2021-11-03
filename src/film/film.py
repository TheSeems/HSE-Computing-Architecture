from abc import ABC, abstractmethod

from src.utils import io, rand


class Film(ABC):
    min_year = 1970
    max_year = 3022

    def __init__(self):
        self.year = 1970
        self.title = "Untitled"

    @property
    def year(self):
        return self._year

    @property
    def title(self):
        return self._title

    @property
    def sort_key(self):
        return 1.0 * self.year / float(len(self.title))

    @year.setter
    def year(self, value):
        self._year = value

    @title.setter
    def title(self, value):
        self._title = value

    @abstractmethod
    def read_from_file(self, file):
        self.title = io.read_str(file, 'Film title')
        self.year = io.read_int(file, 'Year', min_value=Film.min_year, max_value=Film.max_year)

    @abstractmethod
    def fill_stochastic(self):
        self.title = rand.random_str()
        self.year = rand.random_int(Film.min_year, Film.max_year)
        pass

    @abstractmethod
    def write_to_file(self, file):
        pass
