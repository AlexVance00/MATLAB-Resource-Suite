% Aircraft.m Dev Script

clear
clc

%% Get property names
% Properties access should be private while not in development
props = properties(Aircraft);
num_props = length(props);

%% Make getters
bool_make_getters = false;
% Template:

        % function val = Get_(obj)
        %     val = obj.val;
        % end
if bool_make_getters
    functions = strings(1, num_props);
    
    for i_prop = 1:num_props
        prop = props{i_prop};
        function_expression = sprintf("\t\tfunction %s = Get_%s(obj)\n" + ...
            "\t\t\t%s = obj.%s;\n" + ...
            "\t\t\treturn;\n" + ...
            "\t\tend\n", prop, prop, prop, prop);
    
        functions(i_prop) = function_expression;
    end
    
    % Write out file for copy paste into class def file
    filename_getters = "getters_copy_paste.txt";
    delete(filename_getters)
    writelines(functions, filename_getters);
end

%% Make setters
bool_make_setters = false;
% Template:

        % function obj = Set_var(obj, val)
	    %   obj.var = Aircraft.CheckInput(var, val);
		% 	return;
        % end
if bool_make_setters
    functions = strings(1, num_props);
    
    for i_prop = 1:num_props
        prop = props{i_prop};
        function_expression = sprintf("\t\tfunction obj = Set_%s(" + ...
            "obj, val)\n" + ...
            "\t\t\tobj.%s = Aircraft.CheckInput(""%s"", val);\n" + ...
            "\t\t\treturn;\n" + ...
            "\t\tend\n", prop, prop, prop);
    
        functions(i_prop) = function_expression;
    end
    
    % Write out file for copy paste into class def file
    filename_setters = "setters_copy_paste.txt";
    delete(filename_setters)
    writelines(functions, filename_setters);
end

%% Test area
% aircraft = Aircraft(a_t = [1, 2]);
% aircraft.Get_a_t;

equation = ["C_L_0 + C_L_alpha * alpha_w + C_L_i_t * i_t + C_L_delta_e * delta_e;"];
required_vars_control = {"C_L_0", "C_L_alpha", "alpha_w", "C_L_i_t", "i_t", "C_L_delta_e", "delta_e"};

required_vars_test = GetRequired_Vars(equation)

function required_vars = GetRequired_Vars(equations)
    
    num_equations = length(equations);
    for i_equation = 1:num_equations
        disp(num_equations)
    end
    required_vars = 1;
    return;
end