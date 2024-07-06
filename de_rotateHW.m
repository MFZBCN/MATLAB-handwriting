% de_rotateHW.m
% de-rotating program for handwriten samples
% Deskewing refers to the process of correcting the tilt or rotation of handwritten text or an image so that the lines of text are horizontal.
% This ensures that the text is properly aligned for further processing or recognition.
% Autor: Marcos Faundez-Zanuy
% 7th July 2024
%
% reference for online handwriten signals
% Faundez-Zanuy, M., Fierrez, J., Ferrer, M.A. et al.
% Handwriting Biometrics: Applications and Future Trends in e-Security and e-Health.
% Cogn Comput 12, 940–953 (2020). https://doi.org/10.1007/s12559-020-09755-z

clear all
% load sample data
load c:\temp\sample.mat

% algporithm
% normalize translation
distX=mean(X);distY=mean(Y);
X2=X-distX;
Y2=Y-distY;
% normalize rotation
mu11=X2'*Y2/length(X2);
mu20=mean(X2.^2);
mu02=mean(Y2.^2);
%handwriting orientatio = s
s=0.5*atan(2*mu11/(mu20-mu02));
%rotation
Xc=X2*cos(s)+Y2*sin(s);
Yc=-X2*sin(s)+Y2*cos(s);

figure(1)
clf
subplot(311)
%plot(X(:,1), Y(:,1));
plot(X((P>=0),1), Y((P>=0),1),'k','LineWidth',2);
hold on
plot(X((P==0),1), Y((P==0),1),'r','LineWidth',1);
grid on;
title('Original');
inc=1.5e4;
plot([distX-inc,distX,distX+inc],[distY-(inc*tan(s)),distY,distY+(inc*tan(s))],'bo:','linewidth',2)
set(gca,'FontSize',14)
axis([0.75e4, 4e4, 2.4e4, 3e4])
subplot(312)
plot(X2((P>=0),1), Y2((P>=0),1),'k','LineWidth',2);
hold on
plot(X2((P==0),1), Y2((P==0),1),'r','LineWidth',1);
grid on;
title('Centered');
inc=1.5e4;
plot([-inc,0,inc],[-(inc*tan(s)),0,(inc*tan(s))],'bo:','linewidth',2)
set(gca,'FontSize',14)
subplot(313)
plot(Xc((P>=0),1), Yc((P>=0),1),'k','LineWidth',2);
hold on
plot(Xc((P==0),1), Yc((P==0),1),'r','LineWidth',1);
grid on;
title('Centered and de-rotated');
plot([-inc,0,inc],[0,0,0],'bo:','linewidth',2)
set(gca,'FontSize',14)
axis([-1.51e4, 1.5e4, -2000, 2000])
legend('red = on surface', 'black = in-air',' blue = inclination')


