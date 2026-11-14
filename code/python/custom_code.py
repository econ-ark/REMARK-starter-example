"""Code that REMARK-starter-example.ipynb imports.

Longer code is easier to read, test and reuse in a module like this one than in notebook
cells. Keep it next to the notebook, so that the notebook can import it.
"""

import matplotlib.pyplot as plt
import numpy as np


def plot_distribution(mu, sigma, path, seed, draws=437, bins=50):
    """Plot a histogram of draws from a normal distribution, with its density, and save it.

    mu, sigma: the distribution's mean and standard deviation.
    path: where to save the figure.
    seed: the random number generator's seed. The same seed gives the same draws, so
        every run makes the same figure.
    draws, bins: the number of draws, and of bins in the histogram.
    """
    rng = np.random.default_rng(seed)
    x = rng.normal(mu, sigma, draws)

    fig, ax = plt.subplots()
    _, edges, _ = ax.hist(x, bins, density=True)
    density = np.exp(-0.5 * ((edges - mu) / sigma) ** 2) / (np.sqrt(2 * np.pi) * sigma)
    ax.plot(edges, density, "--")
    ax.set_xlabel("Value")
    ax.set_ylabel("Probability density")
    ax.set_title(rf"Histogram of {draws} draws: $\mu={mu}$, $\sigma={sigma}$")

    fig.tight_layout()  # keeps the y-axis label from being clipped
    # Without a creation date, the same figure gives the same file on every run.
    fig.savefig(path, metadata={"CreationDate": None})
    plt.show()
