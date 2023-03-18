def find_longest_prefix(prefixes, array):
    for prefix in (prefixes):
        for line in content:
            if line.startswith(prefix):
                return line
    return None

if __name__ == "__main__":
    with open("3.txt") as f:
        content = [x.strip() for x in f.readlines()]

    gamma_prefixes = ["010111011111","01011101111","0101110111","010111011","01011101","0101110","010111","01011","0101","010","01","0"]
    epsilon_prefixes = ["101000100000","10100010000","1010001000","101000100","10100010","1010001","101000","10100","1010","101","10","1"]

    o2_str = find_longest_prefix(gamma_prefixes, content)
    co2_str = find_longest_prefix(epsilon_prefixes, content)

    o2 = int(o2_str, 2)
    co2 = int(co2_str, 2)
    
    print(o2 * co2)

