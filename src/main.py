#! /usr/bin/python3
import inspect
import sys
import time

from src.container import Container
from src.utils.file_wrapper import FileWrapper


def send_incorrect_usage():
    print(inspect.cleandoc(
        """
        Incorrect usage.
          Expected:
            command -f input_file output_file_1 output_file_2
          Or:
            command -n size output_file_1 output_file_2
        """))


def send_incorrect_qualifier():
    print(inspect.cleandoc(
        """
        Incorrect qualifier value.
          Expected:
            command -f input_file output_file_1 output_file_2
          Or:
            command -n size output_file_1 output_file_2
        """))


def via_file(my_container, file_name):
    with open(file_name, 'r') as file:
        my_container.read_from_file(FileWrapper(file))


def via_stochastic(my_container, size):
    try:
        size = int(size)
    except ValueError:
        print("Incorrect size given: not an integer")
        exit(1)

    if size < 1:
        raise ValueError("Incorrect size given")

    my_container.read_stochastic(size)


def sort_with_container(my_container, original_output_filename, sorted_output_filename):
    with open(original_output_filename, "w+") as out_first, \
            open(sorted_output_filename, "w+") as out_second:
        out_first.write("Input container:\n")
        my_container.write_to_file(out_first)

        out_second.write("Sorted container:\n")
        container.sort()
        my_container.write_to_file(out_second)


if __name__ == "__main__":
    argv = sys.argv
    argc = len(argv)

    if argc != 5:
        send_incorrect_usage()
        exit(1)

    start = time.process_time()
    container = Container()
    if argv[1] == "-f":
        via_file(container, argv[2])
    elif argv[1] == "-n":
        via_stochastic(container, argv[2])
    else:
        send_incorrect_qualifier()
        exit(1)

    sort_with_container(container, argv[3], argv[4])

    finish = time.process_time()
    elapsed_time = finish - start
    print('Time elapsed', str(elapsed_time) + "s")
