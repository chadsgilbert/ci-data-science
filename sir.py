""" The Susceptible - Infectious - Recovered (SIR) model. 

In this model, we'll imagine that a new virus appears to which the entire
population (N) is susceptible. The number of susceptible people (S) decreases as
they become infected. For a spatially mixed population, the likelihood of a
susceptible person encountering an infectious person is proportional to
S * I / N. For now, consider B to just be a scalar rate of infection. Once
someone recovers from the infection, they are deemed no longer to be
susceptible to the virus. We will count the number of people who are recovered,
R. Let g be the rate at which infected people recover from the virus.

This model give the equations:

S' = -BIS/N
I' = BIS/N - gI
R' = gI
S + I + R = N

For simplicity, we solve this using Euler's method.

"""

import matplotlib.pyplot as plt

S = 999.0
I = 1.0
R = 0.0
N = S + I + R
B = 10
g = 1
dt = 0.1

tt = []
ss = []
ii = []
rr = []

it = 0
T = 0
while R < (N - 1):
    # Compute the rates. 
    dS = -B*I*S/N
    dI = B*I*S/N - g*I
    dR = g*I
   
    # Compute the values at the next time.
    T += dt
    S += dt*dS
    I += dt*dI
    R += dt*dR

    # Store the values for analysis.
    it += 1
    if it % 5 == 0:
        tt.append(T)
        ss.append(S)
        ii.append(I)
        rr.append(R)

print(T)
print(R)

fig = plt.figure()
ax1 = fig.add_subplot(3, 1, 1)
ax2 = fig.add_subplot(3, 1, 2)
ax3 = fig.add_subplot(3, 1, 3)

ax1.plot(tt, ss)
ax2.plot(tt, ii)
ax3.plot(tt, rr)

plt.savefig("site/sir.png")

