% s1 and s2: Starting activation values.
% save_file: Filepath for saving plot.
function part_1(s1, s2, save_file) 
    % Loading Given Constants
    C = load('constants.mat');
    
    % Independent (time) and Dependent (values) Variable Storages
    time = zeros(C.steps, 1);
    values = zeros(C.steps, 2);
    
    % Stepping through the ODE.
    for iteration = 1 : C.steps
        [s1, s2] = step(s1, s2, C);
        values(iteration, :) = [s1, s2];
        time(iteration) = iteration * C.time_step;
    end
    
    % Plotting and saving resulting graph.
    plot(time, values)
    legend('s1', 's2')
    xlabel('Time (ms)')
    ylabel('Activation')
    title('Activation (s1 and s2)')
    savefig(save_file)
end

% ------------------------------------------------------------------------

% Performs one time step in the system of ODEs.
function [new_s1, new_s2]=step(s1, s2, C)
    new_s1 = ODE(s1, s2, C);
    new_s2 = ODE(s2, s1, C);
end

% Forward Euler's of ODE
function new_s=ODE(s1, s2, C)    
    dense_output = C.bias - (C.weight * s2);
    new_s = s1 + (C.time_step / C.tau) * (-s1 + sigmoid(dense_output));
end

% Sigmoid Activation
function result=sigmoid(value)
    result = exp(value) / (exp(value) + 1);
end