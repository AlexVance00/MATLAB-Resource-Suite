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
% Developed by Alex Vance
classdef Aircraft < handle

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
                current_val = obj.Get(var_name);

                if ~ismember(var_name, non_numeric_prop_names)
                    obj.(var_name) = Aircraft.CheckInput(var_name, ...
                        val, current_val);
                    % Add logic for determining if geometry has changed and
                    %   if flight condition has changed. If geometry
                    %   changes, flight condition does automatically, but
                    %   not the other way around
                    bool_geometry_changed = false;
                    bool_flight_condition_changed = false;

                    % Temporary for debugging
                    obj = Solve(obj, var_name);

                    if bool_geometry_changed
                        % Remember SolveGeometry() calls
                        %   SolveFlightCondition()
                        obj.SolveGeometry();
                    else
                        % Flight condition must have been the only thing to
                        %   change then because we're in the "double" class
                        %   only branch, meaning a numeric property has
                        %   changed
                        obj.SolveFlightCondition();
                    end
                else
                    if var_name == "units"
                        if ~ismember(val, ["m-kg", "ft-slugs"])
                            
                            % Invalid input, should not change the value
                            warning("Invalid input for 'units' " + ...
                                "argument\nValid inputs are <'m-kg'" + ...
                                ", 'ft-slugs'>\nDefault is 'ft-slugs'");
                            obj.units = current_val;
                        else
                            obj.units = val;
                            new_units = val;
                            SolveUnits(new_units);
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
        function obj = Solve(obj, var_name)
            filename_equations = append(pwd, "\permutations.mat");
            equations = load(filename_equations, var_name);
            equations = equations.(var_name)';

            %% From equations, get required variable sets
            required_var_sets = Aircraft.GetRequired_Vars(equations);
            % Get master_var_list for loading more equations
            unique_var_list = unique([required_var_sets{:}])';
            num_unique_vars = length(unique_var_list);

            %% Initialize required variable references
            loaded_var_names = strings(1);
            for i_var = 1:num_unique_vars
                this_var_name = unique_var_list(i_var);
                val = obj.(this_var_name);

                eval(append(this_var_name, " = val;"));
                loaded_var_names(i_var) = this_var_name;
            end

            % Remove the variable that this call of Solve() was for in the
            %   first place
            unique_var_list = unique_var_list(unique_var_list ~= var_name);
            unique_var_list_cell = cellstr(unique_var_list);
            num_vars_major = length(unique_var_list);

            % Load other vars' equations - redefine equations
            equations_master = load(filename_equations, unique_var_list_cell{:});

            for i_var_major = 1:num_vars_major
                var_name_major = unique_var_list(i_var_major);
                equations = equations_master.(var_name_major);
                num_equations = length(equations);

                required_var_sets = Aircraft.GetRequired_Vars(equations);

                for i_equation = 1:num_equations
                    var_set = required_var_sets{i_equation};
                    num_vars = length(var_set);

                    for i_var_minor = 1:num_vars
                        var_name_minor = var_set(i_var_minor);
                        if ~exist(var_name_minor, "var")
                            val = obj.(var_name_minor);
                            eval(append(var_name_minor, " = val;"));

                            if ~ismember(var_name_minor, loaded_var_names)
                                next_var_index = length(loaded_var_names) + 1;
                                loaded_var_names(next_var_index) = var_name_minor;
                            end
                        end
                    end
                end
            end
            loaded_var_names = loaded_var_names';

            %% Checks if any equations can be solved
            for i_var_major = 1:num_vars_major
                var_name_major = unique_var_list(i_var_major);
                equations = equations_master.(var_name_major);
                num_equations = length(equations);

                required_var_sets = Aircraft.GetRequired_Vars(equations);

                for i_equation = 1:num_equations
                    var_set = required_var_sets{i_equation};

                    % Removes name of variable we're trying to solve for
                    %   from the list of those we're checking the values of
                    var_set = var_set(var_set ~= var_name_major);

                    if ~any(cellfun(@(name) isempty(obj.(name)), var_set))
                        equation = equations(i_equation);
                        eval(equation);
                    end
                end
            end

            % Assign all non-empty variables that aren't what was
            %   originally fed into Solve() to matching properties of obj
            num_loaded_vars = length(loaded_var_names);

            for i = 1:num_loaded_vars
                var_name = loaded_var_names(i);
                val = eval(var_name);
                 if ~isempty(val)
                    obj.(var_name) = val;
                 end
            end
            return;
        end

        % Subsequently calls SolveFlightCondition() because geometry
        %   changing changes the flight condition
        function obj = SolveGeometry(obj)
            return;
        end

        function obj = SolveFlightCondition(obj)
            return;
        end

        function obj = SolveUnits(obj)
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

            % Implement later as option for user to check something's
            %   solveability. Default should NOT show though, since this
            %   may get used in Solve() to go back and see if things become
            %   solevable *while* Solve() is running
            %% Prints out unknown required variables preventing the solve
            % warning("Solve_: insufficient known variables to " + ...
            %     "solve for %s", var_name);
            % fprintf("Unknown variables:\n")
            % for i_equation = 1:num_equations
            %     var_set = required_var_sets{i_equation};
            %     num_vars = length(var_set);
            % 
            %     for i_var = 1:num_vars
            %         var_name = var_set{i_var};
            %         var = eval(var_name);
            %         if isempty(var)
            %             fprintf("%s\n", var_name);
            %         end
            %     end
            % 
            %     % If at the *end* of a var_set but not in the *last*
            %     %   var_set, print "or" to denote the end of a grouped set
            %     %   of required variables
            %     if i_var == num_vars
            %         if i_equation ~= num_equations
            %             fprintf("--------or--------\n");
            %         else
            %             fprintf("------------------\n");
            %         end
            %     end
            % end

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