# Computational Intelligence 2024

Coursework for the Computational Intelligence course at Politecnico di Torino (2024): the final project on symbolic regression and four labs on search and optimisation.

| Folder | Topic |
|---|---|
| [`src/`](src), [`s321463.py`](s321463.py), [`data/`](data) | **Project:** symbolic regression with genetic programming (below) |
| [`labs/lab1-set-cover`](labs/lab1-set-cover) | Set cover: minimum-cost subfamily covering every element |
| [`labs/lab2-tsp`](labs/lab2-tsp) | Travelling salesman on real city datasets |
| [`labs/lab3-n-puzzle`](labs/lab3-n-puzzle) | n²−1 puzzle solved with path search |
| [`labs/lab0-intro`](labs/lab0-intro) | Course warm-up |

The labs were originally separate repositories (`CI2024_lab0`–`CI2024_lab3`); this repository brings them together with the project, whose full commit history is kept.

## Project: symbolic regression
Project Overview
The goal of this project is to use symbolic regression to find mathematical formulas that predict target variables based on input features, focusing on both accuracy and simplicity. The approach uses Genetic Programming to evolve mathematical expressions represented as tree-based structures.

Components:
Operators: Basic arithmetic and trigonometric operations (e.g., sin, cos, +, -, *, /, etc.).
Constants: A set of 50 constants ranging between -10 and 10, which can evolve during mutation.
Variables: Correspond to the features in the dataset.

Classes:
Node: Defines a tree node (operator, constant, or variable) and its evaluation.
Individual: Represents a complete tree, calculates MSE, and includes methods for tree size and formula representation.
Population: Holds the collection of trees (individuals), supports evolutionary operations like tournament selection and crossover.

Useful Functions: Includes tree generation, visualization, mutation operations (operator, constant, prepend, append, etc.), and MSE calculation with complexity penalties.

Evolution Process:
Crossover: Swaps subtrees between two trees, creating offspring.
Mutation: Various mutations modify individuals, such as changing operators, constants, or subtree structures.
Symbolic Regression: The main algorithm iterates through generations, using selection, crossover, and mutation to evolve individuals towards better solutions (lower MSE).

Symbolic regression implementation:
A random population of individuals (candidate solutions) is generated at the start. Each
individual is typically represented as a tree structure, where internal nodes correspond to
operators (such as +, -, *, /), and leaves correspond to variables or constants. The size and
structure of the population are determined by thr predefined parameters.
After evaluating the individuals, a selection process identifies the "elite" individuals — those
that have the lowest MSE (fittest individuals). These elite individuals are directly copied into
the next generation's population. They are essentially preserved to ensure the best
solutions are not lost due to stochastic operations like mutation or crossover.
After that, either crossover or mutation is done, depending on the specified crossover
probability which determines the likelihood of either operation being chosen. Valid offspring
(those that do not violate any constraints or rules) are added to a temporary population set,
ensuring no individual repetition to make sure that the population stays as diverse as
possible.
These individuals, along with the elite individuals, form the new population that is going to
be used for the next iteration. Over time, the population evolves towards individuals that
better fit the data.
After the specified number of iterations is done, the best individual is selected as the final
formula.
