function composite_trapezoidal(F, start, finish, actual)
    % Logging Function
    disp('Function:')
    disp(F)
    fprintf('Range: [%f, %f] | Expected Result: %f \n\n', start, finish, actual)
    
    %Panel Counts
    M_list = [16, 32];
    
    for iteration=1 : length(M_list)
        % Calculating Function Constants
        M = M_list(iteration);
        H = (finish - start) / M;
        
        % Composite Trapezoidal Function
        prediction = F(start) + F(finish);
        for panel=(start + H) : H : (finish - H)
            prediction = prediction + 2 * F(panel);
        end
        prediction = prediction * (H / 2);
        
        % Logging Error
        error = abs(actual - prediction);
        fprintf('Panels: %d | Prediction: %.10f | Error: %.10f \n', M, prediction, error)
    end
end