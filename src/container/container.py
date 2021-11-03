from src.film.cartoon.cartoon import Cartoon
from src.film.documentary.documentary import Documentary
from src.film.feature.feature import Feature
from src.utils import io, rand


class Container:
    def __init__(self):
        self.array = []

    def read_from_file(self, file):
        while True:
            try:
                if len(self.array) == 0:
                    film_type = io.read_int(file, "Alternative's number", 1, 3)
                else:
                    film_type = io.read_int_expect_eof(file, "Alternative's number", 1, 3)

                if film_type == 1:
                    film = Feature()
                elif film_type == 2:
                    film = Cartoon()
                elif film_type == 3:
                    film = Documentary()
                else:
                    raise RuntimeError("Incorrect film type read")

                film.read_from_file(file)
                self.array.append(film)
            except EOFError:
                return
            except ValueError as e:
                print("Error: ", str(e))
                exit(1)

    def read_stochastic(self, size):
        if size <= 0:
            raise ValueError("Count of entries should be > 0")

        for i in range(size):
            film_type = rand.random_int(1, 3)
            if film_type == 1:
                film = Feature()
            elif film_type == 2:
                film = Cartoon()
            elif film_type == 3:
                film = Documentary()
            else:
                raise RuntimeError("Incorrect film type generated by random")
            film.fill_stochastic()
            self.array.append(film)

    def write_to_file(self, file):
        for i in range(len(self.array)):
            file.write(F'{i + 1}. ')
            self.array[i].write_to_file(file)
            file.write(F', sort_key = {self.array[i].sort_key}\n')

    def sort(self):
        for i in range(len(self.array)):
            for j in range(len(self.array)):
                first = self.array[i].sort_key
                second = self.array[j].sort_key

                if second < first:
                    self.array[i], self.array[j] = self.array[j], self.array[i]
