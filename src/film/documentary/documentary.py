import random

from src.film.film import Film
from src.utils import io, rand


class Documentary(Film):
    min_duration = 10
    max_duration = 3600

    def __init__(self):
        super().__init__()
        self.duration = Documentary.min_duration

    def read_from_file(self, file):
        super(Documentary, self).read_from_file(file)
        self.duration = io.read_int(file, "Documentary duration",
                                       Documentary.min_duration,
                                       Documentary.max_duration)

    def fill_stochastic(self):
        super(Documentary, self).fill_stochastic()
        self.duration = random.randint(Documentary.min_duration, Documentary.max_duration)

    def write_to_file(self, file):
        file.write('Documentary{' + F'title={self.title},year={self.year},duration={self.duration}' + '}')
