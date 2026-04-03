% Meant to track properties of an aircraft
% -------------------------------------------------------------------------
% Assumptions
%   1) Fixed wing, non-fixed tail horizontal surface
%   2) Rigid body
%   3) No tail dihedral
%   4) Lateral symmetry
%   5) Trapezoidal wing and tail horizontal surface shapes
% -------------------------------------------------------------------------
% Dependencies
%   1) <Dependency 1>
% -------------------------------------------------------------------------
% Nomenclature
%   <Symbol> = <Meaning> (<Units>)
% -------------------------------------------------------------------------
% MATLAB Version R2024b, also compatible with:
%   - R2025a
% -------------------------------------------------------------------------
% Developed by Alex Vance
classdef Aircraft < handle

    % Access should be private while not in development
    properties (Access = public)
        % <"m-kg", "ft-slugs">
        units = "ft-slugs";

        %% Values
        %%  Aircraft
        % Coefficients
        % C_L = C_L_0 + C_L_alpha * alpha_w + C_L_i_t * i_t + C_L_delta_e * delta_e
        % C_L = L / (q_bar_w * S_w)
        C_L = struct("value", [], "equations", ["C_L_0 + C_L_alpha * alpha_w + C_L_i_t * i_t + C_L_delta_e * delta_e;", "L / (q_bar_w * S_w);"]);
        C_L_0 = struct("value", [], "equations", [""]);
        C_L_alpha = struct("value", [], "equations", [""]);
        C_L_delta_e = struct("value", [], "equations", [""]);
        C_L_q = struct("value", [], "equations", [""]);
        C_L_0_prime = struct("value", [], "equations", [""]);

        C_M = struct("value", [], "equations", [""]);
        C_M_0 = struct("value", [], "equations", [""]);
        C_M_alpha = struct("value", [], "equations", [""]);
        C_M_delta_e = struct("value", [], "equations", [""]);
        C_M_q = struct("value", [], "equations", [""]);
        C_M_0_prime = struct("value", [], "equations", [""]);
        C_M_0_p = struct("value", [], "equations", [""]);
        C_M_0_f = struct("value", [], "equations", [""]);
        C_M_alpha_p = struct("value", [], "equations", [""]);
        C_M_alpha_f = struct("value", [], "equations", [""]);

        C_y = struct("value", [], "equations", [""]);
        C_y_beta = struct("value", [], "equations", [""]);
        C_y_delta_r = struct("value", [], "equations", [""]);
        C_y_r = struct("value", [], "equations", [""]);

        C_n = struct("value", [], "equations", [""]);
        C_n_beta = struct("value", [], "equations", [""]);
        C_n_delta_r = struct("value", [], "equations", [""]);
        C_n_delta_a = struct("value", [], "equations", [""]);
        C_n_r = struct("value", [], "equations", [""]);
        C_n_sigma = struct("value", [], "equations", [""]);

        C_l = struct("value", [], "equations", [""]);
        C_l_beta_w = struct("value", [], "equations", [""]);
        C_l_beta_f = struct("value", [], "equations", [""]);
        C_l_beta_d = struct("value", [], "equations", [""]);
        C_l_beta_s = struct("value", [], "equations", [""]);
        C_l_delta_r = struct("value", [], "equations", [""]);
        C_l_delta_a = struct("value", [], "equations", [""]);
        C_l_r = struct("value", [], "equations", [""]);
        C_l_p = struct("value", [], "equations", [""]);

        eta = struct("value", [], "equations", [""]);
        eta_1 = struct("value", [], "equations", [""]);
        eta_2 = struct("value", [], "equations", [""]);
        
        C_w = struct("value", [], "equations", [""]);
        n = struct("value", [], "equations", [""]);
        mu = struct("value", [], "equations", [""]);
        nu = struct("value", [], "equations", [""]);

        % Angles
        beta = struct("value", [], "equations", [""]);
        sigma_beta = struct("value", [], "equations", [""]);
        sigma_0 = struct("value", [], "equations", [""]);
        phi = struct("value", [], "equations", [""]);
        theta = struct("value", [], "equations", [""]);
        psi = struct("value", [], "equations", [""]);
        delta_a = struct("value", [], "equations", [""]);
        delta_e = struct("value", [], "equations", [""]);
        delta_r = struct("value", [], "equations", [""]);

        % Rotation rates and rotation accelerations
        p_i = struct("value", [], "equations", [""]);
        q_i = struct("value", [], "equations", [""]);
        r_i = struct("value", [], "equations", [""]);
        p_i_dot = struct("value", [], "equations", [""]);
        q_i_dot = struct("value", [], "equations", [""]);
        r_i_dot = struct("value", [], "equations", [""]);
        p_b = struct("value", [], "equations", [""]);
        q_b = struct("value", [], "equations", [""]);
        r_b = struct("value", [], "equations", [""]);
        p_b_dot = struct("value", [], "equations", [""]);
        q_b_dot = struct("value", [], "equations", [""]);
        r_b_dot = struct("value", [], "equations", [""]);

        % Velocities and accelerations
        u = struct("value", [], "equations", [""]);
        v = struct("value", [], "equations", [""]);
        w = struct("value", [], "equations", [""]);
        u_dot = struct("value", [], "equations", [""]);
        v_dot = struct("value", [], "equations", [""]);
        w_dot = struct("value", [], "equations", [""]);

        % Mass properties
        W = struct("value", [], "equations", [""]);
        m = struct("value", [], "equations", [""]);
        I_xx = struct("value", [], "equations", [""]);
        I_yy = struct("value", [], "equations", [""]);
        I_zz = struct("value", [], "equations", [""]);
        I_xy = struct("value", [], "equations", [""]);
        I_xz = struct("value", [], "equations", [""]);
        I_yz = struct("value", [], "equations", [""]);

        % Forces and moments
        sum_F = struct("value", [], "equations", [""]);
        L = struct("value", [], "equations", [""]);
        D = struct("value", [], "equations", [""]);
        T = struct("value", [], "equations", [""]);
        sum_M = struct("value", [], "equations", [""]);
        M = struct("value", [], "equations", [""]);
        N_T = struct("value", [], "equations", [""]);

        % Non-aircraft-related constants
        rho = struct("value", [], "equations", [""]);
        g = struct("value", [], "equations", [""]);

        % Geometry
        x_cg = struct("value", [], "equations", [""]);
        x_bar_cg = struct("value", [], "equations", [""]);
        x_ac = struct("value", [], "equations", [""]);
        x_bar_ac = struct("value", [], "equations", [""]);
        z_cg = struct("value", [], "equations", [""]);
        SM = struct("value", [], "equations", [""]);

        %% Wing
        % Coefficients
        C_L_0_w = struct("value", [], "equations", [""]);
        C_L_alpha_w = struct("value", [], "equations", [""]);
        c_l_0_w = struct("value", [], "equations", [""]);
        c_l_alpha_w = struct("value", [], "equations", [""]);

        c_m_ac_w = struct("value", [], "equations", [""]);

        a_w = struct("value", [], "equations", [""]);

        AR_w = struct("value", [], "equations", [""]);
        lambda_w = struct("value", [], "equations", [""]);
        sweep_w = struct("value", [], "equations", [""]);
        gamma_w = struct("value", [], "equations", [""]);

        % Angles
        i_w = struct("value", [], "equations", [""]);
        alpha_w = struct("value", [], "equations", [""]);
        alpha_L_0_w = struct("value", [], "equations", [""]);
        alpha_w_trim = struct("value", [], "equations", [""]);
        alpha_w_trim_delta_e_0 = struct("value", [], "equations", [""]);

        % Flight conditions
        q_bar_w = struct("value", [], "equations", [""]);

        % Geometry
        S_w = struct("value", [], "equations", [""]);
        b_w = struct("value", [], "equations", [""]);
        c_bar_w = struct("value", [], "equations", [""]);
        c_r_w = struct("value", [], "equations", [""]);
        c_t_w = struct("value", [], "equations", [""]);
        c_w = struct("value", [], "equations", [""]);

        x_ac_w = struct("value", [], "equations", [""]);
        x_bar_ac_w = struct("value", [], "equations", [""]);
        y_ac_w = struct("value", [], "equations", [""]);

        %% Tail
        % Coefficients
        C_L_0_t = struct("value", [], "equations", [""]);
        C_L_alpha_t = struct("value", [], "equations", [""]);
        C_L_i_t = struct("value", [], "equations", [""]);
        c_l_0_t = struct("value", [], "equations", [""]);
        c_l_alpha_t = struct("value", [], "equations", [""]);

        C_M_i_t = struct("value", [], "equations", [""]);
        c_m_ac_t = struct("value", [], "equations", [""]);

        a_t = struct("value", [], "equations", [""]);

        AR_t = struct("value", [], "equations", [""]);
        lambda_t = struct("value", [], "equations", [""]);
        sweep_t = struct("value", [], "equations", [""]);
        gamma_t = struct("value", [], "equations", [""]);

        % Angles
        i_t = struct("value", [], "equations", [""]);
        i_t_trim = struct("value", [], "equations", [""]);
        alpha_t = struct("value", [], "equations", [""]);
        alpha_L_0_t = struct("value", [], "equations", [""]);
        alpha_t_trim = struct("value", [], "equations", [""]);
        delta_e_trim = struct("value", [], "equations", [""]);
        epsilon_alpha_t = struct("value", [], "equations", [""]);
        epsilon_0_t = struct("value", [], "equations", [""]);

        % Flight conditions
        q_bar_t = struct("value", [], "equations", [""]);
        q_bar_f = struct("value", [], "equations", [""]);

        % Geometry
        S_t = struct("value", [], "equations", [""]);
        S_f = struct("value", [], "equations", [""]);
        b_t = struct("value", [], "equations", [""]);
        b_f = struct("value", [], "equations", [""]);
        c_bar_t = struct("value", [], "equations", [""]);
        c_bar_f = struct("value", [], "equations", [""]);
        c_r_t = struct("value", [], "equations", [""]);
        c_t_t = struct("value", [], "equations", [""]);
        c_r_f = struct("value", [], "equations", [""]);
        c_t_f = struct("value", [], "equations", [""]);
        c_t = struct("value", [], "equations", [""]);
        c_f = struct("value", [], "equations", [""]);
        
        x_ac_t = struct("value", [], "equations", [""]);
        x_bar_ac_t = struct("value", [], "equations", [""]);
        y_ac_t = struct("value", [], "equations", [""]);
        y_ac_f = struct("value", [], "equations", [""]);
    end

    methods (Access = public)

        %% Constructor
        function obj = Aircraft(args)
        
            % Allows arguments to be optional and assigned in the function
            %   call as in: GetResult(<varname> = <value>, ...)
        
            % Classify Non-Optional Arguments
            arguments
                args.?Aircraft
            end
            arg_names = fieldnames(args);
            num_args = length(arg_names);
            
            % Input checking
            for i_arg = 1:num_args
                arg_name = arg_names{i_arg};
                arg_val = args.(arg_name);

                if arg_name ~= "units"
                    arg_val = Aircraft.CheckInput(arg_name, arg_val);
                else
                    if arg_val ~= "m-kg" && arg_val ~= "ft-slugs"
                        warning("Invalid input for 'units' " + ...
                            "argument\nValid inputs are <'m-kg', " + ...
                            "'ft-slugs'>\nDefault is 'ft-slugs'");
                        args.units = "ft-slugs";
                    end
                end
            end

            for i_arg = 1:length(arg_names)
                arg_name = arg_names{i_arg};
                arg_val = args.(arg_name);
                obj.(arg_name) = arg_val;
            end
        
            return;
        end

        %% Copy Constructor
        function new_obj = copy(obj)
            new_obj = Aircraft();
            prop_names = properties(obj);
            num_props = length(prop_names);

            for i_prop = 1:num_props
                prop_name = prop_names{i_prop};

                new_obj.(prop_name) = obj.(prop_name);
            end
        end
        
        %% Disp
        % Overwrote disp because every property is a struct, but only the
        %   "value" field is important for the user to see
        function disp(obj)
            prop_names = properties(Aircraft);
            num_props = length(prop_names);

            prop_name_sizes = cellfun(@size, prop_names, ...
                "UniformOutput", false);
            max_prop_name_length = max([prop_name_sizes{:}]);

            fprintf("Aircraft object with properties:\n\n");
            for i_name = 1:num_props
                prop_name = string(prop_names{i_name});

                if prop_name ~= "units"
                    prop_val = obj.(prop_name).value;
                        
                    if ~isempty(prop_val)
                        % If not a whole number,
                        if mod(prop_val, 1) ~= 0
                            fprintf("\t%*s: %.4f\n", ...
                                max_prop_name_length, prop_name, prop_val);
                        else
                            fprintf("\t%*s: %d\n", ...
                                max_prop_name_length, prop_name, prop_val);
                        end
                    else
                        fprintf("\t%*s: []\n", max_prop_name_length, ...
                            prop_name);
                    end
                end
            end
        end

        %% Universal Getter
        function val = Get(obj, var_name)
            if class(var_name) == "string"
                if ismember(var_name, properties(Aircraft))

                    % Need to check if var_name is "units" because "units" is a
                    %   string, not a struct
                    non_numeric_prop_names = ["units"];
                    
                    if ~ismember(var_name, non_numeric_prop_names)
                        val = obj.(var_name).value;
                    else
                        val = obj.(var_name);
                    end
                else
                    warning("No property ""%s"" of Aircraft", var_name);
                end
            else
                warning("Invalid class ""%s"" for argument" + ...
                    """var_name""", class(var_name));
            end
        end
        
        %% Universal Setter
        function obj = Set(obj,var_name, val)
            % Need to check if var_name is "units" because "units" is a
            %   string, not a struct
            non_numeric_prop_names = ["units"];
            if ~ismember(var_name, non_numeric_prop_names)
                obj.(var_name).value = Aircraft.CheckInput(var_name, val);
            else
                obj.(var_name) = val;
            end
	        return;
        end
    end

    methods (Access = private)

        %% Solvers
        % Solves for, but does not return, the input variable
        % -----------------------------------------------------------------
        % Arguments
        %   assignee = variable name to be solved for as a string
        %   equations = string array of equations, which are themselves
        %       strings
        %   required_var_sets = cell array of cell arrays; the inner cell
        %       arrays are sets of variable names that are part of one
        %       equation
        % -----------------------------------------------------------------
        % Comments
        %   1) Elements of arguments should match up with those of
        %       equations and required_var_sets, i.e. equations(1) should
        %       match up with required_var_sets{1}, where
        %       equations(1) returns a string, and required_var_sets{1}
        %       returns a cell array that is a set of the variable names
        %       in equations(1)
        %   2) Ultimately, the property of obj with the name matching the
        %       string assignee will be assigned the value resulting from
        %       evaluating the string returned by equations(1) if all of
        %       the variables named by elements in the cell array returned
        %       by required_var_sets{1} are known (or *solveable* - coming
        %       soon!)
        function obj = Solve(obj, assignee, equations)
            %% From equations, get required variable sets
            required_var_sets = GetRequired_Vars(equations);
            % For iterating through all variables
            num_equations = length(required_var_sets);
            
            %% Initialize required variable references
            for i_equation = 1:num_equations
                var_set = required_var_sets{i_equation};
                num_vars = length(var_set);
                for i_var = 1:num_vars
                    var_name = var_set{i_var};
                    var = obj.(var_name);

                    eval(append(var_name, " = var;"));
                end
            end

            %% Checks if any equations can be solved
            for i_equation = 1:num_equations
                var_set = required_var_sets{i_equation};
                equation = equations(i_equation);

                % Later possibly add in solveability checker recursion here
                if ~any(cellfun(@(name) isempty(obj.(name)), var_set))
            
                    obj.(assignee) = eval(equation);
                    return;
                end
            end
        
            %% Prints out unknown required variables preventing the solve
            warning("Solve_: insufficient known variables to " + ...
                "solve for %s", assignee);
            fprintf("Unknown variables:\n")
            for i_equation = 1:num_equations
                var_set = required_var_sets{i_equation};
                num_vars = length(var_set);

                for i_var = 1:num_vars
                    var_name = var_set{i_var};
                    var = eval(var_name);
                    if isempty(var)
                        fprintf("%s\n", var_name);
                    end
                end

                % If at the *end* of a var_set but not in the *last*
                %   var_set, print "or" to denote the end of a grouped set
                %   of required variables
                if i_var == num_vars
                    if i_equation ~= num_equations
                        fprintf("--------or--------\n");
                    else
                        fprintf("------------------\n");
                    end
                end
            end

            return;
        end

        % Returns a cell array of unique variables for every input equation
        % -----------------------------------------------------------------
        % Arguments
        %   equations = string or string array of equations
        % -----------------------------------------------------------------
        % Comments
        %   1) Don't use "sqrt()"
        %   2) Don't use dot operators (no element-wise operators,
        %       operands should all be scalars)
        %   3) Only use parenthesis, no square brackets or curly braces
        function required_vars = GetRequired_Vars(equations)
            num_equations = length(equations);
            required_vars = cell(1, num_equations);
            delimiters = ["+", "-", "*", "/", "^", "(", ")", ";"];
            for i_equation = 1:num_equations
                equation = equations(i_equation);
                equation = erase(equation, delimiters);
                terms = unique(strsplit(equation));
                required_vars{i_equation} = terms;
            end
            return;
        end

        % Returns true if input variable is solveable and false if not
        % -----------------------------------------------------------------
        % Arguments
        %   var_name = string, name of variable you want to check the
        %       solveability of
        function bool_IsSolveable = GetSolveability(var_name)
            equations = obj.(var_name).equations;
            bool_IsSolveable = true;

            return;
        end
    end

    methods (Static, Access = private)

        % Checks input validity for scalar, real, numerical variables
        function val = CheckInput(var_name, val)
            if class(val) == "double"
                if isscalar(val)
                    if isreal(val)
                        return;
                    else
                        warning("Could not initialize variable " + ...
                            """%s""\nArgument ""%.4f"" must be" + ...
                            "real", var_name, val);
                        val = [];
                        
                    end
                else
                    warning("Could not initialize " + ...
                        "variable ""%s""\nArgument must " + ...
                        "be scalar:", var_name);
                    disp(val);
                    val = [];
                end
            else
                warning("Could not initialize variable " + ...
                    """%s""\nArgument ""%s"" must be " + ...
                    "class ""double""", var_name, val);
                val = [];
            end
            return;
        end
    end
end