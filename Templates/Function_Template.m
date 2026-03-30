% <Function Purpose>
% <Output> in (<Units>)
% ----------
% <Sources>
% ----------
% MATLAB Version <Version>
% ----------
% Assumptions
%   1) <Assumption 1>
% ----------
% Arguments
%   <Symbol> = <Explanation> (<Units>)

function result = GetResult(args)

    % Allows arguments to be optional and assigned in the function call
    %   as in: GetResult(<varname> = <value>, ...)

    % Classify Non-Optional Arguments
    arguments
        args.arg_1 = [];
        args.arg_2 = [];
    end
    arg_name_list = fieldnames(args);

    % Classify Optional Arguments - 1D String Array
    optional_arg_names = [];

    % Makes variables out of args' fieldnames
    for i_fieldname = 1:length(arg_name_list)
        arg_name = arg_name_list{i_fieldname};

        % Input Checking
        if ~isempty(args.(arg_name))

            % Initializes given optional arguments
            eval(append(arg_name, " = args.(arg_name);"));
        elseif ~ismember(arg_name, optional_arg_names)
            
            % If any non-optional arguments are un-initialized, throws
            %   error
            error("No input for non-optional '%s' parameter", arg_name);
        end
    end

    % Unit Conversions

    % Intermediate Calculations

    % Final Calculations

    % Display Results and/or Plotting

    return;
end