% s1 and s2: Starting activation values.
% G: Gating coefficient for adaptation values.
% Deviation: Deviation value of Gaussian Distribution
% save_file: Filepaths for saving histogram.
function part_5(s1, s2, G, deviation, save_file)
    % Loading Given Constants and ArrayList.
    import java.util.ArrayList;
    C = load('constants.mat');
    
    % Modifying the step count to gather additional information.
    steps = C.steps * 4;
    
    % Variables that keep track of dominance periods.
    times = ArrayList;
    current_time = 0;
    previous_difference = s1 - s2;
    
    % Initializing adaptation and noise to 0.
    a1 = 0; a2 = 0; N1 = 0; N2 = 0;
    
    % Stepping through the ODE. 
    for iteration = 1 : steps
        [s1, s2, a1, a2, N1, N2] = step(s1, s2, a1, a2, N1, N2, G, deviation, C);
        
        % operator_check is used to determine whether neural dominance is
        % changing.
        difference = s1 - s2;
        operator_check = (difference * previous_difference);
        
        % The length is saved once the dominance period is complete.
        if operator_check < 0 && current_time ~= 0
            times.add(current_time);
            current_time = 0;
            
        % The length is incremented if the dominance period continues.
        elseif operator_check >= 0
            current_time = current_time + 1;
        end
        
        previous_difference = difference;
    end
    
    % Plotting and saving the dominance periods.
    histogram(cell2mat(cell(toArray(times))), 10)
    xlabel('Time (ms)')
    ylabel('Counts')
    title('Dominance Period Lengths')   
    savefig(save_file)
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