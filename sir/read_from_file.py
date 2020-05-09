
import matplotlib.pyplot as plt
import numpy
import h5py


def dataset_map(h5file, output_file, beta_list, gamma_list, function):
    """
    Apply an arbitrary function to datasets for all beta and gamma, and collect
    them in a 2D heat-map.
    """
    percent_infected = numpy.zeros((len(beta_list), len(gamma_list)))
    for i in range(len(beta_list)):
        for j in range(len(gamma_list)):
            dataset = h5file[f"b{beta_list[i]}_g{gamma_list[j]}"]
            percent_infected[i, j] = function(dataset)

    fig, axis = plt.subplots()
    fig.set_size_inches(6, 6)
    extent = [gamma_list[0] - 5, gamma_list[-1] + 5,
              beta_list[0] - 5, beta_list[-1] + 5]
    axis.imshow(percent_infected, extent=extent, origin='lower')
    axis.set_xticks(gamma_list)
    axis.set_yticks(beta_list)
    plt.xlabel(r'$\gamma$')
    plt.ylabel(r'$\beta$')
    fig.tight_layout()

    for i in range(len(beta_list)):
        for j in range(len(gamma_list)):
            axis.text(gamma_list[j], beta_list[i],
                      "%.02f" % percent_infected[i, j],
                      ha="center", va="center", color="k")

    if not output_file:
        plt.show()
    else:
        plt.savefig(output_file)
