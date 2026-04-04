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
    properties (Access = private)
        % <"m-kg", "ft-slugs">
        units = "ft-slugs";

        %% Values
        %%  Aircraft
        % Coefficients
        C_L = [];
        C_L_0 = [];
        C_L_alpha = [];
        C_L_delta_e = [];
        C_L_q = [];
        C_L_0_prime = [];

        C_M = [];
        C_M_0 = [];
        C_M_alpha = [];
        C_M_delta_e = [];
        C_M_q = [];
        C_M_0_prime = [];
        C_M_0_p = [];
        C_M_0_f = [];
        C_M_alpha_p = [];
        C_M_alpha_f = [];

        C_y = [];
        C_y_beta = [];
        C_y_delta_r = [];
        C_y_r = [];

        C_n = [];
        C_n_beta = [];
        C_n_delta_r = [];
        C_n_delta_a = [];
        C_n_r = [];
        C_n_sigma = [];

        C_l = [];
        C_l_beta_w = [];
        C_l_beta_f = [];
        C_l_beta_d = [];
        C_l_beta_s = [];
        C_l_delta_r = [];
        C_l_delta_a = [];
        C_l_r = [];
        C_l_p = [];

        eta_t = [];
        eta_f = [];
        eta_1 = [];
        eta_2 = [];
        
        C_w = [];
        n = [];
        mu = [];
        nu = [];

        % Angles
        beta = [];
        sigma_beta = [];
        sigma_0 = [];
        phi = [];
        theta = [];
        psi = [];
        phi_dot = [];
        theta_dot = [];
        psi_dot = [];

        % Rotation rates and rotation accelerations
        p_i = [];
        q_i = [];
        r_i = [];
        p_i_dot = [];
        q_i_dot = [];
        r_i_dot = [];
        p_b = [];
        q_b = [];
        r_b = [];
        p_b_dot = [];
        q_b_dot = [];
        r_b_dot = [];

        % Velocities and accelerations
        u = [];
        v = [];
        w = [];
        u_dot = [];
        v_dot = [];
        w_dot = [];

        % Mass properties
        W = [];
        m = [];
        I_xx = [];
        I_yy = [];
        I_zz = [];
        I_xy = [];
        I_xz = [];
        I_yz = [];

        % Forces and moments
        sum_F = [];
        L = [];
        D = [];
        T = [];
        sum_M = [];
        M = [];
        N_T = [];

        % Non-aircraft-related constants
        rho = [];
        g = [];

        % Geometry
        x_cg = [];
        x_bar_cg = [];
        x_ac = [];
        x_bar_ac = [];
        z_cg = [];
        SM = [];

        %% Wing
        % Coefficients
        C_L_0_w = [];
        C_L_alpha_w = [];
        c_l_0_w = [];
        c_l_alpha_w = [];

        c_m_ac_w = [];

        a_w = [];

        AR_w = [];
        lambda_w = [];
        sweep_w = [];
        gamma_w = [];
        tau_w = [];

        % Angles
        i_w = [];
        alpha_w = [];
        alpha_L_0_w = [];
        alpha_w_trim = [];
        alpha_w_trim_delta_e_0 = [];
        delta_a_w = [];
        delta_alpha = [];

        % Flight conditions
        q_bar_w = [];

        % Geometry
        S_w = [];
        b_w = [];
        c_bar_w = [];
        c_r_w = [];
        c_t_w = [];
        c_w = [];

        x_ac_w = [];
        x_bar_ac_w = [];
        y_ac_w = [];

        %% Horizontal Tail
        % Coefficients
        C_L_0_t = [];
        C_L_alpha_t = [];
        C_L_i_t = [];
        c_l_0_t = [];
        c_l_alpha_t = [];

        C_M_i_t = [];
        c_m_ac_t = [];

        a_t = [];

        AR_t = [];
        lambda_t = [];
        sweep_t = [];
        gamma_t = [];
        tau_t = [];

        % Angles
        i_t = [];
        i_t_trim = [];
        alpha_t = [];
        alpha_L_0_t = [];
        alpha_t_trim = [];
        delta_e_trim = [];
        epsilon_alpha_t = [];
        epsilon_0_t = [];
        delta_e = [];
        delta_delta_e = [];
        delta_a_t = [];

        % Flight conditions
        q_bar_t = [];
        q_bar_f = [];

        % Geometry
        S_t = [];
        b_t = [];
        c_bar_t = [];
        c_r_t = [];
        c_t_t = [];

        % Equations
        c_t = [];
        
        x_ac_t = [];
        x_bar_ac_t = [];
        y_ac_t = [];

        %% Vertical Fin
        % Coefficients
        C_L_alpha_f = [];

        % Angles
        delta_r = [];

        % Geometry
        S_f = [];
        b_f = [];
        c_bar_f = [];
        c_r_f = [];
        c_t_f = [];

        % Equations
        c_f = [];

        x_bar_ac_f = [];
        x_ac_f = [];
        y_ac_f = [];
    end

    methods (Access = public)

        %% Constructor
        function obj = Aircraft()      
            return;
        end

        %% Copy Constructor
        function new_obj = copy(obj)
            new_obj = Aircraft();
            prop_names = GetPropNames(obj);
            num_props = length(prop_names);

            for i_prop = 1:num_props
                prop_name = prop_names{i_prop};

                new_obj.(prop_name) = obj.(prop_name);
            end
        end
        
        %% Disp
        % Overwrote disp because every property is a struct, but only the
        %   "value" field is important for the user to see
        function disp(obj, bool_disp_full)
            if nargin < 2
                bool_disp_full = false;
            end

            prop_names = GetPropNames(obj);
            num_props = length(prop_names);
            
            prop_name_sizes = cellfun(@size, prop_names, ...
                "UniformOutput", false);
            max_prop_name_length = max([prop_name_sizes{:}]);

            fprintf("Aircraft object with properties:\n\n");
            for i_name = 1:num_props
                prop_name = string(prop_names{i_name});
                prop_val = obj.(prop_name);

                if class(prop_val) ~= "string"
                        
                    if ~isempty(prop_val)
                        % If not a whole number,
                        if mod(prop_val, 1) ~= 0
                            fprintf("\t%*s: %.4f\n", ...
                                max_prop_name_length, prop_name, prop_val);
                        else
                            fprintf("\t%*s: %d\n", ...
                                max_prop_name_length, prop_name, prop_val);
                        end
                    elseif bool_disp_full
                        fprintf("\t%*s: []\n", max_prop_name_length, ...
                            prop_name);
                    end
                else
                    fprintf("\t%*s: ""%s""\n", max_prop_name_length, ...
                            prop_name, prop_val);
                end
            end
            fprintf("\n");
        end

        %% Universal Getter
        function val = Get(obj, var_name)
            if class(var_name) == "string"
                prop_names = GetPropNames(obj);

                if ismember(var_name, prop_names)
                    val = obj.(var_name);
                else
                    warning("No property ""%s"" of Aircraft", var_name);
                end
            else
                warning("Invalid class ""%s"" for argument " + ...
                    """var_name""", class(var_name));
            end
        end
        
        %% Universal Setter
        function obj = Set(obj, var_name, val)
            prop_names = GetPropNames(obj);
            if ismember(var_name, prop_names)
                % Need to check if var_name is "units" because "units" is a
                %   string
                non_numeric_prop_names = ["units"];
                if ~ismember(var_name, non_numeric_prop_names)
                    current_val = obj.Get(var_name);
                    obj.(var_name) = Aircraft.CheckInput(var_name, ...
                        val, current_val);
                else
                    if var_name == "units"
                        if ~ismember(val, ["m-kg", "ft-slugs"])
                            warning("Invalid input for 'units' " + ...
                                "argument\nValid inputs are <'m-kg'" + ...
                                ", 'ft-slugs'>\nDefault is 'ft-slugs'");
                            obj.units = "ft-slugs";
                        else
                            obj.units = val;
                        end
                    else
                        obj.(var_name) = val;
                    end
                end
            else
                warning("No property ""%s"" of Aircraft", var_name);
            end
	        return;
        end
    end

    methods (Access = private)
        % Get all prop names, even when access is private
        function prop_names = GetPropNames(obj)
            mc = metaclass(obj);
            prop_names = string({mc.PropertyList.Name})';
            return;
        end

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
        function new_val = CheckInput(var_name, new_val, current_val)
            
            % Special Input Checking
            if class(new_val) == "double"
                if isscalar(new_val) || isempty(new_val)
                    if isreal(new_val)
                        return;
                    else
                        warning("Could not set variable " + ...
                            """%s""\nArgument ""%.4f"" must be" + ...
                            "real", var_name, new_val);
                        new_val = [];
                        
                    end
                else
                    warning("Could not set " + ...
                        "variable ""%s""\nArgument must " + ...
                        "be scalar:", var_name);
                    disp(new_val);
                    new_val = current_val; 
                end
            else
                warning("Could not set variable " + ...
                        """%s""\nArgument ""%s"" must be " + ...
                        "class ""double""", var_name, new_val);
                new_val = current_val;                
            end
            return;
        end
    end
end