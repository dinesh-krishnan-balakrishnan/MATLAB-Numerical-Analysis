function derivative_estimate()
    format long
    
    % Function
    F = @(x) sin(x) - cos(x);
    disp('Function:')
    disp(F)
    
    % Function Derivative Constants
    x = 0;
    expected = 1;
    
    % Simulation Constant
    N = 12;

    for iteration=1 : N
        % Determining Margin
        h = 10.^-iteration;
        
        % Calculating Derivative
        actual = (F(x + h) - F(x - h)) / (2*h);
        
        % Calculating & Logging Error
        error = abs(expected - actual);
        fprintf('Margin: 10^(-%d) | Result: %.12f | Error: %.12f \n', iteration, actual, error)
    end
end