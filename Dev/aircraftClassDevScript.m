% Aircraft.m Dev Script

clear
clc

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

%% Test Area
aircraft_1 = Aircraft();
aircraft_1.Set("C_L", 87)
aircraft_1.Set("C_L", "wut")
aircraft_1.Set("shite", 87)
aircraft_1.Set("C_L", [])