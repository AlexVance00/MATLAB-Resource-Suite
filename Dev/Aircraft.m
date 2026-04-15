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
%   1) Symbolic Math Toolbox
% -------------------------------------------------------------------------
% Nomenclature
%   <Symbol> = <Meaning> (<Units>)
% -------------------------------------------------------------------------
% MATLAB Version R2024b, also compatible with:
%   - R2025a
% -------------------------------------------------------------------------
% Developed by Alex Vance at https://github.com/AlexVance00
classdef Aircraft < handle

    properties (Access = private)
        solvable_properties = "";

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

        % Longitudinal Stability Derivatives
            % Forces, Moments, and Turn Rates (9)
        X_u = [];
        X_T_u = [];
        X_alpha = [];
        X_delta_e = [];

        Z_u = [];
        Z_alpha = [];
        Z_q = [];
        Z_alpha_dot = [];
        Z_delta_e = [];

        M_u = [];
        M_T_u = [];
        M_alpha = [];
        M_alpha_dot = [];
        M_delta_e = [];
        M_T_alpha = [];
        M_q = [];

            % Lift
        C_L_u = [];
        C_L_alpha_dot = [];

            % Drag
        C_D_u = [];
        C_D_alpha = [];
        C_D_delta_e = [];

            % Thrust
        C_T_u = [];

            % M - Pitch Moment
        C_M_u = [];
        C_M_T_u = [];
        C_M_T_alpha = [];

            % Pre-perturbation Values
        q_bar_1 = [];
        u_1 = [];
        theta_1 = [];
        C_L_1 = [];
        C_D_1 = [];
        C_T_1 = [];
        C_M_1 = [];
        C_M_T_1 = [];

            % Perturbations
        delta_u_dot = [];
        delta_u = [];
        delta_theta = [];
        delta_alpha_dot = [];
        delta_q = [];
        delta_q_dot = [];
        delta_theta_dot = [];

        %%  Wing
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
        c_d_0_w = [];

        x_ac_w = [];
        x_bar_ac_w = [];
        y_ac_w = [];

        %%  Horizontal Tail
        % Coefficients
        C_L_0_t = [];
        C_L_alpha_t = [];
        C_L_i_t = [];
        C_L_delta_e_t = [];
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

        %%  Vertical Fin
        % Coefficients
        C_L_alpha_f = [];
        C_L_delta_r = [];

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
            
            off_limits_prop_names = ["solvable_properties"];

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
                elseif ~ismember(off_limits_prop_names, prop_name)
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
        % Vectorized to allow vector inputs for new_val
        function obj = Set(obj, var_name, new_val)
            % For Solve() later
            filename_equations = append(pwd, "\permutations.mat");
            all_equations = load(filename_equations);

            prop_names = GetPropNames(obj);
            if ismember(var_name, prop_names)
                % Need to check if var_name is "units" because "units" is a
                %   string
                non_numeric_prop_names = ["units"];
                off_limits_prop_names = ["solvable_properties"];
                current_val = obj.Get(var_name);

                if ~ismember(var_name, non_numeric_prop_names)
                    num_vals = length(new_val);
                    for i = 1:num_vals
                        val = new_val(i);
                        obj.(var_name) = Aircraft.CheckInput(var_name, ...
                            val, current_val);

                        % Back solve now-solvable values
                        obj = Solve(obj, var_name, all_equations, []);
                    end
                elseif ~ismember(var_name, off_limits_prop_names)
                    if var_name == "units"
                        if ~isscalar(new_val)
                            warning("Invalid non-scalar input for " + ...
                                "'units' argument\nValid inputs are " + ...
                                "<'m-kg', 'ft-slugs'>\nDefault is " + ...
                                "'ft-slugs'");
                        elseif ~ismember(new_val, ["m-kg", "ft-slugs"])
                            
                            % Invalid input, should not change the value
                            warning("Invalid input for 'units' " + ...
                                "argument\nValid inputs are <'m-kg'" + ...
                                ", 'ft-slugs'>\nDefault is 'ft-slugs'");
                            obj.units = current_val;
                        else
                            obj.units = new_val;
                            new_units = new_val;
                            SolveUnits(new_units);
                        end                        
                    else
                        obj.(var_name) = new_val;
                    end
                end
            else
                warning("No valid property ""%s"" of Aircraft", var_name);
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
        % blacklisted_var_names is a string array of var_names to ignore
        %   solving for - for recursion
        % Pass in [] for blacklisted_var_names and equations if call is
        %   fresh
        % all_equations is a struct with a fieldname for each property.
        %   Each field's value is a string array of all the permutations of
        %   the equations that variable is in
        function obj = Solve(obj, var_name, all_equations, blacklisted_var_names)
            % Gets all equations pertaining to this var_name
            equations_this_var = all_equations.(var_name)';
            num_equations = length(equations_this_var);

            % From equations, get required variable sets
            required_var_sets = Aircraft.GetRequired_Vars(equations_this_var);

            % Get master_var_list for loading more equations
            unique_var_list = unique([required_var_sets{:}])';
            num_vars_major = length(unique_var_list);

            % Add vars to solvable properties, but make them
            %   unique
            obj.solvable_properties = unique([obj.solvable_properties; unique_var_list]);
            
            %% Initialize required variable references
            % Do this before removing blacklisted_var_names
            for i_var = 1:num_vars_major
                % Get var_name
                this_var_name = unique_var_list(i_var);

                % Pull var's val
                val = obj.(this_var_name);

                % Initialize var_name with val
                eval(append(this_var_name, " = val;"));
            end

            off_limits_prop_names = ["units"; "solvable_properties"];

            % Add this var_name to blacklisted_var_names
            % Then remove all blacklisted_var_names from unique_var_list
            prop_names = GetPropNames(obj);
            unsolvable_properties = prop_names(~ismember(prop_names, [obj.solvable_properties; unique_var_list; off_limits_prop_names]));
            blacklisted_var_names = unique([blacklisted_var_names; ...
                                     unsolvable_properties; ...
                                     var_name]);
            unique_var_list = unique_var_list(~ismember(unique_var_list, blacklisted_var_names));
            num_vars_major = length(unique_var_list);            

            %% Base Case
            % unique_var_list is empty
            if num_vars_major == 0
                for i_equation = 1:num_equations
                    var_set = required_var_sets{i_equation};
                    var_set = var_set(~ismember(var_set, var_name));

                    if ~any(arrayfun(@(name) isempty(obj.(name)), var_set)) && ~isempty(var_set)
                        % Get equation
                        equation = equations_this_var(i_equation);
                        % Evaluate equation and calculate var_name_major's
                        %   new value
                        eval(equation);
                        % Assign this new value to its property in obj
                        obj.(var_name) = eval(var_name);

                        % Add potentially-now-solvable variables to
                        %   solvable_properties
                        equations_to_check = all_equations.(var_name)';

                        % Get variable sets
                        var_sets_to_check = Aircraft.GetRequired_Vars(equations_to_check);

                        % Get unique variables from those sets
                        vars_to_add = unique([var_sets_to_check{:}])';

                        % Remove the variable that was just solved from the
                        %   set of uniques
                        vars_to_add = vars_to_add(~ismember(vars_to_add, var_name));

                        % Add vars to solvable properties, but make them
                        %   unique
                        obj.solvable_properties = unique([obj.solvable_properties; vars_to_add]);

                        fprintf("SOLVED %s\n", var_name)
                        % Skip to next major variable
                        return;
                    end
                    % No equations were solveable
                    if i_equation == num_equations
                        fprintf("Could not solve %s\n", var_name)

                        % Remove now non-solvable var from
                        %   solvable_properties
                        obj.solvable_properties = obj.solvable_properties(~ismember(obj.solvable_properties, var_name));
                        return;
                    end
                end
            end

            %% Checks if any equations can be solved
            % For debugging
            fprintf("Vars to iterate through to solve %s: %d\n", var_name, num_vars_major);
            for i_var_major = 1:num_vars_major
                % Get this var's name
                var_name_major = unique_var_list(i_var_major);
                % if var_name_major == "C_L_0_w"
                %     pause
                % end
                if ~ismember(obj.solvable_properties, var_name_major)
                    continue;
                end
                obj = Solve(obj, var_name_major, all_equations, blacklisted_var_names);
            end
            return;
        end

        function obj = SolveUnits(obj)
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

        % Returns a cell array of unique variables for every input equation
        function required_var_sets = GetRequired_Vars(equations)
            num_equations = length(equations);

            % Get all unique variables
            required_var_sets = {};
            for i_equation = 1:num_equations
                equation = equations(i_equation);
                vars = string(symvar(equation))';

                required_var_sets{i_equation} = vars;
            end
            required_var_sets = required_var_sets';
            return;
        end
    end
end