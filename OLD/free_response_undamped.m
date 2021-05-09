%%% copyright 2018, W. Nam, all rights reserved


clear all
close all
clc

m = 10;
k = 1;
wn = sqrt(k/m);
x0set = [3 6 10];

c = 0;
F0 = 0;
frq_e = 0;

t = cell(1,length(x0set));
x = cell(1,length(x0set));
for jj = 1:3
    x0 = x0set(jj);
    v0 = 0;
    
    ini = [x0; v0];
    tspan = [0 90];
     
    options = odeset('RelTol',1e-6,'AbsTol',1e-8);
    
    para = [m k c F0 frq_e];
    
    % [x, y] = odee45(odefun, tsapn, y0, options) 
    [t{jj}, x{jj}] = ode45( @(t,x)one_dof_ode(t, x, para), tspan, ini, options);
    
%     figure;
%     plot(t{jj},x{jj}(:,1));
end



Lbox = 2;
tplot = 0:0.2:tspan(end);
mov(length(tplot)) = struct('cdata',[],'colormap',[]);
for ii = 1:length(tplot)
    
    xxx{1} = interp1(t{1},x{1}(:,1),tplot(ii));
    xxx{2} = interp1(t{2},x{2}(:,1),tplot(ii));
    xxx{3} = interp1(t{3},x{3}(:,1),tplot(ii));
    
    fig1=figure;
    subplot(311)
    hold on
    plot([-100 xxx{1}(:,1)],[0 0],'k','Linewidth',-0.3*xxx{1}(:,1)+7);
    fill([xxx{1}(:,1)-Lbox/2 xxx{1}(:,1)+Lbox/2 xxx{1}(:,1)+Lbox/2 xxx{1}(:,1)-Lbox/2],[-Lbox/2 -Lbox/2 Lbox/2 Lbox/2],'r');
    xlim([-12 12]);
    ylim([-3 3]);
    set(gca,'Fontsize',14,'box','on');
    hold off

    subplot(312)
    hold on
    plot([-100 xxx{2}(:,1)],[0 0],'k','Linewidth',-0.3*xxx{2}(:,1)+7);
    fill([xxx{2}(:,1)-Lbox/2 xxx{2}(:,1)+Lbox/2 xxx{2}(:,1)+Lbox/2 xxx{2}(:,1)-Lbox/2],[-Lbox/2 -Lbox/2 Lbox/2 Lbox/2],'r');
    xlim([-12 12]);
    ylim([-3 3]);
    set(gca,'Fontsize',14,'box','on');
    hold off
    
    subplot(313)
    hold on
    plot([-100 xxx{3}(:,1)],[0 0],'k','Linewidth',-0.3*xxx{3}(:,1)+7);
    fill([xxx{3}(:,1)-Lbox/2 xxx{3}(:,1)+Lbox/2 xxx{3}(:,1)+Lbox/2 xxx{3}(:,1)-Lbox/2],[-Lbox/2 -Lbox/2 Lbox/2 Lbox/2],'r');
    xlim([-12 12]);
    ylim([-3 3]);
    hold off
    
    annotation(fig1,'textbox',[0.5 0.01 0.45 0.03],'String',{'Copyright 2018 by W. Nam all rights reserved.'},...
        'HorizontalAlignment','center','Fontsize',14,'FitBoxToText','off','LineStyle','none');    
    set(gca,'Fontsize',14,'box','on');
    set(gcf,'Position',[-1500 50 1100 900]);
    
    
    mov(ii) = getframe(gcf);
    close(fig1)
    
    disp([num2str(ii),'/',num2str(length(tplot))])
    
end

fig = figure;
set(gcf,'Position',[50 50 1100 900]);
movie(fig,mov,2)

% movie2avi(mov, ['free_response_undampded.avi'], 'compression', 'None');
