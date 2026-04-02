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
classdef Aircraft

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
                        warning(sprintf("Invalid input for 'units' " + ...
                            "argument\nValid inputs are <'m-kg', " + ...
                            "'ft-slugs'>\nDefault is 'ft-slugs'"));
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

        %% Getters
		function units = Get_units(obj)
			units = obj.units.value;
			return;
		end

		function C_L = Get_C_L(obj)
			C_L = obj.C_L.value;
			return;
		end

		function C_L_0 = Get_C_L_0(obj)
			C_L_0 = obj.C_L_0.value;
			return;
		end

		function C_L_alpha = Get_C_L_alpha(obj)
			C_L_alpha = obj.C_L_alpha.value;
			return;
		end

		function C_L_delta_e = Get_C_L_delta_e(obj)
			C_L_delta_e = obj.C_L_delta_e.value;
			return;
		end

		function C_L_q = Get_C_L_q(obj)
			C_L_q = obj.C_L_q.value;
			return;
		end

		function C_L_0_prime = Get_C_L_0_prime(obj)
			C_L_0_prime = obj.C_L_0_prime.value;
			return;
		end

		function C_M = Get_C_M(obj)
			C_M = obj.C_M.value;
			return;
		end

		function C_M_0 = Get_C_M_0(obj)
			C_M_0 = obj.C_M_0.value;
			return;
		end

		function C_M_alpha = Get_C_M_alpha(obj)
			C_M_alpha = obj.C_M_alpha.value;
			return;
		end

		function C_M_delta_e = Get_C_M_delta_e(obj)
			C_M_delta_e = obj.C_M_delta_e.value;
			return;
		end

		function C_M_q = Get_C_M_q(obj)
			C_M_q = obj.C_M_q.value;
			return;
		end

		function C_M_0_prime = Get_C_M_0_prime(obj)
			C_M_0_prime = obj.C_M_0_prime.value;
			return;
		end

		function C_M_0_p = Get_C_M_0_p(obj)
			C_M_0_p = obj.C_M_0_p.value;
			return;
		end

		function C_M_0_f = Get_C_M_0_f(obj)
			C_M_0_f = obj.C_M_0_f.value;
			return;
		end

		function C_M_alpha_p = Get_C_M_alpha_p(obj)
			C_M_alpha_p = obj.C_M_alpha_p.value;
			return;
		end

		function C_M_alpha_f = Get_C_M_alpha_f(obj)
			C_M_alpha_f = obj.C_M_alpha_f.value;
			return;
		end

		function C_y = Get_C_y(obj)
			C_y = obj.C_y.value;
			return;
		end

		function C_y_beta = Get_C_y_beta(obj)
			C_y_beta = obj.C_y_beta.value;
			return;
		end

		function C_y_delta_r = Get_C_y_delta_r(obj)
			C_y_delta_r = obj.C_y_delta_r.value;
			return;
		end

		function C_y_r = Get_C_y_r(obj)
			C_y_r = obj.C_y_r.value;
			return;
		end

		function C_n = Get_C_n(obj)
			C_n = obj.C_n.value;
			return;
		end

		function C_n_beta = Get_C_n_beta(obj)
			C_n_beta = obj.C_n_beta.value;
			return;
		end

		function C_n_delta_r = Get_C_n_delta_r(obj)
			C_n_delta_r = obj.C_n_delta_r.value;
			return;
		end

		function C_n_delta_a = Get_C_n_delta_a(obj)
			C_n_delta_a = obj.C_n_delta_a.value;
			return;
		end

		function C_n_r = Get_C_n_r(obj)
			C_n_r = obj.C_n_r.value;
			return;
		end

		function C_n_sigma = Get_C_n_sigma(obj)
			C_n_sigma = obj.C_n_sigma.value;
			return;
		end

		function C_l = Get_C_l(obj)
			C_l = obj.C_l.value;
			return;
		end

		function C_l_beta_w = Get_C_l_beta_w(obj)
			C_l_beta_w = obj.C_l_beta_w.value;
			return;
		end

		function C_l_beta_f = Get_C_l_beta_f(obj)
			C_l_beta_f = obj.C_l_beta_f.value;
			return;
		end

		function C_l_beta_d = Get_C_l_beta_d(obj)
			C_l_beta_d = obj.C_l_beta_d.value;
			return;
		end

		function C_l_beta_s = Get_C_l_beta_s(obj)
			C_l_beta_s = obj.C_l_beta_s.value;
			return;
		end

		function C_l_delta_r = Get_C_l_delta_r(obj)
			C_l_delta_r = obj.C_l_delta_r.value;
			return;
		end

		function C_l_delta_a = Get_C_l_delta_a(obj)
			C_l_delta_a = obj.C_l_delta_a.value;
			return;
		end

		function C_l_r = Get_C_l_r(obj)
			C_l_r = obj.C_l_r.value;
			return;
		end

		function C_l_p = Get_C_l_p(obj)
			C_l_p = obj.C_l_p.value;
			return;
		end

		function eta = Get_eta(obj)
			eta = obj.eta.value;
			return;
		end

		function eta_1 = Get_eta_1(obj)
			eta_1 = obj.eta_1.value;
			return;
		end

		function eta_2 = Get_eta_2(obj)
			eta_2 = obj.eta_2.value;
			return;
		end

		function C_w = Get_C_w(obj)
			C_w = obj.C_w.value;
			return;
		end

		function n = Get_n(obj)
			n = obj.n.value;
			return;
		end

		function mu = Get_mu(obj)
			mu = obj.mu.value;
			return;
		end

		function nu = Get_nu(obj)
			nu = obj.nu.value;
			return;
		end

		function beta = Get_beta(obj)
			beta = obj.beta.value;
			return;
		end

		function sigma_beta = Get_sigma_beta(obj)
			sigma_beta = obj.sigma_beta.value;
			return;
		end

		function sigma_0 = Get_sigma_0(obj)
			sigma_0 = obj.sigma_0.value;
			return;
		end

		function phi = Get_phi(obj)
			phi = obj.phi.value;
			return;
		end

		function theta = Get_theta(obj)
			theta = obj.theta.value;
			return;
		end

		function psi = Get_psi(obj)
			psi = obj.psi.value;
			return;
		end

		function delta_a = Get_delta_a(obj)
			delta_a = obj.delta_a.value;
			return;
		end

		function delta_e = Get_delta_e(obj)
			delta_e = obj.delta_e.value;
			return;
		end

		function delta_r = Get_delta_r(obj)
			delta_r = obj.delta_r.value;
			return;
		end

		function p_i = Get_p_i(obj)
			p_i = obj.p_i.value;
			return;
		end

		function q_i = Get_q_i(obj)
			q_i = obj.q_i.value;
			return;
		end

		function r_i = Get_r_i(obj)
			r_i = obj.r_i.value;
			return;
		end

		function p_i_dot = Get_p_i_dot(obj)
			p_i_dot = obj.p_i_dot.value;
			return;
		end

		function q_i_dot = Get_q_i_dot(obj)
			q_i_dot = obj.q_i_dot.value;
			return;
		end

		function r_i_dot = Get_r_i_dot(obj)
			r_i_dot = obj.r_i_dot.value;
			return;
		end

		function p_b = Get_p_b(obj)
			p_b = obj.p_b.value;
			return;
		end

		function q_b = Get_q_b(obj)
			q_b = obj.q_b.value;
			return;
		end

		function r_b = Get_r_b(obj)
			r_b = obj.r_b.value;
			return;
		end

		function p_b_dot = Get_p_b_dot(obj)
			p_b_dot = obj.p_b_dot.value;
			return;
		end

		function q_b_dot = Get_q_b_dot(obj)
			q_b_dot = obj.q_b_dot.value;
			return;
		end

		function r_b_dot = Get_r_b_dot(obj)
			r_b_dot = obj.r_b_dot.value;
			return;
		end

		function u = Get_u(obj)
			u = obj.u.value;
			return;
		end

		function v = Get_v(obj)
			v = obj.v.value;
			return;
		end

		function w = Get_w(obj)
			w = obj.w.value;
			return;
		end

		function u_dot = Get_u_dot(obj)
			u_dot = obj.u_dot.value;
			return;
		end

		function v_dot = Get_v_dot(obj)
			v_dot = obj.v_dot.value;
			return;
		end

		function w_dot = Get_w_dot(obj)
			w_dot = obj.w_dot.value;
			return;
		end

		function W = Get_W(obj)
			W = obj.W.value;
			return;
		end

		function m = Get_m(obj)
			m = obj.m.value;
			return;
		end

		function I_xx = Get_I_xx(obj)
			I_xx = obj.I_xx.value;
			return;
		end

		function I_yy = Get_I_yy(obj)
			I_yy = obj.I_yy.value;
			return;
		end

		function I_zz = Get_I_zz(obj)
			I_zz = obj.I_zz.value;
			return;
		end

		function I_xy = Get_I_xy(obj)
			I_xy = obj.I_xy.value;
			return;
		end

		function I_xz = Get_I_xz(obj)
			I_xz = obj.I_xz.value;
			return;
		end

		function I_yz = Get_I_yz(obj)
			I_yz = obj.I_yz.value;
			return;
		end

		function sum_F = Get_sum_F(obj)
			sum_F = obj.sum_F.value;
			return;
		end

		function L = Get_L(obj)
			L = obj.L.value;
			return;
		end

		function D = Get_D(obj)
			D = obj.D.value;
			return;
		end

		function T = Get_T(obj)
			T = obj.T.value;
			return;
		end

		function sum_M = Get_sum_M(obj)
			sum_M = obj.sum_M.value;
			return;
		end

		function M = Get_M(obj)
			M = obj.M.value;
			return;
		end

		function N_T = Get_N_T(obj)
			N_T = obj.N_T.value;
			return;
		end

		function rho = Get_rho(obj)
			rho = obj.rho.value;
			return;
		end

		function g = Get_g(obj)
			g = obj.g.value;
			return;
		end

		function x_cg = Get_x_cg(obj)
			x_cg = obj.x_cg.value;
			return;
		end

		function x_bar_cg = Get_x_bar_cg(obj)
			x_bar_cg = obj.x_bar_cg.value;
			return;
		end

		function x_ac = Get_x_ac(obj)
			x_ac = obj.x_ac.value;
			return;
		end

		function x_bar_ac = Get_x_bar_ac(obj)
			x_bar_ac = obj.x_bar_ac.value;
			return;
		end

		function z_cg = Get_z_cg(obj)
			z_cg = obj.z_cg.value;
			return;
		end

		function SM = Get_SM(obj)
			SM = obj.SM.value;
			return;
		end

		function C_L_0_w = Get_C_L_0_w(obj)
			C_L_0_w = obj.C_L_0_w.value;
			return;
		end

		function C_L_alpha_w = Get_C_L_alpha_w(obj)
			C_L_alpha_w = obj.C_L_alpha_w.value;
			return;
		end

		function c_l_0_w = Get_c_l_0_w(obj)
			c_l_0_w = obj.c_l_0_w.value;
			return;
		end

		function c_l_alpha_w = Get_c_l_alpha_w(obj)
			c_l_alpha_w = obj.c_l_alpha_w.value;
			return;
		end

		function c_m_ac_w = Get_c_m_ac_w(obj)
			c_m_ac_w = obj.c_m_ac_w.value;
			return;
		end

		function a_w = Get_a_w(obj)
			a_w = obj.a_w.value;
			return;
		end

		function AR_w = Get_AR_w(obj)
			AR_w = obj.AR_w.value;
			return;
		end

		function lambda_w = Get_lambda_w(obj)
			lambda_w = obj.lambda_w.value;
			return;
		end

		function sweep_w = Get_sweep_w(obj)
			sweep_w = obj.sweep_w.value;
			return;
		end

		function gamma_w = Get_gamma_w(obj)
			gamma_w = obj.gamma_w.value;
			return;
		end

		function i_w = Get_i_w(obj)
			i_w = obj.i_w.value;
			return;
		end

		function alpha_w = Get_alpha_w(obj)
			alpha_w = obj.alpha_w.value;
			return;
		end

		function alpha_L_0_w = Get_alpha_L_0_w(obj)
			alpha_L_0_w = obj.alpha_L_0_w.value;
			return;
		end

		function alpha_w_trim = Get_alpha_w_trim(obj)
			alpha_w_trim = obj.alpha_w_trim.value;
			return;
		end

		function alpha_w_trim_delta_e_0 = Get_alpha_w_trim_delta_e_0(obj)
			alpha_w_trim_delta_e_0 = obj.alpha_w_trim_delta_e_0.value;
			return;
		end

		function q_bar_w = Get_q_bar_w(obj)
			q_bar_w = obj.q_bar_w.value;
			return;
		end

		function S_w = Get_S_w(obj)
			S_w = obj.S_w.value;
			return;
		end

		function b_w = Get_b_w(obj)
			b_w = obj.b_w.value;
			return;
		end

		function c_bar_w = Get_c_bar_w(obj)
			c_bar_w = obj.c_bar_w.value;
			return;
		end

		function c_r_w = Get_c_r_w(obj)
			c_r_w = obj.c_r_w.value;
			return;
		end

		function c_t_w = Get_c_t_w(obj)
			c_t_w = obj.c_t_w.value;
			return;
		end

		function c_w = Get_c_w(obj)
			c_w = obj.c_w.value;
			return;
		end

		function x_ac_w = Get_x_ac_w(obj)
			x_ac_w = obj.x_ac_w.value;
			return;
		end

		function x_bar_ac_w = Get_x_bar_ac_w(obj)
			x_bar_ac_w = obj.x_bar_ac_w.value;
			return;
		end

		function y_ac_w = Get_y_ac_w(obj)
			y_ac_w = obj.y_ac_w.value;
			return;
		end

		function C_L_0_t = Get_C_L_0_t(obj)
			C_L_0_t = obj.C_L_0_t.value;
			return;
		end

		function C_L_alpha_t = Get_C_L_alpha_t(obj)
			C_L_alpha_t = obj.C_L_alpha_t.value;
			return;
		end

		function C_L_i_t = Get_C_L_i_t(obj)
			C_L_i_t = obj.C_L_i_t.value;
			return;
		end

		function c_l_0_t = Get_c_l_0_t(obj)
			c_l_0_t = obj.c_l_0_t.value;
			return;
		end

		function c_l_alpha_t = Get_c_l_alpha_t(obj)
			c_l_alpha_t = obj.c_l_alpha_t.value;
			return;
		end

		function C_M_i_t = Get_C_M_i_t(obj)
			C_M_i_t = obj.C_M_i_t.value;
			return;
		end

		function c_m_ac_t = Get_c_m_ac_t(obj)
			c_m_ac_t = obj.c_m_ac_t.value;
			return;
		end

		function a_t = Get_a_t(obj)
			a_t = obj.a_t.value;
			return;
		end

		function AR_t = Get_AR_t(obj)
			AR_t = obj.AR_t.value;
			return;
		end

		function lambda_t = Get_lambda_t(obj)
			lambda_t = obj.lambda_t.value;
			return;
		end

		function sweep_t = Get_sweep_t(obj)
			sweep_t = obj.sweep_t.value;
			return;
		end

		function gamma_t = Get_gamma_t(obj)
			gamma_t = obj.gamma_t.value;
			return;
		end

		function i_t = Get_i_t(obj)
			i_t = obj.i_t.value;
			return;
		end

		function i_t_trim = Get_i_t_trim(obj)
			i_t_trim = obj.i_t_trim.value;
			return;
		end

		function alpha_t = Get_alpha_t(obj)
			alpha_t = obj.alpha_t.value;
			return;
		end

		function alpha_L_0_t = Get_alpha_L_0_t(obj)
			alpha_L_0_t = obj.alpha_L_0_t.value;
			return;
		end

		function alpha_t_trim = Get_alpha_t_trim(obj)
			alpha_t_trim = obj.alpha_t_trim.value;
			return;
		end

		function delta_e_trim = Get_delta_e_trim(obj)
			delta_e_trim = obj.delta_e_trim.value;
			return;
		end

		function epsilon_alpha_t = Get_epsilon_alpha_t(obj)
			epsilon_alpha_t = obj.epsilon_alpha_t.value;
			return;
		end

		function epsilon_0_t = Get_epsilon_0_t(obj)
			epsilon_0_t = obj.epsilon_0_t.value;
			return;
		end

		function q_bar_t = Get_q_bar_t(obj)
			q_bar_t = obj.q_bar_t.value;
			return;
		end

		function q_bar_f = Get_q_bar_f(obj)
			q_bar_f = obj.q_bar_f.value;
			return;
		end

		function S_t = Get_S_t(obj)
			S_t = obj.S_t.value;
			return;
		end

		function S_f = Get_S_f(obj)
			S_f = obj.S_f.value;
			return;
		end

		function b_t = Get_b_t(obj)
			b_t = obj.b_t.value;
			return;
		end

		function b_f = Get_b_f(obj)
			b_f = obj.b_f.value;
			return;
		end

		function c_bar_t = Get_c_bar_t(obj)
			c_bar_t = obj.c_bar_t.value;
			return;
		end

		function c_bar_f = Get_c_bar_f(obj)
			c_bar_f = obj.c_bar_f.value;
			return;
		end

		function c_r_t = Get_c_r_t(obj)
			c_r_t = obj.c_r_t.value;
			return;
		end

		function c_t_t = Get_c_t_t(obj)
			c_t_t = obj.c_t_t.value;
			return;
		end

		function c_r_f = Get_c_r_f(obj)
			c_r_f = obj.c_r_f.value;
			return;
		end

		function c_t_f = Get_c_t_f(obj)
			c_t_f = obj.c_t_f.value;
			return;
		end

		function c_t = Get_c_t(obj)
			c_t = obj.c_t.value;
			return;
		end

		function c_f = Get_c_f(obj)
			c_f = obj.c_f.value;
			return;
		end

		function x_ac_t = Get_x_ac_t(obj)
			x_ac_t = obj.x_ac_t.value;
			return;
		end

		function x_bar_ac_t = Get_x_bar_ac_t(obj)
			x_bar_ac_t = obj.x_bar_ac_t.value;
			return;
		end

		function y_ac_t = Get_y_ac_t(obj)
			y_ac_t = obj.y_ac_t.value;
			return;
		end

		function y_ac_f = Get_y_ac_f(obj)
			y_ac_f = obj.y_ac_f.value;
			return;
        end

        %% Setters
		function obj = Set_units(obj, val)
			obj.units.value = Aircraft.CheckInput("units", val);
			return;
		end

		function obj = Set_C_L(obj, val)
			obj.C_L.value = Aircraft.CheckInput("C_L", val);
			return;
		end

		function obj = Set_C_L_0(obj, val)
			obj.C_L_0.value = Aircraft.CheckInput("C_L_0", val);
			return;
		end

		function obj = Set_C_L_alpha(obj, val)
			obj.C_L_alpha.value = Aircraft.CheckInput("C_L_alpha", val);
			return;
		end

		function obj = Set_C_L_delta_e(obj, val)
			obj.C_L_delta_e.value = Aircraft.CheckInput("C_L_delta_e", val);
			return;
		end

		function obj = Set_C_L_q(obj, val)
			obj.C_L_q.value = Aircraft.CheckInput("C_L_q", val);
			return;
		end

		function obj = Set_C_L_0_prime(obj, val)
			obj.C_L_0_prime.value = Aircraft.CheckInput("C_L_0_prime", val);
			return;
		end

		function obj = Set_C_M(obj, val)
			obj.C_M.value = Aircraft.CheckInput("C_M", val);
			return;
		end

		function obj = Set_C_M_0(obj, val)
			obj.C_M_0.value = Aircraft.CheckInput("C_M_0", val);
			return;
		end

		function obj = Set_C_M_alpha(obj, val)
			obj.C_M_alpha.value = Aircraft.CheckInput("C_M_alpha", val);
			return;
		end

		function obj = Set_C_M_delta_e(obj, val)
			obj.C_M_delta_e.value = Aircraft.CheckInput("C_M_delta_e", val);
			return;
		end

		function obj = Set_C_M_q(obj, val)
			obj.C_M_q.value = Aircraft.CheckInput("C_M_q", val);
			return;
		end

		function obj = Set_C_M_0_prime(obj, val)
			obj.C_M_0_prime.value = Aircraft.CheckInput("C_M_0_prime", val);
			return;
		end

		function obj = Set_C_M_0_p(obj, val)
			obj.C_M_0_p.value = Aircraft.CheckInput("C_M_0_p", val);
			return;
		end

		function obj = Set_C_M_0_f(obj, val)
			obj.C_M_0_f.value = Aircraft.CheckInput("C_M_0_f", val);
			return;
		end

		function obj = Set_C_M_alpha_p(obj, val)
			obj.C_M_alpha_p.value = Aircraft.CheckInput("C_M_alpha_p", val);
			return;
		end

		function obj = Set_C_M_alpha_f(obj, val)
			obj.C_M_alpha_f.value = Aircraft.CheckInput("C_M_alpha_f", val);
			return;
		end

		function obj = Set_C_y(obj, val)
			obj.C_y.value = Aircraft.CheckInput("C_y", val);
			return;
		end

		function obj = Set_C_y_beta(obj, val)
			obj.C_y_beta.value = Aircraft.CheckInput("C_y_beta", val);
			return;
		end

		function obj = Set_C_y_delta_r(obj, val)
			obj.C_y_delta_r.value = Aircraft.CheckInput("C_y_delta_r", val);
			return;
		end

		function obj = Set_C_y_r(obj, val)
			obj.C_y_r.value = Aircraft.CheckInput("C_y_r", val);
			return;
		end

		function obj = Set_C_n(obj, val)
			obj.C_n.value = Aircraft.CheckInput("C_n", val);
			return;
		end

		function obj = Set_C_n_beta(obj, val)
			obj.C_n_beta.value = Aircraft.CheckInput("C_n_beta", val);
			return;
		end

		function obj = Set_C_n_delta_r(obj, val)
			obj.C_n_delta_r.value = Aircraft.CheckInput("C_n_delta_r", val);
			return;
		end

		function obj = Set_C_n_delta_a(obj, val)
			obj.C_n_delta_a.value = Aircraft.CheckInput("C_n_delta_a", val);
			return;
		end

		function obj = Set_C_n_r(obj, val)
			obj.C_n_r.value = Aircraft.CheckInput("C_n_r", val);
			return;
		end

		function obj = Set_C_n_sigma(obj, val)
			obj.C_n_sigma.value = Aircraft.CheckInput("C_n_sigma", val);
			return;
		end

		function obj = Set_C_l(obj, val)
			obj.C_l.value = Aircraft.CheckInput("C_l", val);
			return;
		end

		function obj = Set_C_l_beta_w(obj, val)
			obj.C_l_beta_w.value = Aircraft.CheckInput("C_l_beta_w", val);
			return;
		end

		function obj = Set_C_l_beta_f(obj, val)
			obj.C_l_beta_f.value = Aircraft.CheckInput("C_l_beta_f", val);
			return;
		end

		function obj = Set_C_l_beta_d(obj, val)
			obj.C_l_beta_d.value = Aircraft.CheckInput("C_l_beta_d", val);
			return;
		end

		function obj = Set_C_l_beta_s(obj, val)
			obj.C_l_beta_s.value = Aircraft.CheckInput("C_l_beta_s", val);
			return;
		end

		function obj = Set_C_l_delta_r(obj, val)
			obj.C_l_delta_r.value = Aircraft.CheckInput("C_l_delta_r", val);
			return;
		end

		function obj = Set_C_l_delta_a(obj, val)
			obj.C_l_delta_a.value = Aircraft.CheckInput("C_l_delta_a", val);
			return;
		end

		function obj = Set_C_l_r(obj, val)
			obj.C_l_r.value = Aircraft.CheckInput("C_l_r", val);
			return;
		end

		function obj = Set_C_l_p(obj, val)
			obj.C_l_p.value = Aircraft.CheckInput("C_l_p", val);
			return;
		end

		function obj = Set_eta(obj, val)
			obj.eta.value = Aircraft.CheckInput("eta", val);
			return;
		end

		function obj = Set_eta_1(obj, val)
			obj.eta_1.value = Aircraft.CheckInput("eta_1", val);
			return;
		end

		function obj = Set_eta_2(obj, val)
			obj.eta_2.value = Aircraft.CheckInput("eta_2", val);
			return;
		end

		function obj = Set_C_w(obj, val)
			obj.C_w.value = Aircraft.CheckInput("C_w", val);
			return;
		end

		function obj = Set_n(obj, val)
			obj.n.value = Aircraft.CheckInput("n", val);
			return;
		end

		function obj = Set_mu(obj, val)
			obj.mu.value = Aircraft.CheckInput("mu", val);
			return;
		end

		function obj = Set_nu(obj, val)
			obj.nu.value = Aircraft.CheckInput("nu", val);
			return;
		end

		function obj = Set_beta(obj, val)
			obj.beta.value = Aircraft.CheckInput("beta", val);
			return;
		end

		function obj = Set_sigma_beta(obj, val)
			obj.sigma_beta.value = Aircraft.CheckInput("sigma_beta", val);
			return;
		end

		function obj = Set_sigma_0(obj, val)
			obj.sigma_0.value = Aircraft.CheckInput("sigma_0", val);
			return;
		end

		function obj = Set_phi(obj, val)
			obj.phi.value = Aircraft.CheckInput("phi", val);
			return;
		end

		function obj = Set_theta(obj, val)
			obj.theta.value = Aircraft.CheckInput("theta", val);
			return;
		end

		function obj = Set_psi(obj, val)
			obj.psi.value = Aircraft.CheckInput("psi", val);
			return;
		end

		function obj = Set_delta_a(obj, val)
			obj.delta_a.value = Aircraft.CheckInput("delta_a", val);
			return;
		end

		function obj = Set_delta_e(obj, val)
			obj.delta_e.value = Aircraft.CheckInput("delta_e", val);
			return;
		end

		function obj = Set_delta_r(obj, val)
			obj.delta_r.value = Aircraft.CheckInput("delta_r", val);
			return;
		end

		function obj = Set_p_i(obj, val)
			obj.p_i.value = Aircraft.CheckInput("p_i", val);
			return;
		end

		function obj = Set_q_i(obj, val)
			obj.q_i.value = Aircraft.CheckInput("q_i", val);
			return;
		end

		function obj = Set_r_i(obj, val)
			obj.r_i.value = Aircraft.CheckInput("r_i", val);
			return;
		end

		function obj = Set_p_i_dot(obj, val)
			obj.p_i_dot.value = Aircraft.CheckInput("p_i_dot", val);
			return;
		end

		function obj = Set_q_i_dot(obj, val)
			obj.q_i_dot.value = Aircraft.CheckInput("q_i_dot", val);
			return;
		end

		function obj = Set_r_i_dot(obj, val)
			obj.r_i_dot.value = Aircraft.CheckInput("r_i_dot", val);
			return;
		end

		function obj = Set_p_b(obj, val)
			obj.p_b.value = Aircraft.CheckInput("p_b", val);
			return;
		end

		function obj = Set_q_b(obj, val)
			obj.q_b.value = Aircraft.CheckInput("q_b", val);
			return;
		end

		function obj = Set_r_b(obj, val)
			obj.r_b.value = Aircraft.CheckInput("r_b", val);
			return;
		end

		function obj = Set_p_b_dot(obj, val)
			obj.p_b_dot.value = Aircraft.CheckInput("p_b_dot", val);
			return;
		end

		function obj = Set_q_b_dot(obj, val)
			obj.q_b_dot.value = Aircraft.CheckInput("q_b_dot", val);
			return;
		end

		function obj = Set_r_b_dot(obj, val)
			obj.r_b_dot.value = Aircraft.CheckInput("r_b_dot", val);
			return;
		end

		function obj = Set_u(obj, val)
			obj.u.value = Aircraft.CheckInput("u", val);
			return;
		end

		function obj = Set_v(obj, val)
			obj.v.value = Aircraft.CheckInput("v", val);
			return;
		end

		function obj = Set_w(obj, val)
			obj.w.value = Aircraft.CheckInput("w", val);
			return;
		end

		function obj = Set_u_dot(obj, val)
			obj.u_dot.value = Aircraft.CheckInput("u_dot", val);
			return;
		end

		function obj = Set_v_dot(obj, val)
			obj.v_dot.value = Aircraft.CheckInput("v_dot", val);
			return;
		end

		function obj = Set_w_dot(obj, val)
			obj.w_dot.value = Aircraft.CheckInput("w_dot", val);
			return;
		end

		function obj = Set_W(obj, val)
			obj.W.value = Aircraft.CheckInput("W", val);
			return;
		end

		function obj = Set_m(obj, val)
			obj.m.value = Aircraft.CheckInput("m", val);
			return;
		end

		function obj = Set_I_xx(obj, val)
			obj.I_xx.value = Aircraft.CheckInput("I_xx", val);
			return;
		end

		function obj = Set_I_yy(obj, val)
			obj.I_yy.value = Aircraft.CheckInput("I_yy", val);
			return;
		end

		function obj = Set_I_zz(obj, val)
			obj.I_zz.value = Aircraft.CheckInput("I_zz", val);
			return;
		end

		function obj = Set_I_xy(obj, val)
			obj.I_xy.value = Aircraft.CheckInput("I_xy", val);
			return;
		end

		function obj = Set_I_xz(obj, val)
			obj.I_xz.value = Aircraft.CheckInput("I_xz", val);
			return;
		end

		function obj = Set_I_yz(obj, val)
			obj.I_yz.value = Aircraft.CheckInput("I_yz", val);
			return;
		end

		function obj = Set_sum_F(obj, val)
			obj.sum_F.value = Aircraft.CheckInput("sum_F", val);
			return;
		end

		function obj = Set_L(obj, val)
			obj.L.value = Aircraft.CheckInput("L", val);
			return;
		end

		function obj = Set_D(obj, val)
			obj.D.value = Aircraft.CheckInput("D", val);
			return;
		end

		function obj = Set_T(obj, val)
			obj.T.value = Aircraft.CheckInput("T", val);
			return;
		end

		function obj = Set_sum_M(obj, val)
			obj.sum_M.value = Aircraft.CheckInput("sum_M", val);
			return;
		end

		function obj = Set_M(obj, val)
			obj.M.value = Aircraft.CheckInput("M", val);
			return;
		end

		function obj = Set_N_T(obj, val)
			obj.N_T.value = Aircraft.CheckInput("N_T", val);
			return;
		end

		function obj = Set_rho(obj, val)
			obj.rho.value = Aircraft.CheckInput("rho", val);
			return;
		end

		function obj = Set_g(obj, val)
			obj.g.value = Aircraft.CheckInput("g", val);
			return;
		end

		function obj = Set_x_cg(obj, val)
			obj.x_cg.value = Aircraft.CheckInput("x_cg", val);
			return;
		end

		function obj = Set_x_bar_cg(obj, val)
			obj.x_bar_cg.value = Aircraft.CheckInput("x_bar_cg", val);
			return;
		end

		function obj = Set_x_ac(obj, val)
			obj.x_ac.value = Aircraft.CheckInput("x_ac", val);
			return;
		end

		function obj = Set_x_bar_ac(obj, val)
			obj.x_bar_ac.value = Aircraft.CheckInput("x_bar_ac", val);
			return;
		end

		function obj = Set_z_cg(obj, val)
			obj.z_cg.value = Aircraft.CheckInput("z_cg", val);
			return;
		end

		function obj = Set_SM(obj, val)
			obj.SM.value = Aircraft.CheckInput("SM", val);
			return;
		end

		function obj = Set_C_L_0_w(obj, val)
			obj.C_L_0_w.value = Aircraft.CheckInput("C_L_0_w", val);
			return;
		end

		function obj = Set_C_L_alpha_w(obj, val)
			obj.C_L_alpha_w.value = Aircraft.CheckInput("C_L_alpha_w", val);
			return;
		end

		function obj = Set_c_l_0_w(obj, val)
			obj.c_l_0_w.value = Aircraft.CheckInput("c_l_0_w", val);
			return;
		end

		function obj = Set_c_l_alpha_w(obj, val)
			obj.c_l_alpha_w.value = Aircraft.CheckInput("c_l_alpha_w", val);
			return;
		end

		function obj = Set_c_m_ac_w(obj, val)
			obj.c_m_ac_w.value = Aircraft.CheckInput("c_m_ac_w", val);
			return;
		end

		function obj = Set_a_w(obj, val)
			obj.a_w.value = Aircraft.CheckInput("a_w", val);
			return;
		end

		function obj = Set_AR_w(obj, val)
			obj.AR_w.value = Aircraft.CheckInput("AR_w", val);
			return;
		end

		function obj = Set_lambda_w(obj, val)
			obj.lambda_w.value = Aircraft.CheckInput("lambda_w", val);
			return;
		end

		function obj = Set_sweep_w(obj, val)
			obj.sweep_w.value = Aircraft.CheckInput("sweep_w", val);
			return;
		end

		function obj = Set_gamma_w(obj, val)
			obj.gamma_w.value = Aircraft.CheckInput("gamma_w", val);
			return;
		end

		function obj = Set_i_w(obj, val)
			obj.i_w.value = Aircraft.CheckInput("i_w", val);
			return;
		end

		function obj = Set_alpha_w(obj, val)
			obj.alpha_w.value = Aircraft.CheckInput("alpha_w", val);
			return;
		end

		function obj = Set_alpha_L_0_w(obj, val)
			obj.alpha_L_0_w.value = Aircraft.CheckInput("alpha_L_0_w", val);
			return;
		end

		function obj = Set_alpha_w_trim(obj, val)
			obj.alpha_w_trim.value = Aircraft.CheckInput("alpha_w_trim", val);
			return;
		end

		function obj = Set_alpha_w_trim_delta_e_0(obj, val)
			obj.alpha_w_trim_delta_e_0.value = Aircraft.CheckInput("alpha_w_trim_delta_e_0", val);
			return;
		end

		function obj = Set_q_bar_w(obj, val)
			obj.q_bar_w.value = Aircraft.CheckInput("q_bar_w", val);
			return;
		end

		function obj = Set_S_w(obj, val)
			obj.S_w.value = Aircraft.CheckInput("S_w", val);
			return;
		end

		function obj = Set_b_w(obj, val)
			obj.b_w.value = Aircraft.CheckInput("b_w", val);
			return;
		end

		function obj = Set_c_bar_w(obj, val)
			obj.c_bar_w.value = Aircraft.CheckInput("c_bar_w", val);
			return;
		end

		function obj = Set_c_r_w(obj, val)
			obj.c_r_w.value = Aircraft.CheckInput("c_r_w", val);
			return;
		end

		function obj = Set_c_t_w(obj, val)
			obj.c_t_w.value = Aircraft.CheckInput("c_t_w", val);
			return;
		end

		function obj = Set_c_w(obj, val)
			obj.c_w.value = Aircraft.CheckInput("c_w", val);
			return;
		end

		function obj = Set_x_ac_w(obj, val)
			obj.x_ac_w.value = Aircraft.CheckInput("x_ac_w", val);
			return;
		end

		function obj = Set_x_bar_ac_w(obj, val)
			obj.x_bar_ac_w.value = Aircraft.CheckInput("x_bar_ac_w", val);
			return;
		end

		function obj = Set_y_ac_w(obj, val)
			obj.y_ac_w.value = Aircraft.CheckInput("y_ac_w", val);
			return;
		end

		function obj = Set_C_L_0_t(obj, val)
			obj.C_L_0_t.value = Aircraft.CheckInput("C_L_0_t", val);
			return;
		end

		function obj = Set_C_L_alpha_t(obj, val)
			obj.C_L_alpha_t.value = Aircraft.CheckInput("C_L_alpha_t", val);
			return;
		end

		function obj = Set_C_L_i_t(obj, val)
			obj.C_L_i_t.value = Aircraft.CheckInput("C_L_i_t", val);
			return;
		end

		function obj = Set_c_l_0_t(obj, val)
			obj.c_l_0_t.value = Aircraft.CheckInput("c_l_0_t", val);
			return;
		end

		function obj = Set_c_l_alpha_t(obj, val)
			obj.c_l_alpha_t.value = Aircraft.CheckInput("c_l_alpha_t", val);
			return;
		end

		function obj = Set_C_M_i_t(obj, val)
			obj.C_M_i_t.value = Aircraft.CheckInput("C_M_i_t", val);
			return;
		end

		function obj = Set_c_m_ac_t(obj, val)
			obj.c_m_ac_t.value = Aircraft.CheckInput("c_m_ac_t", val);
			return;
		end

		function obj = Set_a_t(obj, val)
			obj.a_t.value = Aircraft.CheckInput("a_t", val);
			return;
		end

		function obj = Set_AR_t(obj, val)
			obj.AR_t.value = Aircraft.CheckInput("AR_t", val);
			return;
		end

		function obj = Set_lambda_t(obj, val)
			obj.lambda_t.value = Aircraft.CheckInput("lambda_t", val);
			return;
		end

		function obj = Set_sweep_t(obj, val)
			obj.sweep_t.value = Aircraft.CheckInput("sweep_t", val);
			return;
		end

		function obj = Set_gamma_t(obj, val)
			obj.gamma_t.value = Aircraft.CheckInput("gamma_t", val);
			return;
		end

		function obj = Set_i_t(obj, val)
			obj.i_t.value = Aircraft.CheckInput("i_t", val);
			return;
		end

		function obj = Set_i_t_trim(obj, val)
			obj.i_t_trim.value = Aircraft.CheckInput("i_t_trim", val);
			return;
		end

		function obj = Set_alpha_t(obj, val)
			obj.alpha_t.value = Aircraft.CheckInput("alpha_t", val);
			return;
		end

		function obj = Set_alpha_L_0_t(obj, val)
			obj.alpha_L_0_t.value = Aircraft.CheckInput("alpha_L_0_t", val);
			return;
		end

		function obj = Set_alpha_t_trim(obj, val)
			obj.alpha_t_trim.value = Aircraft.CheckInput("alpha_t_trim", val);
			return;
		end

		function obj = Set_delta_e_trim(obj, val)
			obj.delta_e_trim.value = Aircraft.CheckInput("delta_e_trim", val);
			return;
		end

		function obj = Set_epsilon_alpha_t(obj, val)
			obj.epsilon_alpha_t.value = Aircraft.CheckInput("epsilon_alpha_t", val);
			return;
		end

		function obj = Set_epsilon_0_t(obj, val)
			obj.epsilon_0_t.value = Aircraft.CheckInput("epsilon_0_t", val);
			return;
		end

		function obj = Set_q_bar_t(obj, val)
			obj.q_bar_t.value = Aircraft.CheckInput("q_bar_t", val);
			return;
		end

		function obj = Set_q_bar_f(obj, val)
			obj.q_bar_f.value = Aircraft.CheckInput("q_bar_f", val);
			return;
		end

		function obj = Set_S_t(obj, val)
			obj.S_t.value = Aircraft.CheckInput("S_t", val);
			return;
		end

		function obj = Set_S_f(obj, val)
			obj.S_f.value = Aircraft.CheckInput("S_f", val);
			return;
		end

		function obj = Set_b_t(obj, val)
			obj.b_t.value = Aircraft.CheckInput("b_t", val);
			return;
		end

		function obj = Set_b_f(obj, val)
			obj.b_f.value = Aircraft.CheckInput("b_f", val);
			return;
		end

		function obj = Set_c_bar_t(obj, val)
			obj.c_bar_t.value = Aircraft.CheckInput("c_bar_t", val);
			return;
		end

		function obj = Set_c_bar_f(obj, val)
			obj.c_bar_f.value = Aircraft.CheckInput("c_bar_f", val);
			return;
		end

		function obj = Set_c_r_t(obj, val)
			obj.c_r_t.value = Aircraft.CheckInput("c_r_t", val);
			return;
		end

		function obj = Set_c_t_t(obj, val)
			obj.c_t_t.value = Aircraft.CheckInput("c_t_t", val);
			return;
		end

		function obj = Set_c_r_f(obj, val)
			obj.c_r_f.value = Aircraft.CheckInput("c_r_f", val);
			return;
		end

		function obj = Set_c_t_f(obj, val)
			obj.c_t_f.value = Aircraft.CheckInput("c_t_f", val);
			return;
		end

		function obj = Set_c_t(obj, val)
			obj.c_t.value = Aircraft.CheckInput("c_t", val);
			return;
		end

		function obj = Set_c_f(obj, val)
			obj.c_f.value = Aircraft.CheckInput("c_f", val);
			return;
		end

		function obj = Set_x_ac_t(obj, val)
			obj.x_ac_t.value = Aircraft.CheckInput("x_ac_t", val);
			return;
		end

		function obj = Set_x_bar_ac_t(obj, val)
			obj.x_bar_ac_t.value = Aircraft.CheckInput("x_bar_ac_t", val);
			return;
		end

		function obj = Set_y_ac_t(obj, val)
			obj.y_ac_t.value = Aircraft.CheckInput("y_ac_t", val);
			return;
		end

		function obj = Set_y_ac_f(obj, val)
			obj.y_ac_f.value = Aircraft.CheckInput("y_ac_f", val);
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