from copy import deepcopy
from statistics import mode

def count(criteria, array):
    count = 0
    for item in array:
        if criteria(item):
            count += 1
    return count

def find_mode(content, antimode=False):
    transposed = [list(l) for l in list(zip(*content))]
    modes = [mode(line) for line in transposed]
    if antimode:
        return ['1' if b == '0' else '0' for b in modes]
    else:
        return modes

def search(content, antimode=False):
    for j, line in zip(range(len(content)), content):
        print(content)
        if line == None:
            continue
        modes = find_mode([line for line in content if line != None], antimode=antimode)
        if line == "".join(modes):
            return line
        print("".join(modes))
        if count(lambda x: x != None, content) == 1:
            print("onely one line left:")
            return line
        for i, bit in zip(range(len(modes)), modes):
            if line[i] != bit:
                content[j] = None
                break


if __name__ == "__main__":
    with open("3-test.txt") as f:
        content = [line.strip() for line in f.readlines()]
    
    print(search(deepcopy(content)))
    print(search(content, antimode=True))

    
