% s1 and s2: Starting activation values.
% G: Gating coefficient for adaptation values.
% Deviation: Deviation value of Gaussian Distribution
% save_file: Filepaths for saving plots.
function part_4(s1, s2, G, deviation, save_file_1, save_file_2) 
    % Loading Given Constants
    C = load('constants.mat');
    
    % ODE Variable History Storage
    time = zeros(C.steps, 1);
    adaptations = zeros(C.steps, 2);
    values = zeros(C.steps, 2);
    
    % Initializing adaptation and noise to 0.
    a1 = 0; a2 = 0; N1 = 0; N2 = 0;
    
    % Stepping through the ODE.
    for iteration = 1 : C.steps
        [s1, s2, a1, a2, N1, N2] = step(s1, s2, a1, a2, N1, N2, G, deviation, C);
        
        adaptations(iteration, :) = [a1, a2];
        values(iteration, :) = [s1, s2];
        time(iteration) = iteration * C.time_step;
    end
    
    % Plotting and saving the activation values.
    plot(time, values)
    legend('s1', 's2')
    xlabel('Time (ms)')
    ylabel('Activation')
    title('Activation (s1 and s2)')   
    savefig(save_file_1)
    
    % Plotting and saving the adaptation values.
    plot(time, adaptations)
    legend('a1', 'a2')
    xlabel('Time (ms)')
    ylabel('Synaptic Adaptation')
    title('Synaptic Adaptation (a1 and a2)')   
    savefig(save_file_2)
end

% ------------------------------------------------------------------------

% Performs one time step in the system of ODEs.
function [new_s1, new_s2, new_a1, new_a2, new_N1, new_N2]=...
        step(s1, s2, a1, a2, N1, N2, G, deviation, C)
    network_1 = network(a1, s2, N1, G, C);
    network_2 = network(a2, s1, N2, G, C);
    
    new_s1 = ODE(s1, network_1, C.tau, C.time_step);
    new_s2 = ODE(s2, network_2, C.tau, C.time_step);
    
    new_a1 = ODE(a1, network_1, C.tau_a, C.time_step);
    new_a2 = ODE(a2, network_2, C.tau_a, C.time_step);
    
    new_N1 = generate_noise(N1, deviation, C);
    new_N2 = generate_noise(N2, deviation, C);
end

% Generating noise for the next time step.
function new_noise=generate_noise(noise, deviation, C)
    new_noise = noise;
    new_noise = new_noise - (C.time_step / C.tau_N) * noise;
    new_noise = new_noise - sqrt(2 * C.time_step / C.tau_N) * deviation * randn;
end

% Neural Network Simulation Function
function activation=network(a1, s2, N1, G, C)
    dense_output = (1 + N1) * C.bias - (C.weight * s2) - (G * a1);
    activation = exp(dense_output) / (exp(dense_output) + 1);
end

% Forward Euler's of ODE
function new_val=ODE(value, network, tau, time_step)    
    new_val = value + (time_step / tau) * (network - value);
end
