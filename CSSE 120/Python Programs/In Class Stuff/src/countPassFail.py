def countFailPass(scores):
    passing = 0
    failing = 0
    for i in scores:
        if i >= 60:
            passing = passing + 1
        else:
            failing = failing + 1
    return passing, failing
def main():
    scores = [70, 80, 90, 100]
    passing, failing = countFailPass(scores)
    print "%0.f students are passing" % (passing)
    print "%0.f students are failing" % (failing)
main()