% de_rotateHW.m
% de-rotating program for handwriten samples
% Deskewing refers to the process of correcting the tilt or rotation of handwritten text or an image so that the lines of text are horizontal.
% This ensures that the text is properly aligned for further processing or recognition.
% Author: Marcos Faundez-Zanuy
% 7th July 2024
%
% reference for online handwriten signals
% Faundez-Zanuy, M., Fierrez, J., Ferrer, M.A. et al.
% Handwriting Biometrics: Applications and Future Trends in e-Security and e-Health.
% Cogn Comput 12, 940–953 (2020). https://doi.org/10.1007/s12559-020-09755-z

clear all
% load sample data
load c:\temp\sample.mat

%% algorithm
% normalize translation
% Translation normalization
meanX = mean(X); % Calculate mean of X coordinates
meanY = mean(Y); % Calculate mean of Y coordinates
X_centered = X - meanX; % Center X coordinates
Y_centered = Y - meanY; % Center Y coordinates

% Rotation normalization
mu11 = mean(X_centered .* Y_centered); % Cross-covariance
mu20 = mean(X_centered .^ 2); % Variance of X_centered
mu02 = mean(Y_centered .^ 2); % Variance of Y_centered
theta = 0.5 * atan(2 * mu11 / (mu20 - mu02)); % Skew angle

% Apply rotation
X_rotated = X_centered * cos(theta) + Y_centered * sin(theta);
Y_rotated = -X_centered * sin(theta) + Y_centered * cos(theta);

% Plotting results
figure(1); clf;
subplot(3,1,1);
hold on;
plot(X(P >= 0, 1), Y(P >= 0, 1), 'k', 'LineWidth', 2); % Plot in-air points
plot(X(P == 0, 1), Y(P == 0, 1), 'r', 'LineWidth', 1); % Plot on-surface points
grid on;
title('Original Handwriting');
xlabel('X Axis');
ylabel('Y Axis');
plot([meanX-1.5e4, meanX, meanX+1.5e4], [meanY-1.5e4*tan(theta), meanY, meanY+1.5e4*tan(theta)], 'bo:', 'LineWidth', 2);
axis([0.75e4, 4e4, 2.4e4, 3e4]);
set(gca, 'FontSize', 14);
%%
%plot results
figure(1); clf;
subplot(3,1,1);
hold on;
plot(X(P >= 0, 1), Y(P >= 0, 1), 'k', 'LineWidth', 2); % Plot in-air points
plot(X(P == 0, 1), Y(P == 0, 1), 'r', 'LineWidth', 1); % Plot on-surface points
grid on;
title('Original Handwriting');
xlabel('X Axis');
ylabel('Y Axis');
inc=1.5e4;
plot([meanX-inc, meanX, meanX+inc], [meanY-inc*tan(theta), meanY, meanY+inc*tan(theta)], 'bo:', 'LineWidth', 2);
axis([0.75e4, 4e4, 2.4e4, 3e4]);
set(gca, 'FontSize', 14);

subplot(3,1,2);
hold on;
plot(X_centered(P >= 0, 1), Y_centered(P >= 0, 1), 'k', 'LineWidth', 2); % Plot centered in-air points
plot(X_centered(P == 0, 1), Y_centered(P == 0, 1), 'r', 'LineWidth', 1); % Plot centered on-surface points
grid on;
title('Centered Handwriting');
xlabel('X Axis (Centered)');
ylabel('Y Axis (Centered)');
plot([-inc, 0, inc], [-1.5e4*tan(theta), 0, inc*tan(theta)], 'bo:', 'LineWidth', 2);
set(gca, 'FontSize', 14);

subplot(3,1,3);
hold on;
plot(X_rotated(P >= 0, 1), Y_rotated(P >= 0, 1), 'k', 'LineWidth', 2); % Plot rotated in-air points
plot(X_rotated(P == 0, 1), Y_rotated(P == 0, 1), 'r', 'LineWidth', 1); % Plot rotated on-surface points
grid on;
title('Centered and De-rotated Handwriting');
xlabel('X Axis (De-rotated)');
ylabel('Y Axis (De-rotated)');
plot([-inc, 0, inc], [0, 0, 0], 'bo:', 'LineWidth', 2);
set(gca, 'FontSize', 14);
axis([-inc, inc, -2000, 2000]);
legend('Red = On Surface', 'Black = In-Air', 'Blue = Inclination');
