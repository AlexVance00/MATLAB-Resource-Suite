% Aircraft.m Dev Script

clear
clc

%% Code Generators
    %% Get property names
% Properties access should be private while not in development
props = properties(Aircraft);
num_props = length(props);

    %% Save Equations
bool_save_equations = false;
filename_equations = append(pwd, "\equations.mat");
if bool_save_equations
    equations = ["x_bar_ac = (1/C_L_alpha) * (C_L_alpha_w * x_bar_ac_w + eta_t * (S_t/S_w) * C_L_alpha_t * (1 - epsilon_alpha_t) * x_bar_ac_t - C_M_alpha_p - C_M_alpha_f);";
                         "C_M = C_M_0 + C_M_alpha * alpha_w + C_M_i_t * i_t + C_M_delta_e * delta_e;";
                         "C_M_0 = c_m_ac_w + eta_t * (S_t/S_w) * (c_bar_t/c_bar_w) * c_m_ac_t + C_M_0_p + C_M_0_f + (x_bar_cg - x_bar_ac_w) * (C_L_0_w + C_L_alpha_w * i_w) + eta_t * (S_t/S_w) * (x_bar_cg - x_bar_ac_t) * (C_L_0_t - C_L_alpha_t * epsilon_0_t);";
                         "C_M_alpha = C_M_alpha_p + C_M_alpha_f + (x_bar_cg - x_bar_ac_w) * C_L_alpha_w + eta_t * (S_t/S_w) * (x_bar_cg - x_bar_ac_t) * C_L_alpha_t * (1 - epsilon_alpha_t);";
                         "C_M_alpha = -(x_bar_ac - x_bar_cg) * C_L_alpha;";
                         "C_M_i_t = eta_t * (S_t/S_w) * (x_bar_cg - x_bar_ac_t) * C_L_alpha_t;";
                         "C_M_delta_e = eta_t * (S_t/S_w) * (x_bar_cg - x_bar_ac_t) * C_L_delta_e;";
                         "SM = x_bar_ac - x_bar_cg;";
                         "alpha_w_trim_delta_e_0 = (C_M_i_t * (C_L_0 - W/(q_bar_w*S_w)) - C_L_i_t * C_M_0) / (C_M_alpha * C_L_i_t - C_M_i_t * C_L_alpha);";
                         "i_t_trim = (C_M_alpha * (W/(q_bar_w*S_w) - C_L_0) + C_L_alpha * C_M_0) / (C_M_alpha * C_L_i_t - C_M_i_t * C_L_alpha);";
                         "alpha_w_trim = (W/(q_bar_w*S_w) - C_L_0_prime + C_M_0_prime * (C_L_delta_e/C_M_delta_e)) / (C_L_alpha - C_M_alpha * (C_L_delta_e/C_M_delta_e));";
                         "delta_e_trim = (W/(q_bar_w*S_w) - C_L_0_prime + C_M_0_prime * (C_L_alpha/C_M_alpha)) / (C_L_delta_e - C_M_delta_e * (C_L_alpha/C_M_alpha));";
                         "lambda_w = c_t_w / c_r_w;";
                         "S_w = (b_w/2) * c_r_w * (1 + lambda_w);";
                         "c_bar_w = (2*c_r_w/3) * (1 + lambda_w + lambda_w^2) / (1 + lambda_w);";
                         "AR_w = b_w^2 / S_w;";
                         "y_ac_w = (b_w/6) * (1 + 2*lambda_w) / (1 + lambda_w);";
                         "x_ac_w = c_bar_w/4 + y_ac_w * tan(sweep_w);";
                         "C_L = C_L_0 + C_L_alpha * alpha_w + C_L_i_t * i_t + C_L_delta_e * delta_e;";
                         "C_L_0 = C_L_0_w + C_L_alpha_w * i_w + eta_t * (S_t/S_w) * (C_L_0_t - C_L_alpha_t * epsilon_0_t);";
                         "C_L_alpha = C_L_alpha_w + eta_t * (S_t/S_w) * C_L_alpha_t * (1 - epsilon_alpha_t);";
                         "C_L_i_t = eta_t * (S_t/S_w) * C_L_alpha_t;";
                         "C_L_delta_e = eta_t * (S_t/S_w) * C_L_delta_e_t;";
                         "n = 1 + u * q_b / g;";
                         "C_w = W / (q_bar_w * S_w);";
                         "mu = m / (0.5 * rho * S_w * c_bar_w);";
                         "C_L_q = 2 * eta_t * (S_t/S_w) * (x_bar_ac_t - x_bar_cg) * C_L_alpha_t;";
                         "C_M_q = -C_L_q * (x_bar_ac_t - x_bar_cg);";
                         "delta_alpha = (C_w / (C_L_alpha * C_M_delta_e - C_L_delta_e * C_M_alpha)) * (C_M_delta_e - (1/(2*mu)) * (C_M_delta_e * C_L_q - C_L_delta_e * C_M_q)) * (n - 1);";
                         "delta_delta_e = -(C_w / (C_L_alpha * C_M_delta_e - C_L_delta_e * C_M_alpha)) * (C_M_alpha - (1/(2*mu)) * (C_M_alpha * C_L_q - C_L_alpha * C_M_q)) * (n - 1);";
                         "C_y = C_y_beta * beta + C_y_delta_r * delta_r + (b_w/(2*u)) * C_y_r * r_b;";
                         "C_n = C_n_beta * beta + C_n_delta_r * delta_r + C_n_delta_a * delta_a + (b_w/(2*u)) * C_n_r * r_b;";
                         "C_l = (C_l_beta_w + C_l_beta_f + C_l_beta_d + C_l_beta_s) * beta + C_l_delta_r * delta_r + C_l_delta_a * delta_a + (b_w/(2*u)) * C_l_r * r_b + (b_w/(2*u)) * C_l_p * p_b;";
                         "C_y_beta = -(q_bar_f/q_bar_w) * (S_f/S_w) * C_L_alpha_f * (1 - sigma_beta);";
                         "C_y_delta_r = (q_bar_f/q_bar_w) * (S_f/S_w) * C_L_delta_r;";
                         "C_y_r = 2 * (q_bar_f/q_bar_w) * (S_f/S_w) * (x_ac_f - x_cg) / b_w * C_L_alpha_f;";
                         "C_n_beta = (q_bar_f/q_bar_w) * (S_f/S_w) * (x_ac_f - x_cg) / b_w * C_L_alpha_f * (1 - sigma_beta);";
                         "C_n_delta_r = -(q_bar_f/q_bar_w) * (S_f/S_w) * (x_ac_f - x_cg) / b_w * C_L_delta_r;";
                         "C_n_r = -2 * (q_bar_f/q_bar_w) * (S_f/S_w) * ((x_ac_f - x_cg) / b_w)^2 * C_L_alpha_f;";
                         "C_l_beta_f = -(q_bar_f/q_bar_w) * (S_f/S_w) * (y_ac_f - z_cg) / b_w * C_L_alpha_f * (1 - sigma_beta);";
                         "C_l_beta_d = -(y_ac_w/b_w) * C_L_alpha_w * gamma_w;";
                         "C_l_beta_s = -2 * (y_ac_w/b_w) * C_L * cos(sweep_w) * sin(sweep_w);";
                         "C_l_delta_r = (q_bar_f/q_bar_w) * (S_f/S_w) * (y_ac_f - z_cg) / b_w * C_L_delta_r;";
                         "C_l_delta_a = (tau_w * c_r_w * C_L_alpha_w / S_w) * (b_w/2) * (0.5*eta_2^2 + ((lambda_w - 1)/3)*eta_2^3 - 0.5*eta_1^2 - ((lambda_w - 1)/3)*eta_1^3);";
                         "C_l_r = 2 * (q_bar_f/q_bar_w) * (S_f/S_w) * (x_ac_f - x_cg) / b_w * (y_ac_f - z_cg) / b_w * C_L_alpha_f;";
                         "C_l_p = -(1/12) * ((1 + 3*lambda_w)/(1 + lambda_w)) * (c_l_alpha_w + c_d_0);"; % trapezoidal wing
                         "n = 1 / cos(phi);";
                         "psi_dot = (g/u) * tan(phi);";
                         "W = m * g";
                         "nu = 2*W / (g * rho * S_w * b_w);";
                         "p_b = phi_dot - psi_dot * sin(theta);";
                         "q_b = theta_dot * cos(phi) + psi_dot * cos(theta) * sin(phi);";
                         "r_b = -theta_dot * sin(phi) + psi_dot * cos(theta) * cos(phi);";
                         "phi_dot = p_b + q_b * sin(phi) * tan(theta) + r_b * cos(phi) * tan(theta);";
                         "theta_dot = q_b * cos(phi) - r_b * sin(phi);";
                         "psi_dot = q_b * sin(phi) * sec(theta) + r_b * cos(phi) * sec(theta);"];
    if size(equations) ~= size(unique(equations))
        warning("Duplicate equations detected\n");
    end
    save(filename_equations, "equations");
end

    %% Make equation permutations
bool_make_equation_permutations = true;

% Requires symbolic toolbox
if bool_make_equation_permutations

    % Load equation set
    load(filename_equations);

    num_equations = length(equations);
    
    % Get all unique variables
    master_var_list = [];
    for i_equation = 1:num_equations
        equation = equations(i_equation);
        vars = string(symvar(equation));
        master_var_list = unique([master_var_list; vars]);
    end
    total_num_vars = length(master_var_list);
   
    % Write in recognizeable form for sym toolbox
    equations = replace(equations, "=", "==");
    equations = erase(equations, ";");
    
    % Still in progress
    % -----------------

    % Initialize equation set structure
    master_var_list_cell = cellstr(master_var_list);

    empty_vals = repmat({strings(1)}, size(master_var_list_cell));
    equation_sets = cell2struct(empty_vals, master_var_list_cell);

    % Make sym variables for sym solving
    syms(master_var_list);

    for i_equation = 1:num_equations
        equation = str2sym(equations(i_equation));
        vars = symvar(equation);
        num_vars = length(vars);

        for i_var = 1:num_vars
            var = vars(i_var);
            var_name = string(var);
            try
                permutation = solve(equation, var);

                % Skip if unsolvable or trivial
                if isempty(permutation) || permutation == var_name
                    continue;
                end

                permutation_name = string(permutation);
                permutation_execution_line = var_name + " = " + permutation_name + ";";
                
                if equation_sets.(var_name) ~= ""
                    num_permutations_this_var = length(equation_sets.(var_name)) + 1;
                else
                    num_permutations_this_var = length(equation_sets.(var_name));
                end
                
                equation_sets.(var_name)(num_permutations_this_var) = permutation_execution_line;
            catch
                fprintf("Could not solve equation %d for %s\n", i_equation, var_name);
            end
        end
    end

    filename_permutations = append(pwd, "\permutations.mat");
    save(filename_permutations, "equation_sets");
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