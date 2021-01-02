% Creates the Newton Dividied Difference Tree and evaluates the result
% with the specified value.
function NDD(x, y, N, eval_value)
    % Tree Container
    tree = zeros(N, N);
    
    % First layer consists of the y-values.
    for index=1 : N
        tree(index, 1) = y(index);
    end
    
    % Tree Generation Algorithm
    for column=2 : N
        for row=1 : N-column+1
            tree(row, column) = tree(row+1, column-1) - tree(row, column-1); 
            tree(row, column) = tree(row, column) / (x(row+column-1) - x(row));
        end
    end
    
    % Calculating Results
    result = eval(x, tree, N, eval_value);
    
    % Displaying Results
    format long g
    disp('Tree:')
    disp(tree)
    disp('Evaluated Result:')
    disp(result)
end

% Evaluates the NDD.
function result = eval(x, tree, N, eval_value)
    % Final result storage.
    result = 0;
    
    % Passes the eval_value through the function structure of the NDD.
    for column=1 : N
        % x Terms
        if column == 1
            multiplier = 1;
        else
            multiplier = multiplier * (eval_value - x(column - 1));
        end
        
        % NDD Coefficients
        result = result + tree(1, column) * multiplier;
    end
end
