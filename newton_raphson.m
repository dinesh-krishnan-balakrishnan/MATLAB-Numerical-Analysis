function newton_raphson(f, df, x, accuracy_level, max_iterations)
    
    % Initializing the tolerance, current error, and current iteration.
    tolerance = 5 * power(10, -(accuracy_level + 1));
    E = 1;
    iteration = 0;
    
    % - LOGGING INFO -
    format long
    fprintf("\nAccuracy Limit: %d Decimal Places\n", accuracy_level)
    fprintf("Initial X: %d\n", x)
    disp("----------------------------------");
    
    % Continues while the error is greater than tolerance.
    % An iteration limit is placed to prevent infinite iterations.
    while (E > tolerance) && (iteration < max_iterations)
        % Calculating f(x) and df(x).
        f_x = f(x);
        df_x = df(x);
        
        % Calculating the next x value.
        if (df_x ~= 0); x_next = x - (f_x / df_x);
        else;           error("Error: Zero Gradient");
        end
            
        % Calculating the new error.
        if (x ~= 0);    E = abs((x_next - x) / x);
        else;           error("Error: X = 0")
        end
        
        % Updating values for next iteration.
        iteration = iteration + 1;
        x = x_next;
        
        % - LOGGING INFO - 
        fprintf("Iteration: %d | Value: %.*f\n", iteration, accuracy_level, x)
    end
    
    % - LOGGING INFO - 
    disp("----------------------------------");
    if (E < tolerance);     disp("TOLERANCE REACHED")
    else;                   disp("ITERATION LIMIT REACHED")
    end
    
    fprintf("FINAL ITERATION: %d\n", iteration)
    fprintf("FINAL VALUE: %.*f\n", accuracy_level, x)
end