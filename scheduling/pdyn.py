#!/usr/bin/python
# -*- coding: UTF-8 -*-

from sys import maxint as inf
from itertools import permutations
from timeit import Timer
import random
import csv


class Dynamic(object):

    def __init__(self):
        self.p = []    # czasy wykonań
        self.d = []    # chwile zmian wartości
        self.w = [[]]  # wartosci zadań w przedziałach
        self.n = 0     # liczba zadań
        self.k = 0     # liczba przedziałów

    def set_random_instance(self, tasks, partitions):
        self.n = tasks
        self.k = partitions
        max_time = int(5.0 * tasks / partitions)
        max_val = tasks + partitions
        self.p = [random.randint(1, max_time) for x in xrange(tasks)]
        self.w = [[] for x in xrange(self.n)]
        for l in self.w:
            while len(l) < self.k:
                x = random.randint(1, max_val)
                if x not in l:
                    l.append(x)
            l.sort(reverse=True)
        self.d = [x * 2 for x in xrange(self.k - 1)]
        self.d.append(inf)

    def solve_brute_force(self):
        max_value = 0
        for order in permutations(range(self.n)):
            value = 0
            result = []
            d = list(self.d)
            for task in order:
                prev = 0
                for i, part in enumerate(self.d):
                    if d[i] - prev >= self.p[task]:
                        result.append(task + 1)
                        d = d[:i] + [x - self.p[task] for x in d[i:]]
                        value += self.w[task][i]
                        prev = d[i]
                        break
                    prev = d[i]
            if value > max_value:
                max_value = value
        return max_value

    def solve(self):
        d = list(self.d)
        value = 0
        value_dict = {}
        for task in xrange(self.n):
            best = []
            prev = 0
            for i, part in enumerate(d):
                if part - prev >= self.p[task]:
                    best.append(self.w[task][i])
                else:
                    best.append(-inf)
                prev = part
            best_value = max(best)
            value = value + best_value
            i = best.index(best_value)
            d = d[:i] + [x - self.p[task] for x in d[i:]]
        return value


if __name__ == '__main__':
    dyn = Dynamic()
    tests_nb = 100
    states = (
        (8, 4), (7, 4), (6, 4), (5, 4), (4, 4),
        (8, 4), (8, 5), (8, 6), (8, 7), (8, 8)
    )
    algorithm, brute_force = 0, 0
    output = csv.writer(open('output.csv', 'w'))
    output.writerow(['tasks', 'partitions', 'algorithm', 'brute_force'])

    for tasks, partitions in states:
        dyn.set_random_instance(tasks, partitions)

        t = Timer('dyn.solve()', 'from __main__ import dyn')
        algorithm = t.timeit(tests_nb)
        print 'Algorithm; tasks:', tasks, 'partitions:', partitions

        t = Timer('dyn.solve_brute_force()', 'from __main__ import dyn')
        brute_force = t.timeit(tests_nb)
        print 'Brute force; tasks:', tasks, 'partitions:', partitions

        output.writerow([tasks, partitions, algorithm, brute_force])
