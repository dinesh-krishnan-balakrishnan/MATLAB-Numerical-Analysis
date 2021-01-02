% Deviation: Deviation value of Gaussian Distribution
% save_file: Filepath for saving histogram.
function part_3(deviation, save_file) 
    % Loading Given Constants
    C = load('constants.mat');
    
    % Noise Variable History Storage
    noises = zeros(C.steps, 1);
    noise = 0;
    
    % Stepping through the noise ODE.
    for iteration = 1 : C.steps
        noise = generate_noise(noise, deviation, C);
        noises(iteration) = noise;
    end
    
    % Plotting and saving the noise values.
    histogram(noises)
    xlabel('Noise Values')
    ylabel('Count')
    title('Gaussian Frequency of Noise Values')   
    savefig(save_file)
end

% ------------------------------------------------------------------------

% Generates noise for the next timestep.
function new_noise=generate_noise(noise, deviation, C)
    new_noise = noise;
    new_noise = new_noise - (C.time_step / C.tau_N) * noise;
    new_noise = new_noise - sqrt(2 * C.time_step / C.tau_N) * deviation * randn;
end

    