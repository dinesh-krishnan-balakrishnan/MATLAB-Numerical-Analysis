function fixed_point_iteration(f, X, tolerance)
    
    % Initializing variables.
    new_X = intmax;
    steps = 0;
    
    % Repeats until tolerance is reached.
    while abs(X - new_X) > tolerance
       % Finding the new X value.
       new_X = f(X);
       % Averaging the values for the purpose of convergence.
       X = (new_X + X) / 2;
       % Increasing the number of steps taken
       steps = steps + 1;
    end
    
    % Displaying results.
    format long
    disp(steps);
    disp(X);
end