from src.film.film import Film
from src.utils import io, rand


class Feature(Film):
    min_duration = 10
    max_duration = 3600

    def __init__(self):
        super().__init__()
        self.director = "Unknown director"

    def read_from_file(self, file):
        super().read_from_file(file)
        self.director = io.read_str(file, "Director")

    def fill_stochastic(self):
        super().fill_stochastic()
        self.director = rand.random_str()

    def write_to_file(self, file):
        file.write('Feature{' + F'title={self.title},year={self.year},director={self.director}' + '}')