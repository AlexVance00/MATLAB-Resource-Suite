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

        % function obj = var(obj, val)
		% 	if class(val) == "double"
		% 		obj.var = val;
		% 	else
		% 		warning("Could not set var to val, val must be " + ...
        %             "class ""double""");
		% 	end
		% 	return;
        % end
if bool_make_setters
    functions = strings(1, num_props);
    
    for i_prop = 1:num_props
        prop = props{i_prop};
        function_expression = sprintf("\t\tfunction obj = Set_%s(" + ...
            "obj, val)\n" + ...
            "\t\t\tif class(val) == ""double""\n" + ...
            "\t\t\t\tobj.%s = val;\n" + ...
            "\t\t\telse\n" + ...
            "\t\t\t\twarning(""Could not set %s to val, val " + ...
            "must be "" + ...\n\t\t\t\t\t""class """"double"""""");" + ...
            "\n\t\t\tend\n" + ...
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
aircraft = Aircraft(a_t = [1, 2]);
aircraft.Get_a_t