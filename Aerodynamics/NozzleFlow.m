% <Explanation>
% -------------------------------------------------------------------------
% Units: SI or Imperial
% Assumptions:
%   - <Assumption>
% -------------------------------------------------------------------------
classdef NozzleFlow

    properties
        bool_Fanno
        bool_Rayleigh

        % Ignored if Fanno or Rayleigh
        % "a" : Completely subsonic
        % "b" : Just-choked
        % "c" : Shock in nozzle divergent section
        % "d" : Shock at nozzle exit
        % "e" : Overexpanded - exit flow pressure < ambient pressure
        % "f" : Design - Perfectly expanded nozzle divergent section
        % "g" : Underexpanded - exit flow pressure > ambient pressure
        flow_case

        M
        M_1
        M_2
        p
        p_o
        p_star
        p_o_star
        p_1
        p_o_1
        p_2
        p_o_2
        rho
        rho_o
        rho_star
        rho_o_star
        rho_1
        rho_o_1
        rho_2
        rho_o_2
        T
        T_o
        T_star
        T_o_star
        T_1
        T_o_1
        T_2
        T_o_2
        u
        u_star
        a
        a_star
        A
        A_star
        A_1
        A_2
        nu
        mu
        gamma
        R
        c_v
        c_p

        % <"SI", "Imperial">
        units
    end

    methods (Access = public)

        function addHeat(args)

            %% Argument handling
            % Allows arguments to be optional and instantiated in the 
            %   function call like "functionname(<varname> = <value>, ...)"
            arguments
                args.value_1 = [];
            end

            arg_name_list = fieldnames(args);

            % Makes variables out of args' fieldnames
            for i_fieldname = 1:length(arg_name_list)
                arg_name = arg_name_list{i_fieldname};
        
                % Input checking
                if ~isempty(args.(arg_name))
                    eval(append(arg_name, " = args.(arg_name);"));
                else
                    % If any are empty, throw error
                    error("No input for '%s' parameter", arg_name)
                end
            end
            
        end

    end

    methods (Access = private)

        function 

        end

    end

end