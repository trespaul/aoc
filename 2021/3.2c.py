from copy import deepcopy

def mode(l):
    return '1' if l.count('1') >= l.count('0') else '0'

def find_modes(content, antimode=False):
    transposed = [list(l) for l in list(zip(*content))]
    modes = [mode(line) for line in transposed]
    if antimode:
        return ['1' if b == '0' else '0' for b in modes]
    else:
        return modes

def search(candidates, antimode=False):
    prunelist = deepcopy(candidates)

    for i in range(len(prunelist[0]) + 1):
        if len(prunelist) == 1:
            return prunelist[0]
        modebit = find_modes(prunelist, antimode)[i]
        prunelist = list(filter(lambda x: True if x[i] == modebit 
                                               else False,
                                prunelist))

if __name__ == "__main__":
    with open("3.txt") as f:
        content = [line.strip() for line in f.readlines()]
    oxy = int(search(content), 2)
    co2 = int(search(content, antimode=True), 2)
    print(oxy * co2)



# make results array as copy of all lines
# for all bits in length of line
# - compute mode of specific bit of lines in results
# - remove all lines from results which line[position] != mode bit
# - if only one left, break
