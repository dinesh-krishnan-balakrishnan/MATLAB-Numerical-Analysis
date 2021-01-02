function multivariate_NR()
    % Guess & Function Declaration (Manual)
    x = ones(2, 1);
    x(1) = -1;
    function_N = @(x) function_D(x);
    
    % Simulation
    simulation(x, function_N)
end

function simulation(x, function_N)
    % Initialization
    [F, J] = function_N(x);
    steps = 0;
    
    while sum(abs(F), 'all') > 5e-10        
        % Calculating next X
        x = x - (J \ F);
        
        % Variable Updates
        [F, J] = function_N(x);
        steps = steps + 1;
    end
    
    disp('Steps:')
    disp(steps)
    disp('Final Solution:')
    disp(x)
end

% ------------------- FUNCTIONS ------------------- %

% Valid Starting Points: (1, 1), (-1, -1)
function [F, J] = function_A(x)
    F = zeros(2, 1);
    F(1) = power(x(1),2)+power(x(2),2)-1;
    F(2) = power(x(1)-1,2)+power(x(2),2)-1;
    
    J = zeros(2, 2);
    J(1, 1) = 2*x(1);       J(1, 2) =  2*x(2);
    J(2, 1) = 2*x(1)-2;     J(2, 2) =  2*x(2);
end

% Valid Starting Points: (1, 1), (1, -1), (-1, 1), (-1, -1)
function [F, J] = function_B(x)
    F = zeros(2, 1);
    F(1) = power(x(1),2)+4*power(x(2),2)-4;
    F(2) = 4*power(x(1),2)+power(x(2),2)-4;
    
    J = zeros(2, 2);
    J(1, 1) = 2*x(1);     J(1, 2) =  8*x(2);
    J(2, 1) = 8*x(1);     J(2, 2) =  2*x(2);
end

% Valid Starting points: (1, 1), (1, -1)
function [F, J] = function_C(x)
    F = zeros(2, 1);
    F(1) = power(x(1),2)-4*power(x(2),2)-4;
    F(2) = power(x(1)-1,2)+power(x(2),2)-4;
    
    J = zeros(2, 2);
    J(1, 1) = 2*x(1);         J(1, 2) =  -8*x(2);
    J(2, 1) = 2*x(1) - 2;     J(2, 2) =  2*x(2);
end

% Valid Starting points: (2, 2),
function [F, J] = function_D(x)
    F = zeros(2, 1);
    F(1) = 6*power(x(1),3)-3*power(x(2),3)+x(1)*x(2)-4;
    F(2) = power(x(1),2)+16*power(x(2),3)-18*x(1)*power(x(2),2)+1;
    
    J = zeros(2, 2);
    J(1, 1) = 18*power(x(1),2) + x(2);         J(1, 2) =  x(1)-9*power(x(2), 2);
    J(2, 1) = 2*x(1)-18*power(x(2), 2);        J(2, 2) =  -36*x(1)*x(2)+48*power(x(2),2);
end
