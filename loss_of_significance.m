function loss_of_significance()
    % Variables
    FUNCTION_COUNT = 4;
    ITERATIONS = 14;
    results = zeros(ITERATIONS, FUNCTION_COUNT);
    
    % Calculations
    x = 1;
    for iteration = 1 : ITERATIONS
        x = x * power(10, -1);
        
        % Original a)
        results(iteration, 1) = (1 - sec(x)) / power(tan(x), 2);
        % Modified a)
        results(iteration, 2) = -1 / (1 + sec(x));
        % Original b)
        results(iteration, 3) = (1 - power((1 - x), 3)) / x;
        % Modified b)
        results(iteration, 4) = 3 - 3 * x + power(x, 2);
    end
    
    % Displaying Results
    format long
    fprintf('Problem 1:\n  Original a)         Modified a)          Original b)         Modified b)\n')
    disp(results)
    
    % Printing out the result for Problem 4
    a = vpa(-12345678987654321);
    b = vpa(123);
    fprintf('---------------\n Problem 4:\n')
    disp(a + sqrt(power(a, 2) + power(b, 2)))
end