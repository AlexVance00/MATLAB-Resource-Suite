% Converts rotation rates given in inertial frame to rotation rates in
%   body-fixed frame for an aircraft
% rotation_rates in (rad/s or deg/s - Units dependent on "units" argument)
% -------------------------------------------------------------------------
% Assumptions
%   1) Rigid Body
%   2) Lateral Symmetry
% -------------------------------------------------------------------------
% Arguments
%   psii = yaw (rad or deg - Units dependent on "units" argument)
%   theta = pitch (rad or deg - Units dependent on "units" argument)
%   phi = roll (rad or deg - Units dependent on "units" argument)
%   psi_dot = yaw rate (rad/s or deg/s - Units dependent on "units"
%       argument)
%   theta_dot = pitch rate (rad/s or deg/s - Units dependent on "units"
%       argument)
%   phi_dot = roll rate (rad/s or deg/s - Units dependent on "units"
%       argument)
%   units = "rad" or "deg"
%   bool_show_display = true or false
% -------------------------------------------------------------------------
% Sources
%   1) Rotation transformation equations come from AE 3361 notes
% -------------------------------------------------------------------------
% MATLAB Version R2024b, also compatible with:
%   - R2025a
% -------------------------------------------------------------------------
% Developed by Alex Vance

function rotation_rates = mfilename(args)

    % Allows arguments to be optional and assigned in the function call
    %   as in: GetResult(<varname> = <value>, ...)

    % Classify Non-Optional Arguments
    arguments
        args.psii = [];
        args.theta = [];
        args.phi = [];
        args.psi_dot = [];
        args.theta_dot = [];
        args.phi_dot = [];
        args.units = [];
        args.bool_show_display = false;
    end
    arg_name_list = fieldnames(args);

    % Classify Optional Arguments - 1D String Array
    optional_arg_names = [];

    % Valid Units
    valid_units = ["rad", "deg"];

    % Makes variables out of args' fieldnames
    for i_fieldname = 1:length(arg_name_list)
        arg_name = arg_name_list{i_fieldname};
        arg_val = args.(arg_name);

        % Input Checking
        if ~isempty(arg_val)

            % Initializes given optional arguments
            if arg_name ~= "units" || ismember(arg_val, valid_units)
                eval(append(arg_name, " = arg_val;"));                
            else
                error("Invalid input for non-optional 'units' " + ...
                    "parameter.\n Valid inputs are <'rad', 'deg'>");
            end
        elseif ~ismember(arg_name, optional_arg_names)
            
            % If any non-optional arguments are un-initialized, throws
            %   error
            error("No input for non-optional '%s' parameter", arg_name);
        end
    end

    % Display Inputs
    if bool_show_display
        phi_char = char(966);
        theta_char = char(952);
        psi_char = char(968);
    
        fprintf("%s = %.4f %s\n" + ...
                "%s = %.4f %s\n" + ...
                "%s = %.4f %s\n\n" + ...
                "%s_dot = %.4f %s/s\n" + ...
                "%s_dot = %.4f %s/s\n" + ...
                "%s_dot = %.4f %s/s\n\n", ...
                phi_char, phi, units, ...
                theta_char, theta, units, ...
                psi_char, psii, units, ...
                phi_char, phi_dot, units, ...
                theta_char, theta_dot, units, ...
                psi_char, psi_dot, units);
    end

    % Intermediate Calculations
    deg_rad = 180 ./ pi;

    if units ~= "rad"
        psii = psii ./ deg_rad;
        theta = theta ./ deg_rad;
        phi = phi ./ deg_rad;
        psi_dot = psi_dot ./ deg_rad;
        theta_dot = theta_dot ./ deg_rad;
        phi_dot = phi_dot ./ deg_rad;
    end

    R1_phi = [1, 0, 0;
                  0, cos(phi), sin(phi);
                  0, -sin(phi), cos(phi)];
    R2_theta = [cos(theta), 0, -sin(theta);
                    0, 1, 0;
                    sin(theta), 0, cos(theta)];
    R3_psi = [cos(psii), sin(psii), 0;
              -sin(psii), cos(psii), 0;
              0, 0, 1];

    rotation_rates = [phi_dot;
                      theta_dot;
                      psi_dot];

    % Final Calculations
    rotation_rates = R1_phi * R2_theta * R3_psi * rotation_rates;

    if units == "deg"
        rotation_rates = rotation_rates .* deg_rad;
    end

    % Display Results and/or Plotting
    if bool_show_display
        fprintf("R1(%s) = [%.4f; %.4f; %.4f]\n" + ...
                "R2(%s) = [%.4f; %.4f; %.4f]\n" + ...
                "R3(%s) = [%.4f; %.4f; %.4f]\n\n", ...
                phi_char, R1_phi(1), R1_phi(2), R1_phi(3), ...
                theta_char, R2_theta(1), R2_theta(2), R2_theta(3), ...
                psi_char, R3_psi(1), R3_psi(2), R3_psi(3));
    
        fprintf("p = %.4f %s/s\n" + ...
                "q = %.4f %s/s\n" + ...
                "r = %.4f %s/s\n\n", ...
                rotation_rates(1), units, ...
                rotation_rates(2), units, ...
                rotation_rates(3), units);
    end
    return;
end