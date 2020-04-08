using DifferentialEquations, PyPlot, DSP

function lorenz63!(du, u, p, t)
    du[1] = 10 * (u[2] - u[1])
    du[2] = u[1] * (28 - u[3]) - u[2]
    du[3] = u[1] * u[2] - 8/3 * u[3]
    return nothing
end

uᵢ = [1.0; 0.0; 0.0]
time_span = (0.0, 10000.0)
problem = ODEProblem(lorenz63!, uᵢ, time_span)
solution = solve(problem)

u₁ = map(u -> u[1], solution.u)
u₂ = map(u -> u[2], solution.u)
u₃ = map(u -> u[3], solution.u)

u₁_spectrum = welch_pgram(u₁, 400)
u₂_spectrum = welch_pgram(u₂, 400)
u₃_spectrum = welch_pgram(u₃, 400)

fig, axs = subplots()

plot(u₁_spectrum.freq, u₁_spectrum.power)
plot(u₂_spectrum.freq, u₂_spectrum.power)
plot(u₃_spectrum.freq, u₃_spectrum.power)
