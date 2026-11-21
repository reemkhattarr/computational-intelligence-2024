# Computational Intelligence 2024 — how to run everything in this repo.
# Requirements: uv (https://docs.astral.sh/uv) and just (https://just.systems).
# Run `just` to list the recipes. Dependencies are installed on the fly by uv.

deps := "--with numpy --with pandas --with matplotlib --with tqdm --with icecream --with networkx --with geopy --with graphviz --with jupyterlab"

default:
    @just --list

# Open the symbolic-regression project notebook (genetic programming).
project:
    uv run {{deps}} jupyter lab src/PROJECT.ipynb

# Score the final formulas in s321463.py on every problem in data/ (mean squared error).
score:
    #!/usr/bin/env -S uv run --with numpy python
    import sys, glob, numpy as np
    sys.path.insert(0, ".")
    import s321463 as sol
    for path in sorted(glob.glob("data/problem_*.npz")):
        i = path.split("_")[-1].split(".")[0]
        f = getattr(sol, f"f{i}", None)
        if f is None:
            continue
        d = np.load(path)
        try:
            with np.errstate(all="ignore"):
                mse = np.mean((d["y"] - f(d["x"])) ** 2)
            print(f"problem {i}: MSE = {mse:.6g}")
        except Exception as exc:
            print(f"problem {i}: could not evaluate ({exc})")

# Open a lab notebook: `just lab 1` (set cover), 2 (TSP), 3 (n-puzzle).
lab N:
    uv run {{deps}} jupyter lab labs/lab{{N}}-*/
