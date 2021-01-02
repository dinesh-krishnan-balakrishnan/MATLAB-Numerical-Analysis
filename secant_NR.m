function secant_NR(f, x0, x1, accuracy_level, max_iterations)
    
    % Initializing the tolerance, current error, and current iteration.
    tolerance = 5 * power(10, -(accuracy_level + 1));
    E = 1;
    iteration = 0;
    
    % - LOGGING INFO -
    format long
    fprintf("\nAccuracy Limit: %d Decimal Places\n", accuracy_level)
    fprintf("Initial X Values: %d and %d\n", x0, x1)
    disp("----------------------------------");
    
    % Continues while the error is greater than tolerance.
    % An iteration limit is placed to prevent infinite iterations.
    while (E > tolerance) && (iteration < max_iterations)
        % Calculating f(x) and df(x).
        f_x0 = f(x0);
        f_x1 = f(x1);
        
        % Calculating the next x value.
        if (f_x1 ~= f_x0); x_next = x1 - (f_x1 * (x1 - x0))/(f_x1 - f_x0);
        else;           error("Error: Zero Gradient");
        end
            
        % Calculating the new error.
        if (x1 ~= 0);    E = abs((x_next - x1) / x1);
        else;           error("Error: Current X = 0")
        end
        
        % Updating values for next iteration.
        iteration = iteration + 1;
        x0 = x1;
        x1 = x_next;
        
        % - LOGGING INFO - 
        fprintf("Iteration: %d | Value: %.*f\n", iteration, accuracy_level, x1)
    end
    
    % - LOGGING INFO - 
    disp("----------------------------------");
    if (E < tolerance);     disp("TOLERANCE REACHED")
    else;                   disp("ITERATION LIMIT REACHED")
    end
    
    fprintf("FINAL ITERATION: %d\n", iteration)
    fprintf("FINAL VALUE: %.*f\n", accuracy_level, x1)
end