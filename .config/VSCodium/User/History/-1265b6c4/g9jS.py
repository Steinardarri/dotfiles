import joblib
import numpy as np

# Define a heavy function that takes a long time to compute
def heavy_function(x):
    # Create two large random matrices
    A = np.random.rand(1000, 1000)
    B = np.random.rand(1000, 1000)

    # Perform a large number of matrix multiplications
    result = np.zeros((1000, 1000))
    for i in range(1000):
        result += np.dot(A, B)

    return result


# Create a memory cache to store the results of the heavy function
memory = joblib.Memory(location='.cache', verbose=0)

# Wrap the heavy function with the memory cache to create a cached version of the function
cached_heavy_function = memory.cache(heavy_function)

# Create a list of inputs to parallelize
inputs = [1, 2, 3, 4, 5]

# Use joblib.Parallel to parallelize the cached heavy function
with joblib.parallel_backend('multiprocessing', n_jobs=4):
    results = joblib.Parallel()(joblib.delayed(cached_heavy_function)(i) for i in inputs)
    joblib.parallel_backend().print_progress()

# Print the results
print(results)
