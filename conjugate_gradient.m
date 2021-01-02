function conjugate_gradient(L)    
    % b Constant
    b = zeros(L, 1) + 1.5;
    b(1) = 2.5; b(L) = 2.5; 
    b(L/2) = 1; b(L/2 + 1) = 1;
    
    % Initialization
    X = zeros(L, 1);
    d = b; r = b;
    
    % Trackers
    steps = 0;
    error = 1;
    residual = 0;

    while error > power(10, -10)    
        steps = steps + 1;
        % Additional Calculations
        rr = dot(r, r);
        Ad = zeros(L, 1);
        for I = 1 : L
            Ad(I) = d(I) * 3;
            if (I ~= 1); Ad(I) = Ad(I) - d(I - 1); end
            if (I ~= L); Ad(I) = Ad(I) - d(I + 1); end
            if (I ~= L/2 && I ~= (L/2 + 1)); Ad(I) = Ad(I) + (d(L + 1 - I) / 2); end
        end
        
        % Conjugate Gradient Method
        alpha = rr / dot(d, Ad);
        X = X + (alpha * d);
        r = r - (alpha * Ad);
        beta = dot(r, r) / rr;
        d = r + (beta * d);
        
        % Calculating Error
        AX = zeros(L, 1);
        for I = 1 : L
            AX(I) = X(I) * 3;
            if (I ~= 1); AX(I) = AX(I) - X(I - 1); end
            if (I ~= L); AX(I) = AX(I) - X(I + 1); end
            if (I ~= L/2 && I ~= (L/2 + 1)); AX(I) = AX(I) + (X(L + 1 - I) / 2); end
        end
        difference = abs(b - AX);
        error = sum(difference, 'all');
        residual = max(difference);
    end
    
    fprintf('Steps Taken: %d\n', steps)
    fprintf("Residual Error: ")
    disp(residual)
end