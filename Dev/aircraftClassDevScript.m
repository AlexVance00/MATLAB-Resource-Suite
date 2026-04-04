% Aircraft.m Dev Script

clear
clc

%% Code Generators
    %% Get property names
% Properties access should be private while not in development
props = properties(Aircraft);
num_props = length(props);

    %% Make equation permutations
bool_make_equation_permutations = false;
% Requires symbolic toolbox
if bool_make_equation_permutations
    % Make master list of equations
    equations = ["C_L = C_L_0 + C_L_alpha * alpha_w + C_L_i_t * i_t + C_L_delta_e * delta_e;", "C_L = L / (q_bar_w * S_w);"];
    num_equations = length(equations);
    
    % Get all unique variables\
    master_var_list = [];
    delimiters = ["+", "-", "*", "/", "^", "(", ")", ";", "="];
    for i_equation = 1:num_equations
        equation = equations(i_equation);
        equation = erase(equation, delimiters);
        terms = strsplit(equation);
        master_var_list = unique([master_var_list, terms(2:end)]);
    end
    total_num_vars = length(master_var_list);
   
    % Convert equations to symbolic-friendly and remove semicolons
    % equations = append(master_var_list, " == ", equations);
    equations = replace(equations, "=", "==");
    equations = erase(equations, ";");
    
    % Still in progress
    % -----------------

    output_lines = [];

    for i_equation = 1:num_equations
        equation = equations(i_equation);
        required_vars = symvar(equation);
        num_vars = length(required_vars);

        for i_var = 1:num_vars
            var = required_vars{i_var};

            % Note to self before calling it a night- right now code needs
            %   to be changed/reorganized. It's trying to do two different
            %   things right now. I think we should go with the below
            %   approach, where the LHS is included in the symbolic
            %   expression, and you just plug in the master set of
            %   equations to this code. Instead of taking out the LHS like
            %   in the block above
            permutation = solve(equation, var);
            var_name = string(var);
            eq_string = string(permutation);
            line = var_name + " = " + eq_string + ";";
            output_lines = [output_lines, line];
            fprintf("%s\n", line);
        end
    end

    writelines(output_lines, "permutations.txt");
end

%% Method Test Cases
bool_test_all = false;

bool_test_constructor = false;
bool_test_copy_constructor = false;
bool_test_disp = false;
bool_test_get = false;
bool_test_set = false;

if bool_test_all
    bool_test_constructor = true;
    bool_test_copy_constructor = true;
    bool_test_disp = true;
    bool_test_get = true;
    bool_test_set = true;
end

    %% Constructor
if bool_test_constructor
    fprintf("=== Constructor Test ===\n");
    % Default constructor
    fprintf("Default Constructor:\n");
    try
        aircraft_1 = Aircraft()
        fprintf("Successful test\n\n");
    catch
        warning("Default constructor ""Aircraft()"" failed");
    end
end

    %% Copy Constructor
if bool_test_copy_constructor
    bool_test_failed = false;
    fprintf("=== Copy Constructor Test ===\n");
    aircraft_original = Aircraft();
    aircraft_original.Set("W", 9000)
    try
        aircraft_copy = aircraft_original.copy()
    catch
        warning("Copy constructor ""aircraft_original.copy()"" failed");
        bool_test_failed = true;
    end
    
    % Verify copy is independent (handle class, so this matters)
    aircraft_copy.Set("W", 99999)

    if aircraft_original.Get("W") == aircraft_copy.Get("W")
         warning("Test failed, copy wasn't independent or original");
    else
        if ~bool_test_failed
            fprintf("Successful test\n\n");
        end
    end
end

    %% Disp
if bool_test_disp
    bool_test_failed = false;
    fprintf("=== Disp Test ===\n");
    aircraft = Aircraft();
    aircraft.Set("W", 10000);
    aircraft.Set("S_w", 200);
    aircraft.Set("b_w", 30)
    
    % Default (bool_disp_full = false), should only show non-empty properties
    fprintf("Should show non-empty properties only\n");
    try
        disp(aircraft);
    catch
        fprintf("disp(aircraft) failed\n\n");
        bool_test_failed = true;
    end
    try
        aircraft.disp();
    catch
        fprintf("aircraft.disp() failed\n\n");
        bool_test_failed = true;
    end
    % Full disp, should show empty properties too
    fprintf("Should show empty properties too\n");
    try
        disp(aircraft, true);
    catch
        fprintf("disp(aircraft) failed\n\n");
        bool_test_failed = true;
    end
    try
        aircraft.disp(true);
    catch
        fprintf("aircraft.disp() failed\n\n");
        bool_test_failed = true;
    end
    if ~bool_test_failed
        fprintf("Successful test\n\n");
    end
end

    %% Get
if bool_test_get
    bool_test_failed = false;
    fprintf("=== Get Test ===\n");
    aircraft = Aircraft();
    aircraft.Set("W", 10000);
    
    % Valid get
    W_fetch = aircraft.Get("W");
    if W_fetch ~= 10000
        fprintf("aircraft.Get(""W"") failed\n\n");
        bool_test_failed = true;
    end
    
    % Get empty property
    S_w_fetch = aircraft.Get("S_w");
    if ~isempty(S_w_fetch)
        fprintf("aircraft.Get(""S_w"") failed\n\n");
        bool_test_failed = true;
    end
    
    % Invalid property name
    fprintf("Should warn of invalid property name\n")
    aircraft.Get("not_a_property");
    
    % Non-string input
    fprintf("Should warn of invalid variable name input class\n")
    aircraft.Get(123);

    if ~bool_test_failed
        fprintf("If (2) warnings occurred, test is successful\n\n");
    end
end

    %% Set
if bool_test_set
    bool_test_failed = false;
    fprintf("=== Set Test ===\n");
    aircraft = Aircraft();
    
    % Valid set
    fprintf("Attempt basic Set()");
    aircraft.Set("W", 10000);
    if aircraft.Get("W") ~= 10000
        fprintf("Test failed, fetched value mismatched set value");
        bool_test_failed = true;
    end
    
    % Set to empty (clear a value)
    fprintf("Assuming basic Set() passed, attempt Set(""W"", [])");
    aircraft.Set("W", []);
    if ~isempty(aircraft.Get("W"))
        fprintf("Test failed, W was not emptied");
        bool_test_failed = true;
    end
    
    % Invalid: non-scalar
    fprintf("Assuming basic Set() passed, attempt Set(""W"", " + ...
        "[1 2 3])\n" + ...
        "Should fail for invalid input\n");
    aircraft.Set("W", [1 2 3]);
    if aircraft.Get("W") ~= 10000
        fprintf("Test failed, invalid input changed property value");
        bool_test_failed = true;
    end
    
    % Invalid: non-real
    fprintf("Assuming basic Set() passed, attempt Set(""W"", " + ...
        "1+2i)\n" + ...
        "Should fail for invalid input\n");
    aircraft.Set("W", 1+2i);
    if aircraft.Get("W") ~= 10000
        fprintf("Test failed, invalid input changed property value");
        bool_test_failed = true;
    end
    
    % Invalid: non-double
    fprintf("Assuming basic Set() passed, attempt Set(""W"", " + ...
        """hello"")\n" + ...
        "Should fail for invalid input\n");
    aircraft.Set("W", "hello");
    if aircraft.Get("W") ~= 10000
        fprintf("Test failed, invalid input changed property value");
        bool_test_failed = true;
    end
    
    % Invalid: non-existent property
    fprintf("Assuming basic Set() passed, attempt set with invalid " + ...
        "property name\n" + ...
        "Should warn for invalid input\n");
    aircraft.Set("not_a_property", 1);
    
    % Set units
    fprintf("Assuming basic Set() passed, attempt Set(""units"", " + ...
        """m-kg"")\n");
    aircraft.Set("units", "m-kg");
    if aircraft.Get("units") ~= "m-kg"
        fprintf("Test failed, fetched value mismatched set value\n");
        bool_test_failed = true;
    end
    if ~bool_test_failed
        fprintf("If (4) warnings occurred, test is successful\n\n");
    end
end

%% Testing Area