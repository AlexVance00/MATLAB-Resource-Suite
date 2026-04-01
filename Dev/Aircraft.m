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

        %% Aircraft
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

        eta = [];
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
        delta_a = [];
        delta_e = [];
        delta_r = [];

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

        % Angles
        i_w = [];
        alpha_w = [];
        alpha_L_0_w = [];
        alpha_w_trim = [];
        alpha_w_trim_delta_e_0 = [];

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

        %% Tail
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

        % Angles
        i_t = [];
        i_t_trim = [];
        alpha_t = [];
        alpha_L_0_t = [];
        alpha_t_trim = [];
        delta_e_trim = [];
        epsilon_alpha_t = [];
        epsilon_0_t = [];

        % Flight conditions
        q_bar_t = [];
        q_bar_f = [];

        % Geometry
        S_t = [];
        S_f = [];
        b_t = [];
        b_f = [];
        c_bar_t = [];
        c_bar_f = [];
        c_r_t = [];
        c_t_t = [];
        c_r_f = [];
        c_t_f = [];
        c_t = [];
        c_f = [];
        
        x_ac_t = [];
        x_bar_ac_t = [];
        y_ac_t = [];
        y_ac_f = [];
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
            
            if ismember("units", arg_names)
                if args.units ~= "m-kg" && args.units ~= "ft-slugs"
                    error(sprintf("Invalid input for 'units' " + ...
                        "argument\nValid inputs are <'m-kg', " + ...
                        "'ft-slugs'>\nDefault is 'ft-slugs'"));
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
			units = obj.units;
			return;
		end

		function C_L = Get_C_L(obj)
			C_L = obj.C_L;
			return;
		end

		function C_L_0 = Get_C_L_0(obj)
			C_L_0 = obj.C_L_0;
			return;
		end

		function C_L_alpha = Get_C_L_alpha(obj)
			C_L_alpha = obj.C_L_alpha;
			return;
		end

		function C_L_delta_e = Get_C_L_delta_e(obj)
			C_L_delta_e = obj.C_L_delta_e;
			return;
		end

		function C_L_q = Get_C_L_q(obj)
			C_L_q = obj.C_L_q;
			return;
		end

		function C_L_0_prime = Get_C_L_0_prime(obj)
			C_L_0_prime = obj.C_L_0_prime;
			return;
		end

		function C_M = Get_C_M(obj)
			C_M = obj.C_M;
			return;
		end

		function C_M_0 = Get_C_M_0(obj)
			C_M_0 = obj.C_M_0;
			return;
		end

		function C_M_alpha = Get_C_M_alpha(obj)
			C_M_alpha = obj.C_M_alpha;
			return;
		end

		function C_M_delta_e = Get_C_M_delta_e(obj)
			C_M_delta_e = obj.C_M_delta_e;
			return;
		end

		function C_M_q = Get_C_M_q(obj)
			C_M_q = obj.C_M_q;
			return;
		end

		function C_M_0_prime = Get_C_M_0_prime(obj)
			C_M_0_prime = obj.C_M_0_prime;
			return;
		end

		function C_M_0_p = Get_C_M_0_p(obj)
			C_M_0_p = obj.C_M_0_p;
			return;
		end

		function C_M_0_f = Get_C_M_0_f(obj)
			C_M_0_f = obj.C_M_0_f;
			return;
		end

		function C_M_alpha_p = Get_C_M_alpha_p(obj)
			C_M_alpha_p = obj.C_M_alpha_p;
			return;
		end

		function C_M_alpha_f = Get_C_M_alpha_f(obj)
			C_M_alpha_f = obj.C_M_alpha_f;
			return;
		end

		function C_y = Get_C_y(obj)
			C_y = obj.C_y;
			return;
		end

		function C_y_beta = Get_C_y_beta(obj)
			C_y_beta = obj.C_y_beta;
			return;
		end

		function C_y_delta_r = Get_C_y_delta_r(obj)
			C_y_delta_r = obj.C_y_delta_r;
			return;
		end

		function C_y_r = Get_C_y_r(obj)
			C_y_r = obj.C_y_r;
			return;
		end

		function C_n = Get_C_n(obj)
			C_n = obj.C_n;
			return;
		end

		function C_n_beta = Get_C_n_beta(obj)
			C_n_beta = obj.C_n_beta;
			return;
		end

		function C_n_delta_r = Get_C_n_delta_r(obj)
			C_n_delta_r = obj.C_n_delta_r;
			return;
		end

		function C_n_delta_a = Get_C_n_delta_a(obj)
			C_n_delta_a = obj.C_n_delta_a;
			return;
		end

		function C_n_r = Get_C_n_r(obj)
			C_n_r = obj.C_n_r;
			return;
		end

		function C_n_sigma = Get_C_n_sigma(obj)
			C_n_sigma = obj.C_n_sigma;
			return;
		end

		function C_l = Get_C_l(obj)
			C_l = obj.C_l;
			return;
		end

		function C_l_beta_w = Get_C_l_beta_w(obj)
			C_l_beta_w = obj.C_l_beta_w;
			return;
		end

		function C_l_beta_f = Get_C_l_beta_f(obj)
			C_l_beta_f = obj.C_l_beta_f;
			return;
		end

		function C_l_beta_d = Get_C_l_beta_d(obj)
			C_l_beta_d = obj.C_l_beta_d;
			return;
		end

		function C_l_beta_s = Get_C_l_beta_s(obj)
			C_l_beta_s = obj.C_l_beta_s;
			return;
		end

		function C_l_delta_r = Get_C_l_delta_r(obj)
			C_l_delta_r = obj.C_l_delta_r;
			return;
		end

		function C_l_delta_a = Get_C_l_delta_a(obj)
			C_l_delta_a = obj.C_l_delta_a;
			return;
		end

		function C_l_r = Get_C_l_r(obj)
			C_l_r = obj.C_l_r;
			return;
		end

		function C_l_p = Get_C_l_p(obj)
			C_l_p = obj.C_l_p;
			return;
		end

		function eta = Get_eta(obj)
			eta = obj.eta;
			return;
		end

		function eta_1 = Get_eta_1(obj)
			eta_1 = obj.eta_1;
			return;
		end

		function eta_2 = Get_eta_2(obj)
			eta_2 = obj.eta_2;
			return;
		end

		function C_w = Get_C_w(obj)
			C_w = obj.C_w;
			return;
		end

		function n = Get_n(obj)
			n = obj.n;
			return;
		end

		function mu = Get_mu(obj)
			mu = obj.mu;
			return;
		end

		function nu = Get_nu(obj)
			nu = obj.nu;
			return;
		end

		function beta = Get_beta(obj)
			beta = obj.beta;
			return;
		end

		function sigma_beta = Get_sigma_beta(obj)
			sigma_beta = obj.sigma_beta;
			return;
		end

		function sigma_0 = Get_sigma_0(obj)
			sigma_0 = obj.sigma_0;
			return;
		end

		function phi = Get_phi(obj)
			phi = obj.phi;
			return;
		end

		function theta = Get_theta(obj)
			theta = obj.theta;
			return;
		end

		function psi = Get_psi(obj)
			psi = obj.psi;
			return;
		end

		function delta_a = Get_delta_a(obj)
			delta_a = obj.delta_a;
			return;
		end

		function delta_e = Get_delta_e(obj)
			delta_e = obj.delta_e;
			return;
		end

		function delta_r = Get_delta_r(obj)
			delta_r = obj.delta_r;
			return;
		end

		function p_i = Get_p_i(obj)
			p_i = obj.p_i;
			return;
		end

		function q_i = Get_q_i(obj)
			q_i = obj.q_i;
			return;
		end

		function r_i = Get_r_i(obj)
			r_i = obj.r_i;
			return;
		end

		function p_i_dot = Get_p_i_dot(obj)
			p_i_dot = obj.p_i_dot;
			return;
		end

		function q_i_dot = Get_q_i_dot(obj)
			q_i_dot = obj.q_i_dot;
			return;
		end

		function r_i_dot = Get_r_i_dot(obj)
			r_i_dot = obj.r_i_dot;
			return;
		end

		function p_b = Get_p_b(obj)
			p_b = obj.p_b;
			return;
		end

		function q_b = Get_q_b(obj)
			q_b = obj.q_b;
			return;
		end

		function r_b = Get_r_b(obj)
			r_b = obj.r_b;
			return;
		end

		function p_b_dot = Get_p_b_dot(obj)
			p_b_dot = obj.p_b_dot;
			return;
		end

		function q_b_dot = Get_q_b_dot(obj)
			q_b_dot = obj.q_b_dot;
			return;
		end

		function r_b_dot = Get_r_b_dot(obj)
			r_b_dot = obj.r_b_dot;
			return;
		end

		function u = Get_u(obj)
			u = obj.u;
			return;
		end

		function v = Get_v(obj)
			v = obj.v;
			return;
		end

		function w = Get_w(obj)
			w = obj.w;
			return;
		end

		function u_dot = Get_u_dot(obj)
			u_dot = obj.u_dot;
			return;
		end

		function v_dot = Get_v_dot(obj)
			v_dot = obj.v_dot;
			return;
		end

		function w_dot = Get_w_dot(obj)
			w_dot = obj.w_dot;
			return;
		end

		function W = Get_W(obj)
			W = obj.W;
			return;
		end

		function m = Get_m(obj)
			m = obj.m;
			return;
		end

		function I_xx = Get_I_xx(obj)
			I_xx = obj.I_xx;
			return;
		end

		function I_yy = Get_I_yy(obj)
			I_yy = obj.I_yy;
			return;
		end

		function I_zz = Get_I_zz(obj)
			I_zz = obj.I_zz;
			return;
		end

		function I_xy = Get_I_xy(obj)
			I_xy = obj.I_xy;
			return;
		end

		function I_xz = Get_I_xz(obj)
			I_xz = obj.I_xz;
			return;
		end

		function I_yz = Get_I_yz(obj)
			I_yz = obj.I_yz;
			return;
		end

		function sum_F = Get_sum_F(obj)
			sum_F = obj.sum_F;
			return;
		end

		function L = Get_L(obj)
			L = obj.L;
			return;
		end

		function D = Get_D(obj)
			D = obj.D;
			return;
		end

		function T = Get_T(obj)
			T = obj.T;
			return;
		end

		function sum_M = Get_sum_M(obj)
			sum_M = obj.sum_M;
			return;
		end

		function M = Get_M(obj)
			M = obj.M;
			return;
		end

		function N_T = Get_N_T(obj)
			N_T = obj.N_T;
			return;
		end

		function rho = Get_rho(obj)
			rho = obj.rho;
			return;
		end

		function g = Get_g(obj)
			g = obj.g;
			return;
		end

		function x_cg = Get_x_cg(obj)
			x_cg = obj.x_cg;
			return;
		end

		function x_bar_cg = Get_x_bar_cg(obj)
			x_bar_cg = obj.x_bar_cg;
			return;
		end

		function x_ac = Get_x_ac(obj)
			x_ac = obj.x_ac;
			return;
		end

		function x_bar_ac = Get_x_bar_ac(obj)
			x_bar_ac = obj.x_bar_ac;
			return;
		end

		function z_cg = Get_z_cg(obj)
			z_cg = obj.z_cg;
			return;
		end

		function SM = Get_SM(obj)
			SM = obj.SM;
			return;
		end

		function C_L_0_w = Get_C_L_0_w(obj)
			C_L_0_w = obj.C_L_0_w;
			return;
		end

		function C_L_alpha_w = Get_C_L_alpha_w(obj)
			C_L_alpha_w = obj.C_L_alpha_w;
			return;
		end

		function c_l_0_w = Get_c_l_0_w(obj)
			c_l_0_w = obj.c_l_0_w;
			return;
		end

		function c_l_alpha_w = Get_c_l_alpha_w(obj)
			c_l_alpha_w = obj.c_l_alpha_w;
			return;
		end

		function c_m_ac_w = Get_c_m_ac_w(obj)
			c_m_ac_w = obj.c_m_ac_w;
			return;
		end

		function a_w = Get_a_w(obj)
			a_w = obj.a_w;
			return;
		end

		function AR_w = Get_AR_w(obj)
			AR_w = obj.AR_w;
			return;
		end

		function lambda_w = Get_lambda_w(obj)
			lambda_w = obj.lambda_w;
			return;
		end

		function sweep_w = Get_sweep_w(obj)
			sweep_w = obj.sweep_w;
			return;
		end

		function gamma_w = Get_gamma_w(obj)
			gamma_w = obj.gamma_w;
			return;
		end

		function i_w = Get_i_w(obj)
			i_w = obj.i_w;
			return;
		end

		function alpha_w = Get_alpha_w(obj)
			alpha_w = obj.alpha_w;
			return;
		end

		function alpha_L_0_w = Get_alpha_L_0_w(obj)
			alpha_L_0_w = obj.alpha_L_0_w;
			return;
		end

		function alpha_w_trim = Get_alpha_w_trim(obj)
			alpha_w_trim = obj.alpha_w_trim;
			return;
		end

		function alpha_w_trim_delta_e_0 = Get_alpha_w_trim_delta_e_0(obj)
			alpha_w_trim_delta_e_0 = obj.alpha_w_trim_delta_e_0;
			return;
		end

		function q_bar_w = Get_q_bar_w(obj)
			q_bar_w = obj.q_bar_w;
			return;
		end

		function S_w = Get_S_w(obj)
			S_w = obj.S_w;
			return;
		end

		function b_w = Get_b_w(obj)
			b_w = obj.b_w;
			return;
		end

		function c_bar_w = Get_c_bar_w(obj)
			c_bar_w = obj.c_bar_w;
			return;
		end

		function c_r_w = Get_c_r_w(obj)
			c_r_w = obj.c_r_w;
			return;
		end

		function c_t_w = Get_c_t_w(obj)
			c_t_w = obj.c_t_w;
			return;
		end

		function c_w = Get_c_w(obj)
			c_w = obj.c_w;
			return;
		end

		function x_ac_w = Get_x_ac_w(obj)
			x_ac_w = obj.x_ac_w;
			return;
		end

		function x_bar_ac_w = Get_x_bar_ac_w(obj)
			x_bar_ac_w = obj.x_bar_ac_w;
			return;
		end

		function y_ac_w = Get_y_ac_w(obj)
			y_ac_w = obj.y_ac_w;
			return;
		end

		function C_L_0_t = Get_C_L_0_t(obj)
			C_L_0_t = obj.C_L_0_t;
			return;
		end

		function C_L_alpha_t = Get_C_L_alpha_t(obj)
			C_L_alpha_t = obj.C_L_alpha_t;
			return;
		end

		function C_L_i_t = Get_C_L_i_t(obj)
			C_L_i_t = obj.C_L_i_t;
			return;
		end

		function c_l_0_t = Get_c_l_0_t(obj)
			c_l_0_t = obj.c_l_0_t;
			return;
		end

		function c_l_alpha_t = Get_c_l_alpha_t(obj)
			c_l_alpha_t = obj.c_l_alpha_t;
			return;
		end

		function C_M_i_t = Get_C_M_i_t(obj)
			C_M_i_t = obj.C_M_i_t;
			return;
		end

		function c_m_ac_t = Get_c_m_ac_t(obj)
			c_m_ac_t = obj.c_m_ac_t;
			return;
		end

		function a_t = Get_a_t(obj)
			a_t = obj.a_t;
			return;
		end

		function AR_t = Get_AR_t(obj)
			AR_t = obj.AR_t;
			return;
		end

		function lambda_t = Get_lambda_t(obj)
			lambda_t = obj.lambda_t;
			return;
		end

		function sweep_t = Get_sweep_t(obj)
			sweep_t = obj.sweep_t;
			return;
		end

		function gamma_t = Get_gamma_t(obj)
			gamma_t = obj.gamma_t;
			return;
		end

		function i_t = Get_i_t(obj)
			i_t = obj.i_t;
			return;
		end

		function i_t_trim = Get_i_t_trim(obj)
			i_t_trim = obj.i_t_trim;
			return;
		end

		function alpha_t = Get_alpha_t(obj)
			alpha_t = obj.alpha_t;
			return;
		end

		function alpha_L_0_t = Get_alpha_L_0_t(obj)
			alpha_L_0_t = obj.alpha_L_0_t;
			return;
		end

		function alpha_t_trim = Get_alpha_t_trim(obj)
			alpha_t_trim = obj.alpha_t_trim;
			return;
		end

		function delta_e_trim = Get_delta_e_trim(obj)
			delta_e_trim = obj.delta_e_trim;
			return;
		end

		function epsilon_alpha_t = Get_epsilon_alpha_t(obj)
			epsilon_alpha_t = obj.epsilon_alpha_t;
			return;
		end

		function epsilon_0_t = Get_epsilon_0_t(obj)
			epsilon_0_t = obj.epsilon_0_t;
			return;
		end

		function q_bar_t = Get_q_bar_t(obj)
			q_bar_t = obj.q_bar_t;
			return;
		end

		function q_bar_f = Get_q_bar_f(obj)
			q_bar_f = obj.q_bar_f;
			return;
		end

		function S_t = Get_S_t(obj)
			S_t = obj.S_t;
			return;
		end

		function S_f = Get_S_f(obj)
			S_f = obj.S_f;
			return;
		end

		function b_t = Get_b_t(obj)
			b_t = obj.b_t;
			return;
		end

		function b_f = Get_b_f(obj)
			b_f = obj.b_f;
			return;
		end

		function c_bar_t = Get_c_bar_t(obj)
			c_bar_t = obj.c_bar_t;
			return;
		end

		function c_bar_f = Get_c_bar_f(obj)
			c_bar_f = obj.c_bar_f;
			return;
		end

		function c_r_t = Get_c_r_t(obj)
			c_r_t = obj.c_r_t;
			return;
		end

		function c_t_t = Get_c_t_t(obj)
			c_t_t = obj.c_t_t;
			return;
		end

		function c_r_f = Get_c_r_f(obj)
			c_r_f = obj.c_r_f;
			return;
		end

		function c_t_f = Get_c_t_f(obj)
			c_t_f = obj.c_t_f;
			return;
		end

		function c_t = Get_c_t(obj)
			c_t = obj.c_t;
			return;
		end

		function c_f = Get_c_f(obj)
			c_f = obj.c_f;
			return;
		end

		function x_ac_t = Get_x_ac_t(obj)
			x_ac_t = obj.x_ac_t;
			return;
		end

		function x_bar_ac_t = Get_x_bar_ac_t(obj)
			x_bar_ac_t = obj.x_bar_ac_t;
			return;
		end

		function y_ac_t = Get_y_ac_t(obj)
			y_ac_t = obj.y_ac_t;
			return;
		end

		function y_ac_f = Get_y_ac_f(obj)
			y_ac_f = obj.y_ac_f;
			return;
		end

        %% Setters
		function obj = Set_units(obj, val)
			if class(val) == "double"
				obj.units = val;
			else
				warning("Could not set units to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_L(obj, val)
			if class(val) == "double"
				obj.C_L = val;
			else
				warning("Could not set C_L to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_L_0(obj, val)
			if class(val) == "double"
				obj.C_L_0 = val;
			else
				warning("Could not set C_L_0 to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_L_alpha(obj, val)
			if class(val) == "double"
				obj.C_L_alpha = val;
			else
				warning("Could not set C_L_alpha to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_L_delta_e(obj, val)
			if class(val) == "double"
				obj.C_L_delta_e = val;
			else
				warning("Could not set C_L_delta_e to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_L_q(obj, val)
			if class(val) == "double"
				obj.C_L_q = val;
			else
				warning("Could not set C_L_q to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_L_0_prime(obj, val)
			if class(val) == "double"
				obj.C_L_0_prime = val;
			else
				warning("Could not set C_L_0_prime to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_M(obj, val)
			if class(val) == "double"
				obj.C_M = val;
			else
				warning("Could not set C_M to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_M_0(obj, val)
			if class(val) == "double"
				obj.C_M_0 = val;
			else
				warning("Could not set C_M_0 to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_M_alpha(obj, val)
			if class(val) == "double"
				obj.C_M_alpha = val;
			else
				warning("Could not set C_M_alpha to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_M_delta_e(obj, val)
			if class(val) == "double"
				obj.C_M_delta_e = val;
			else
				warning("Could not set C_M_delta_e to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_M_q(obj, val)
			if class(val) == "double"
				obj.C_M_q = val;
			else
				warning("Could not set C_M_q to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_M_0_prime(obj, val)
			if class(val) == "double"
				obj.C_M_0_prime = val;
			else
				warning("Could not set C_M_0_prime to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_M_0_p(obj, val)
			if class(val) == "double"
				obj.C_M_0_p = val;
			else
				warning("Could not set C_M_0_p to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_M_0_f(obj, val)
			if class(val) == "double"
				obj.C_M_0_f = val;
			else
				warning("Could not set C_M_0_f to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_M_alpha_p(obj, val)
			if class(val) == "double"
				obj.C_M_alpha_p = val;
			else
				warning("Could not set C_M_alpha_p to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_M_alpha_f(obj, val)
			if class(val) == "double"
				obj.C_M_alpha_f = val;
			else
				warning("Could not set C_M_alpha_f to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_y(obj, val)
			if class(val) == "double"
				obj.C_y = val;
			else
				warning("Could not set C_y to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_y_beta(obj, val)
			if class(val) == "double"
				obj.C_y_beta = val;
			else
				warning("Could not set C_y_beta to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_y_delta_r(obj, val)
			if class(val) == "double"
				obj.C_y_delta_r = val;
			else
				warning("Could not set C_y_delta_r to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_y_r(obj, val)
			if class(val) == "double"
				obj.C_y_r = val;
			else
				warning("Could not set C_y_r to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_n(obj, val)
			if class(val) == "double"
				obj.C_n = val;
			else
				warning("Could not set C_n to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_n_beta(obj, val)
			if class(val) == "double"
				obj.C_n_beta = val;
			else
				warning("Could not set C_n_beta to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_n_delta_r(obj, val)
			if class(val) == "double"
				obj.C_n_delta_r = val;
			else
				warning("Could not set C_n_delta_r to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_n_delta_a(obj, val)
			if class(val) == "double"
				obj.C_n_delta_a = val;
			else
				warning("Could not set C_n_delta_a to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_n_r(obj, val)
			if class(val) == "double"
				obj.C_n_r = val;
			else
				warning("Could not set C_n_r to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_n_sigma(obj, val)
			if class(val) == "double"
				obj.C_n_sigma = val;
			else
				warning("Could not set C_n_sigma to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_l(obj, val)
			if class(val) == "double"
				obj.C_l = val;
			else
				warning("Could not set C_l to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_l_beta_w(obj, val)
			if class(val) == "double"
				obj.C_l_beta_w = val;
			else
				warning("Could not set C_l_beta_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_l_beta_f(obj, val)
			if class(val) == "double"
				obj.C_l_beta_f = val;
			else
				warning("Could not set C_l_beta_f to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_l_beta_d(obj, val)
			if class(val) == "double"
				obj.C_l_beta_d = val;
			else
				warning("Could not set C_l_beta_d to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_l_beta_s(obj, val)
			if class(val) == "double"
				obj.C_l_beta_s = val;
			else
				warning("Could not set C_l_beta_s to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_l_delta_r(obj, val)
			if class(val) == "double"
				obj.C_l_delta_r = val;
			else
				warning("Could not set C_l_delta_r to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_l_delta_a(obj, val)
			if class(val) == "double"
				obj.C_l_delta_a = val;
			else
				warning("Could not set C_l_delta_a to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_l_r(obj, val)
			if class(val) == "double"
				obj.C_l_r = val;
			else
				warning("Could not set C_l_r to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_l_p(obj, val)
			if class(val) == "double"
				obj.C_l_p = val;
			else
				warning("Could not set C_l_p to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_eta(obj, val)
			if class(val) == "double"
				obj.eta = val;
			else
				warning("Could not set eta to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_eta_1(obj, val)
			if class(val) == "double"
				obj.eta_1 = val;
			else
				warning("Could not set eta_1 to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_eta_2(obj, val)
			if class(val) == "double"
				obj.eta_2 = val;
			else
				warning("Could not set eta_2 to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_w(obj, val)
			if class(val) == "double"
				obj.C_w = val;
			else
				warning("Could not set C_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_n(obj, val)
			if class(val) == "double"
				obj.n = val;
			else
				warning("Could not set n to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_mu(obj, val)
			if class(val) == "double"
				obj.mu = val;
			else
				warning("Could not set mu to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_nu(obj, val)
			if class(val) == "double"
				obj.nu = val;
			else
				warning("Could not set nu to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_beta(obj, val)
			if class(val) == "double"
				obj.beta = val;
			else
				warning("Could not set beta to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_sigma_beta(obj, val)
			if class(val) == "double"
				obj.sigma_beta = val;
			else
				warning("Could not set sigma_beta to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_sigma_0(obj, val)
			if class(val) == "double"
				obj.sigma_0 = val;
			else
				warning("Could not set sigma_0 to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_phi(obj, val)
			if class(val) == "double"
				obj.phi = val;
			else
				warning("Could not set phi to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_theta(obj, val)
			if class(val) == "double"
				obj.theta = val;
			else
				warning("Could not set theta to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_psi(obj, val)
			if class(val) == "double"
				obj.psi = val;
			else
				warning("Could not set psi to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_delta_a(obj, val)
			if class(val) == "double"
				obj.delta_a = val;
			else
				warning("Could not set delta_a to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_delta_e(obj, val)
			if class(val) == "double"
				obj.delta_e = val;
			else
				warning("Could not set delta_e to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_delta_r(obj, val)
			if class(val) == "double"
				obj.delta_r = val;
			else
				warning("Could not set delta_r to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_p_i(obj, val)
			if class(val) == "double"
				obj.p_i = val;
			else
				warning("Could not set p_i to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_q_i(obj, val)
			if class(val) == "double"
				obj.q_i = val;
			else
				warning("Could not set q_i to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_r_i(obj, val)
			if class(val) == "double"
				obj.r_i = val;
			else
				warning("Could not set r_i to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_p_i_dot(obj, val)
			if class(val) == "double"
				obj.p_i_dot = val;
			else
				warning("Could not set p_i_dot to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_q_i_dot(obj, val)
			if class(val) == "double"
				obj.q_i_dot = val;
			else
				warning("Could not set q_i_dot to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_r_i_dot(obj, val)
			if class(val) == "double"
				obj.r_i_dot = val;
			else
				warning("Could not set r_i_dot to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_p_b(obj, val)
			if class(val) == "double"
				obj.p_b = val;
			else
				warning("Could not set p_b to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_q_b(obj, val)
			if class(val) == "double"
				obj.q_b = val;
			else
				warning("Could not set q_b to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_r_b(obj, val)
			if class(val) == "double"
				obj.r_b = val;
			else
				warning("Could not set r_b to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_p_b_dot(obj, val)
			if class(val) == "double"
				obj.p_b_dot = val;
			else
				warning("Could not set p_b_dot to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_q_b_dot(obj, val)
			if class(val) == "double"
				obj.q_b_dot = val;
			else
				warning("Could not set q_b_dot to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_r_b_dot(obj, val)
			if class(val) == "double"
				obj.r_b_dot = val;
			else
				warning("Could not set r_b_dot to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_u(obj, val)
			if class(val) == "double"
				obj.u = val;
			else
				warning("Could not set u to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_v(obj, val)
			if class(val) == "double"
				obj.v = val;
			else
				warning("Could not set v to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_w(obj, val)
			if class(val) == "double"
				obj.w = val;
			else
				warning("Could not set w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_u_dot(obj, val)
			if class(val) == "double"
				obj.u_dot = val;
			else
				warning("Could not set u_dot to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_v_dot(obj, val)
			if class(val) == "double"
				obj.v_dot = val;
			else
				warning("Could not set v_dot to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_w_dot(obj, val)
			if class(val) == "double"
				obj.w_dot = val;
			else
				warning("Could not set w_dot to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_W(obj, val)
			if class(val) == "double"
				obj.W = val;
			else
				warning("Could not set W to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_m(obj, val)
			if class(val) == "double"
				obj.m = val;
			else
				warning("Could not set m to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_I_xx(obj, val)
			if class(val) == "double"
				obj.I_xx = val;
			else
				warning("Could not set I_xx to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_I_yy(obj, val)
			if class(val) == "double"
				obj.I_yy = val;
			else
				warning("Could not set I_yy to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_I_zz(obj, val)
			if class(val) == "double"
				obj.I_zz = val;
			else
				warning("Could not set I_zz to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_I_xy(obj, val)
			if class(val) == "double"
				obj.I_xy = val;
			else
				warning("Could not set I_xy to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_I_xz(obj, val)
			if class(val) == "double"
				obj.I_xz = val;
			else
				warning("Could not set I_xz to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_I_yz(obj, val)
			if class(val) == "double"
				obj.I_yz = val;
			else
				warning("Could not set I_yz to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_sum_F(obj, val)
			if class(val) == "double"
				obj.sum_F = val;
			else
				warning("Could not set sum_F to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_L(obj, val)
			if class(val) == "double"
				obj.L = val;
			else
				warning("Could not set L to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_D(obj, val)
			if class(val) == "double"
				obj.D = val;
			else
				warning("Could not set D to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_T(obj, val)
			if class(val) == "double"
				obj.T = val;
			else
				warning("Could not set T to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_sum_M(obj, val)
			if class(val) == "double"
				obj.sum_M = val;
			else
				warning("Could not set sum_M to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_M(obj, val)
			if class(val) == "double"
				obj.M = val;
			else
				warning("Could not set M to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_N_T(obj, val)
			if class(val) == "double"
				obj.N_T = val;
			else
				warning("Could not set N_T to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_rho(obj, val)
			if class(val) == "double"
				obj.rho = val;
			else
				warning("Could not set rho to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_g(obj, val)
			if class(val) == "double"
				obj.g = val;
			else
				warning("Could not set g to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_x_cg(obj, val)
			if class(val) == "double"
				obj.x_cg = val;
			else
				warning("Could not set x_cg to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_x_bar_cg(obj, val)
			if class(val) == "double"
				obj.x_bar_cg = val;
			else
				warning("Could not set x_bar_cg to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_x_ac(obj, val)
			if class(val) == "double"
				obj.x_ac = val;
			else
				warning("Could not set x_ac to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_x_bar_ac(obj, val)
			if class(val) == "double"
				obj.x_bar_ac = val;
			else
				warning("Could not set x_bar_ac to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_z_cg(obj, val)
			if class(val) == "double"
				obj.z_cg = val;
			else
				warning("Could not set z_cg to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_SM(obj, val)
			if class(val) == "double"
				obj.SM = val;
			else
				warning("Could not set SM to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_L_0_w(obj, val)
			if class(val) == "double"
				obj.C_L_0_w = val;
			else
				warning("Could not set C_L_0_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_L_alpha_w(obj, val)
			if class(val) == "double"
				obj.C_L_alpha_w = val;
			else
				warning("Could not set C_L_alpha_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_l_0_w(obj, val)
			if class(val) == "double"
				obj.c_l_0_w = val;
			else
				warning("Could not set c_l_0_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_l_alpha_w(obj, val)
			if class(val) == "double"
				obj.c_l_alpha_w = val;
			else
				warning("Could not set c_l_alpha_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_m_ac_w(obj, val)
			if class(val) == "double"
				obj.c_m_ac_w = val;
			else
				warning("Could not set c_m_ac_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_a_w(obj, val)
			if class(val) == "double"
				obj.a_w = val;
			else
				warning("Could not set a_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_AR_w(obj, val)
			if class(val) == "double"
				obj.AR_w = val;
			else
				warning("Could not set AR_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_lambda_w(obj, val)
			if class(val) == "double"
				obj.lambda_w = val;
			else
				warning("Could not set lambda_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_sweep_w(obj, val)
			if class(val) == "double"
				obj.sweep_w = val;
			else
				warning("Could not set sweep_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_gamma_w(obj, val)
			if class(val) == "double"
				obj.gamma_w = val;
			else
				warning("Could not set gamma_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_i_w(obj, val)
			if class(val) == "double"
				obj.i_w = val;
			else
				warning("Could not set i_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_alpha_w(obj, val)
			if class(val) == "double"
				obj.alpha_w = val;
			else
				warning("Could not set alpha_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_alpha_L_0_w(obj, val)
			if class(val) == "double"
				obj.alpha_L_0_w = val;
			else
				warning("Could not set alpha_L_0_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_alpha_w_trim(obj, val)
			if class(val) == "double"
				obj.alpha_w_trim = val;
			else
				warning("Could not set alpha_w_trim to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_alpha_w_trim_delta_e_0(obj, val)
			if class(val) == "double"
				obj.alpha_w_trim_delta_e_0 = val;
			else
				warning("Could not set alpha_w_trim_delta_e_0 to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_q_bar_w(obj, val)
			if class(val) == "double"
				obj.q_bar_w = val;
			else
				warning("Could not set q_bar_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_S_w(obj, val)
			if class(val) == "double"
				obj.S_w = val;
			else
				warning("Could not set S_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_b_w(obj, val)
			if class(val) == "double"
				obj.b_w = val;
			else
				warning("Could not set b_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_bar_w(obj, val)
			if class(val) == "double"
				obj.c_bar_w = val;
			else
				warning("Could not set c_bar_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_r_w(obj, val)
			if class(val) == "double"
				obj.c_r_w = val;
			else
				warning("Could not set c_r_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_t_w(obj, val)
			if class(val) == "double"
				obj.c_t_w = val;
			else
				warning("Could not set c_t_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_w(obj, val)
			if class(val) == "double"
				obj.c_w = val;
			else
				warning("Could not set c_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_x_ac_w(obj, val)
			if class(val) == "double"
				obj.x_ac_w = val;
			else
				warning("Could not set x_ac_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_x_bar_ac_w(obj, val)
			if class(val) == "double"
				obj.x_bar_ac_w = val;
			else
				warning("Could not set x_bar_ac_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_y_ac_w(obj, val)
			if class(val) == "double"
				obj.y_ac_w = val;
			else
				warning("Could not set y_ac_w to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_L_0_t(obj, val)
			if class(val) == "double"
				obj.C_L_0_t = val;
			else
				warning("Could not set C_L_0_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_L_alpha_t(obj, val)
			if class(val) == "double"
				obj.C_L_alpha_t = val;
			else
				warning("Could not set C_L_alpha_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_L_i_t(obj, val)
			if class(val) == "double"
				obj.C_L_i_t = val;
			else
				warning("Could not set C_L_i_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_l_0_t(obj, val)
			if class(val) == "double"
				obj.c_l_0_t = val;
			else
				warning("Could not set c_l_0_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_l_alpha_t(obj, val)
			if class(val) == "double"
				obj.c_l_alpha_t = val;
			else
				warning("Could not set c_l_alpha_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_C_M_i_t(obj, val)
			if class(val) == "double"
				obj.C_M_i_t = val;
			else
				warning("Could not set C_M_i_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_m_ac_t(obj, val)
			if class(val) == "double"
				obj.c_m_ac_t = val;
			else
				warning("Could not set c_m_ac_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_a_t(obj, val)
			if class(val) == "double"
				obj.a_t = val;
			else
				warning("Could not set a_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_AR_t(obj, val)
			if class(val) == "double"
				obj.AR_t = val;
			else
				warning("Could not set AR_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_lambda_t(obj, val)
			if class(val) == "double"
				obj.lambda_t = val;
			else
				warning("Could not set lambda_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_sweep_t(obj, val)
			if class(val) == "double"
				obj.sweep_t = val;
			else
				warning("Could not set sweep_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_gamma_t(obj, val)
			if class(val) == "double"
				obj.gamma_t = val;
			else
				warning("Could not set gamma_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_i_t(obj, val)
			if class(val) == "double"
				obj.i_t = val;
			else
				warning("Could not set i_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_i_t_trim(obj, val)
			if class(val) == "double"
				obj.i_t_trim = val;
			else
				warning("Could not set i_t_trim to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_alpha_t(obj, val)
			if class(val) == "double"
				obj.alpha_t = val;
			else
				warning("Could not set alpha_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_alpha_L_0_t(obj, val)
			if class(val) == "double"
				obj.alpha_L_0_t = val;
			else
				warning("Could not set alpha_L_0_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_alpha_t_trim(obj, val)
			if class(val) == "double"
				obj.alpha_t_trim = val;
			else
				warning("Could not set alpha_t_trim to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_delta_e_trim(obj, val)
			if class(val) == "double"
				obj.delta_e_trim = val;
			else
				warning("Could not set delta_e_trim to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_epsilon_alpha_t(obj, val)
			if class(val) == "double"
				obj.epsilon_alpha_t = val;
			else
				warning("Could not set epsilon_alpha_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_epsilon_0_t(obj, val)
			if class(val) == "double"
				obj.epsilon_0_t = val;
			else
				warning("Could not set epsilon_0_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_q_bar_t(obj, val)
			if class(val) == "double"
				obj.q_bar_t = val;
			else
				warning("Could not set q_bar_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_q_bar_f(obj, val)
			if class(val) == "double"
				obj.q_bar_f = val;
			else
				warning("Could not set q_bar_f to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_S_t(obj, val)
			if class(val) == "double"
				obj.S_t = val;
			else
				warning("Could not set S_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_S_f(obj, val)
			if class(val) == "double"
				obj.S_f = val;
			else
				warning("Could not set S_f to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_b_t(obj, val)
			if class(val) == "double"
				obj.b_t = val;
			else
				warning("Could not set b_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_b_f(obj, val)
			if class(val) == "double"
				obj.b_f = val;
			else
				warning("Could not set b_f to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_bar_t(obj, val)
			if class(val) == "double"
				obj.c_bar_t = val;
			else
				warning("Could not set c_bar_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_bar_f(obj, val)
			if class(val) == "double"
				obj.c_bar_f = val;
			else
				warning("Could not set c_bar_f to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_r_t(obj, val)
			if class(val) == "double"
				obj.c_r_t = val;
			else
				warning("Could not set c_r_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_t_t(obj, val)
			if class(val) == "double"
				obj.c_t_t = val;
			else
				warning("Could not set c_t_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_r_f(obj, val)
			if class(val) == "double"
				obj.c_r_f = val;
			else
				warning("Could not set c_r_f to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_t_f(obj, val)
			if class(val) == "double"
				obj.c_t_f = val;
			else
				warning("Could not set c_t_f to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_t(obj, val)
			if class(val) == "double"
				obj.c_t = val;
			else
				warning("Could not set c_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_c_f(obj, val)
			if class(val) == "double"
				obj.c_f = val;
			else
				warning("Could not set c_f to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_x_ac_t(obj, val)
			if class(val) == "double"
				obj.x_ac_t = val;
			else
				warning("Could not set x_ac_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_x_bar_ac_t(obj, val)
			if class(val) == "double"
				obj.x_bar_ac_t = val;
			else
				warning("Could not set x_bar_ac_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_y_ac_t(obj, val)
			if class(val) == "double"
				obj.y_ac_t = val;
			else
				warning("Could not set y_ac_t to val, val must be " + ...
					"class ""double""");
			end
			return;
		end

		function obj = Set_y_ac_f(obj, val)
			if class(val) == "double"
				obj.y_ac_f = val;
			else
				warning("Could not set y_ac_f to val, val must be " + ...
					"class ""double""");
			end
			return;
        end
    end

    methods (Access = private)

        %% Solvers
        % Solves for but does not return C_L
        function obj = Solve_C_L(obj)
            %% List equations and their variable sets
            % C_L = C_L_0 + C_L_alpha * alpha_w + C_L_i_t * i_t + 
            %       C_L_delta_e * delta_e
            equation_1 = "C_L_0 + C_L_alpha * alpha_w + " + ...
                          "C_L_i_t * i_t + C_L_delta_e * delta_e;";
            required_vars_1 = {"C_L_0", "C_L_alpha", "alpha_w", ...
                    "C_L_i_t", "i_t", "C_L_delta_e", "delta_e"};

            % C_L = L / (q_bar_w * S_w)
            equation_2 = "L / (q_bar_w * S_w);";
            required_vars_2 = {"L", "q_bar_w", "S_w"};

            % For iterating through all variables
            var_sets = {required_vars_1, required_vars_2};
            num_var_sets = length(var_sets);
            
            %% Initialize required variable references
            for i_var_set = 1:num_var_sets
                var_set = var_sets{i_var_set};
                num_vars = length(var_set);
                for i_var = 1:num_vars
                    var_name = var_set{i_var};
                    var = obj.(var_name);

                    eval(append(var_name, " = var;"));
                end
            end

            %% Checks if any equations can be solved
            for i_var_set = 1:num_var_sets
                var_set = var_sets{i_var_set};
                equation = append("equation_", string(i_var_set));

                if ~any(cellfun(@(name) isempty(obj.(name)), var_set))
            
                    obj.C_L = eval(equation);
                    return;
                end
            end
        
            %% Prints out unknown required variables preventing the solve
            warning("Solve_C_L: insufficient known variables to solve for C_L");
            fprintf("Unknown variables:\n")
            for i_var_set = 1:num_var_sets
                var_set = var_sets{i_var_set};
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
                    if i_var_set ~= num_var_sets
                        fprintf("--------or--------\n");
                    else
                        fprintf("------------------\n");
                    end
                end
            end

            return;
        end

        % Solves for but does not return 
        function obj = Solve_(obj)
            %% List equations and their variable sets
            % 
            equation_1 = "";
            required_vars_1 = {""};

            % For iterating through all variables
            var_sets = {required_vars_1, required_vars_2};
            num_var_sets = length(var_sets);
            
            %% Initialize required variable references
            for i_var_set = 1:num_var_sets
                var_set = var_sets{i_var_set};
                num_vars = length(var_set);
                for i_var = 1:num_vars
                    var_name = var_set{i_var};
                    var = obj.(var_name);

                    eval(append(var_name, " = var;"));
                end
            end

            %% Checks if any equations can be solved
            for i_var_set = 1:num_var_sets
                var_set = var_sets{i_var_set};
                equation = append("equation_", string(i_var_set));

                if ~any(cellfun(@(name) isempty(obj.(name)), var_set))
            
                    obj.C_L = eval(equation);
                    return;
                end
            end
        
            %% Prints out unknown required variables preventing the solve
            warning("Solve_C_L: insufficient known variables to solve for C_L");
            fprintf("Unknown variables:\n")
            for i_var_set = 1:num_var_sets
                var_set = var_sets{i_var_set};
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
                    if i_var_set ~= num_var_sets
                        fprintf("--------or--------\n");
                    else
                        fprintf("------------------\n");
                    end
                end
            end

            return;
        end
    end
end