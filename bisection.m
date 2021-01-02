function bisection(f, bound_A, bound_B, tolerance)
    
    % Initial min & max value assignment.
    value_A = f(bound_A); value_B = f(bound_B);
    
    % Checking validity of chosen bounds.
    if (value_A * value_B) > 0
       error("The two bounds must equate to values with opposite signs!");
    end
    
    % Executes until tolerance is reached.
    while abs((bound_A - bound_B) / 2) > tolerance
        
        % Calculates the value of the midpoint between the current bounds.
        mid_value = (bound_A + bound_B) / 2;
        midpoint = f(mid_value);
        
        
        % Narrows the bounds based on the value of the midpoint.
        if (f(bound_A) * midpoint) > 0;  bound_A = mid_value;
        else;                            bound_B = mid_value;
        end
         
    end
    
    format long
    disp((bound_A + bound_B) / 2)
end