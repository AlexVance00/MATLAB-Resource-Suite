% <Class Purpose>
% -------------------------------------------------------------------------
% Dependencies
%   1) <Dependency 1>
% -------------------------------------------------------------------------
% MATLAB Version <Oldest Version>, also compatible with:
%   - <Later Version>
% -------------------------------------------------------------------------
% Developed by Alex Vance
classdef ClassTemplate

    properties

    end

    methods (Access = public)

        % <Function Purpose>
        % <Output> in (<Units>)
        % -----------------------------------------------------------------
        % Assumptions
        %   1) <Assumption 1>
        % -----------------------------------------------------------------
        % Arguments
        %   <Symbol> = <Explanation> (<Units>)
        % -----------------------------------------------------------------
        % Dependencies
        %   1) <Dependency 1>
        % -----------------------------------------------------------------
        % Sources
        %   1) <Source 1>
        % -----------------------------------------------------------------
        % MATLAB Version <Oldest Version>, also compatible with:
        %   - <Later Version>
        function result = GetResult(args)
        
            % Allows arguments to be optional and assigned in the function
            %   call as in: GetResult(<varname> = <value>, ...)
        
            % Classify Non-Optional Arguments
            arguments
                args.arg_1 = [];
            end
            arg_name_list = fieldnames(args);
        
            % Classify Optional Arguments - 1D String Array
            optional_arg_names = [];
        
            % Makes variables out of args' fieldnames
            for i_fieldname = 1:length(arg_name_list)
                arg_name = arg_name_list{i_fieldname};
                arg_val = args.(arg_name);
        
                % Input Checking
                if ~isempty(arg_val)
        
                    % Initializes given optional arguments
                    eval(append(arg_name, " = arg_val;"));
                elseif ~ismember(arg_name, optional_arg_names)
                    
                    % If any non-optional arguments are un-initialized,
                    %   throws error
                    error("No input for non-optional '%s' parameter", ...
                        arg_name);
                end
            end
        
            % Unit Conversions
        
            % Intermediate Calculations
        
            % Final Calculations
        
            % Display Results and/or Plotting
        
            return;
        end

    end

    methods (Access = private)

    end

end