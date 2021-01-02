function gs()
    % Initializing sparse matrix parameters.
    
    % Matrix Constants
    length = 100; % Matrix Size 
    b_first = 1; b_last = -1; % Solution Values (0 Indexing)
    D_I = 1/2; % Inverse Diagonal Value
    
    % Solution Constants
    tolerance = 5 * power(10, -50);
    solution_X = ones(length, 1);
    for index = 2 : 2 : length; solution_X(index) = -1; end
    
    % Variables
    X = ones(length, 1); % Variable Matrix
    steps = 0;
    tolerance_reached = false;
    
    % Looping until tolerance is reached.
    while not(tolerance_reached)  
       % b
       new_X = zeros(length, 1);
       new_X(1) = new_X(1) + b_first; 
       new_X(length) = new_X(length) + b_last;
       
       % b - (U)X_k
       for index = 1 : length - 1; new_X(index) = new_X(index) -X(index + 1); end
       
       % b - (U)X_k - (L)X_k+1
       for index = length : -1 : 2; new_X(index) = new_X(index) -new_X(index - 1); end
       
       % D^-1(b - (U)X_k - (L)X_k+1)
       new_X = D_I * new_X;
       
       % Calculating Forward Error
       error = sum(abs(X - new_X));
       if (error < tolerance); tolerance_reached = true; end
              
       % Updating Variables
       steps = steps + 1;
       X = new_X;
       
       % Logging Backward Error
       error = sum(abs(solution_X - new_X));
       fprintf('Step: %d | Backward Error: %0.20f \n', steps, error);
    end
    
    format long
    disp('---------------------------------')
    fprintf('Total Steps: %d \n', steps);
    fprintf('X-Vector: \n');
    disp(X)
end