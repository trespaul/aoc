with open("2.txt") as f:
    content = f.readlines()

d = [s.strip().split() for s in content]

aim = 0
horiz = 0
depth = 0

for action, x in d:
    x = int(x)
    if action == "forward":
        horiz += x
        depth += aim * x
    elif action == "up":
        aim -= x
    else:
        aim += x

print("aim:  ", aim,
      "horiz:", horiz,
      "depth:", depth)
print("h*d = ", horiz*depth)
