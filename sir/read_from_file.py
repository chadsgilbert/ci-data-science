
import matplotlib.pyplot as plt
import numpy
import h5py


def read_from_files(name, output_file, beta_list, gamma_list, function):
    """
    Read something from files.
    """
    percent_infected = numpy.zeros((len(beta_list), len(gamma_list)))
    for i in range(len(beta_list)):
        for j in range(len(gamma_list)):
            filename = f"{name}_{beta_list[i]}_{gamma_list[j]}.h5"
            file = h5py.File(filename, 'r')
            percent_infected[i, j] = function(file)

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

    plt.savefig("graph.png")
    if not output_file:
        plt.show()
    else:
        plt.savefig(output_file)
