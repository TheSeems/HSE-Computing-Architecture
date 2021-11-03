from src.film.film import Film

from enum import Enum

from src.utils import io, rand


class CartoonGenre(Enum):
    DRAWING = "DRAWING"
    PUPPET = "PUPPET"
    PLASTICINE = "PLASTICINE"


class Cartoon(Film):
    def __init__(self):
        super().__init__()
        self.genre = None

    def read_from_file(self, file):
        super(Cartoon, self).read_from_file(file)
        self.genre = io.read_enum(file, CartoonGenre, "Cartoon genre")

    def fill_stochastic(self):
        super(Cartoon, self).fill_stochastic()
        self.genre = rand.random_enum(CartoonGenre)

    def write_to_file(self, file):
        file.write('Cartoon{' + F'title={self.title},year={self.year},genre={self.genre}' + '}')
