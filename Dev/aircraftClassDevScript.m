% Aircraft.m Dev Script

clear
clc

%% Get property names
% Properties access should be private while not in development
props = properties(Aircraft);
num_props = length(props);

%% Make equation permutations
bool_make_equations = false;
% Requires symbolic toolbox
if bool_make_equations
    % Make master list of equations
    master_var_list = ["C_L"];
    num_vars = length(master_var_list);
    master_equation_list = ["C_L_0 + C_L_alpha * alpha_w + C_L_i_t * i_t + C_L_delta_e * delta_e;", "L / (q_bar_w * S_w);"];
    num_equations = length(master_equation_list);
    
    % Get all unique variables\
    required_vars = [];
    delimiters = ["+", "-", "*", "/", "^", "(", ")", ";"];
    for i_equation = 1:num_equations
        equation = master_equation_list(i_equation);
        equation = erase(equation, delimiters);
        terms = strsplit(equation);
        required_vars = unique([required_vars, terms]);
    end
    % Convert to symbolic
    syms(required_vars)
    
    % Convert equations to symbolic-friendly and remove semicolons
    master_equation_list = append(master_var_list, " == ", master_equation_list);
    erase(master_equation_list, ";")
    
    for i_var = 1:num_vars
        equations = [C_L == C_L_0 + C_L_alpha * alpha_w + C_L_i_t * i_t + C_L_delta_e * delta_e, ...
                     C_L == L / (q_bar_w * S_w)];
    end
    
    all_vars = [C_L, C_L_0, C_L_alpha, alpha_w, C_L_i_t, i_t, C_L_delta_e, delta_e, L, q_bar_w, S_w];
    
    output_lines = [];
    
    for i_eq = 1:length(equations)
        eq = equations(i_eq);
        vars_in_eq = symvar(eq);
        for i_var = 1:length(vars_in_eq)
            var = vars_in_eq(i_var);
            rearranged = solve(eq, var);
            var_name = string(var);
            eq_string = string(rearranged);
            line = var_name + " = " + eq_string + ";";
            output_lines = [output_lines, line];
            fprintf("%s\n", line);
        end
    end
    
    writelines(output_lines, "permutations.txt");
end

%% Test area
