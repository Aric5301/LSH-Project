import random
import os


def genome_generator(window_count, file_name):
    open(file_name, 'w').close()
    dna = ["A", "G", "C", "T"]
    # initialize empty string
    # this is where the bases will be added as they are generated
    sequence = ''
    # We'll create a string of random bases
    for i in range(128 + 113 * (window_count - 1)):
        sequence += random.choice(dna)
    # writing the genome into the file
    f = open(file_name, "a")
    f.write(sequence)
    f.close()


def read_extract(window_count, file_name, read_number):
    open(file_name, 'w').close()
    dna = ["A", "G", "C", "T"]
    # draw an index of the reference to start the read from and
    start_index = random.randrange(128 + 113 * (reference_window_count - 2))
    correct_window = ((start_index - 128) // 113) + 1 if start_index >= 128 else 0
    print("file " + str(read_number) + " starts at window " + str(correct_window) + " of the reference")

    # copy read from reference and keep only the relevant section
    f = open("reference_sv.txt", 'r')
    sequence = f.read()
    end_index = min(start_index + 128 + window_count * 113, len(sequence))
    sequence = sequence[start_index:end_index]

    if read_number in range(6, 10):
        edition_rate = 0
    elif read_number in range(11, 15):
        edition_rate = 0.02
    elif read_number in range(16, 20):
        edition_rate = 0.04
    else:
        edition_rate = 0.06

    # edit reads by add, delete or change random bases from the read according to edition rates above
    for j in range(round(edition_rate * len(sequence))):
        edit_func_index = random.randrange(3)
        edit_index = random.randrange(len(sequence))

        if edit_func_index == 0 and len(sequence) > 128:
            sequence = sequence[:edit_index - 1] + sequence[edit_index + 1:]
        elif edit_func_index == 1:
            sequence = sequence[:edit_index] + random.choice(dna) + sequence[edit_index + 1:]
        else:
            sequence = sequence[:edit_index - 1] + random.choice(dna) + sequence[edit_index + 1:]
    # writing the read into the file
    f = open(file_name, 'w')
    f.write(sequence)
    f.close()


# setting reference window number and reference file
reference_window_count = 100
genome_generator(reference_window_count, "reference_sv.txt")

# creating a new read folder
if not os.path.exists("read_files"):
    os.mkdir("read_files")

# setting files and random window number window and read files
for i in range(5):
    file_name = "./read_files/read_sv_" + str(i) + ".txt"
    window_count = random.randint(1, 16)
    print("file " + str(i) + " is not from the reference")
    genome_generator(window_count, file_name)

for i in range(5, 25):
    file_name = "./read_files/read_sv_" + str(i) + ".txt"
    window_count = random.randint(1, 16)
    read_extract(window_count, file_name, i)
