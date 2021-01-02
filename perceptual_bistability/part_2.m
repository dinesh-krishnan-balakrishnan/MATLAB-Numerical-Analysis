% s1 and s2: Starting activation values.
% G: Gating coefficient for adaptation values.
% save_file_1 and save_file_2: Filepaths for saving plots.
function part_2(s1, s2, G, save_file_1, save_file_2) 
    % Loading Given Constants
    C = load('constants.mat');
    
    % ODE Variable History Storage
    time = zeros(C.steps, 1);
    adaptations = zeros(C.steps, 2);
    values = zeros(C.steps, 2);
    
    % Starting with adapatation values of 0 (unadapted).
    a1 = 0; a2 = 0;
    
    % Stepping through the ODE.
    for iteration = 1 : C.steps
        [s1, s2, a1, a2] = step(s1, s2, a1, a2, G, C);
        
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
    
    % Plotting and saving the adaptations values.
    plot(time, adaptations)
    legend('a1', 'a2')
    xlabel('Time (ms)')
    ylabel('Synaptic Adaptation')
    title('Synaptic Adaptation (a1 and a2)')   
    savefig(save_file_2)
end

% ------------------------------------------------------------------------

% Performs one time step in the system of ODES.
function [new_s1, new_s2, new_a1, new_a2]=step(s1, s2, a1, a2, G, C)
    network_1 = network(a1, s2, G, C);
    network_2 = network(a2, s1, G, C);
    
    new_s1 = ODE(s1, network_1, C.tau, C.time_step);
    new_s2 = ODE(s2, network_2, C.tau, C.time_step);
    
    new_a1 = ODE(a1, network_1, C.tau_a, C.time_step);
    new_a2 = ODE(a2, network_2, C.tau_a, C.time_step);
end

% Neural Network Simulation Function
function activation=network(a1, s2, G, C)
    dense_output = C.bias - (C.weight * s2) - (G * a1);
    activation = exp(dense_output) / (exp(dense_output) + 1);
end

% Forward Euler's of ODE
function new_val=ODE(value, network, tau, time_step)    
    new_val = value + (time_step / tau) * (network - value);
end

