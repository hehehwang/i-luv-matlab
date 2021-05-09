close all, clear all, clc

ani_on = 1;
save_on = 0;

Tf = 50;

m1 = 1; % kg
m2 = 1; % kg

k1 = 1; % N/m
k2 = 1; % N/m

para.m1 = m1;
para.m2 = m2;
para.k1 = k1;
para.k2 = k2;

% y = [x1 x1_dot x2 x2_dot]
y0 = [1,0,1,0];

options = odeset('RelTol',1e-4,'AbsTol',1e-6);

[t, y] = ode23tb(@TwoMassNoDamp_EOM,[0 Tf],y0,options,para);
x1 = y(:,1);
x2 = y(:,3);
v1 = y(:,2);
v2 = y(:,4);

M = [m1 0; 0 m2];
K = [k1+k2 -k2; -k2 k2];
[V, D] = eig(K,M);
% figure; hold on
% plot(t,x1);
% plot(t,x2);
% hold off




%% (t vs x1) and (t vs x2)
% fig_position = [-1800 150 1200 800];
fig_position = [900 150 1200 800];
if ani_on == 1
    tplot = 0:0.1:t(end);
    Lbox = 0.5;
    dxbox = 4;
    
    xx1 = interp1(t,y(:,1),tplot);
    xx2 = interp1(t,y(:,3),tplot);
    mov(length(tplot)) = struct('cdata',[],'colormap',[]);
    
    minX1 = min(x1)-0.1*(max(x1)-min(x1));
    maxX1 = max(x1)+0.1*(max(x1)-min(x1));
    minX2 = min(x2)-0.1*(max(x2)-min(x2));
    maxX2 = max(x2)+0.1*(max(x2)-min(x2));
    
    for ii = 1:length(tplot)
        fig1=figure;
        subplot(211); hold on
        plot([-100 xx1(ii)],[0 0],'k','Linewidth',3);
        plot([xx1(ii) xx2(ii)+dxbox],[0 0],'k','Linewidth',3);
        fill([xx1(ii)-Lbox/2 xx1(ii)+Lbox/2 xx1(ii)+Lbox/2 xx1(ii)-Lbox/2],[-Lbox/2 -Lbox/2 Lbox/2 Lbox/2],'g');
        fill([xx2(ii)-Lbox/2 xx2(ii)+Lbox/2 xx2(ii)+Lbox/2 xx2(ii)-Lbox/2]+dxbox,[-Lbox/2 -Lbox/2 Lbox/2 Lbox/2],'m');
        plot([0 0],[-100 100],'r--');
        plot([dxbox dxbox],[-100 100],'r--')
        text(xx1(ii)-Lbox/4,0,'m_1','Fontsize',16)
        text(xx2(ii)+dxbox-Lbox/4,0,'m_2','Fontsize',16)
        set(gca,'Fontsize',16,'box','on');
        xlim([-dxbox minX2+dxbox+4]);
        ylim([-Lbox/2 Lbox/2]);
%         set(gca,'Position',[-0.2 0.6 1.4 0.34]);
        axis equal
        hold off
        
        subplot(212); hold on
        plot(tplot(1:ii),xx1(1:ii),'g','Linewidth',2.5);
        plot(tplot(1:ii),xx2(1:ii),'m','Linewidth',2.5);
        ylabel({'$$x_1$$ and $$x_2$$'},'Interpreter','latex');
        xlabel({'$$t$$'},'Interpreter','latex');
        set(gca,'Fontsize',16,'box','on');
        legend({'x_1','x_2'},'Fontsize',16)
        xlim([0 tplot(end)*1.05]);
        ylim([min([minX1 minX2]) max([maxX1 maxX2])]);
        hold off

        annotation(fig1,'textbox',[0.3 0.01 0.45 0.03],'String',{'Copyright 2018 by W. Nam All rights reserved.'},...
            'HorizontalAlignment','center','Fontsize',14,'FitBoxToText','off','LineStyle','none');
        set(gcf,'Position',fig_position);
        
        mov(ii) = getframe(gcf);
        close(fig1)
        
        disp([num2str(ii),'/',num2str(length(tplot))])
        
    end
    
    fig = figure;
    set(gcf,'Position',fig_position);
    movie(fig,mov,2,24)
    
    if save_on == 1
        % movie2avi(mov, ['TwoMAssNoDamp_x1x2.avi'], 'compression', 'None');

    end
end


%% x1 vs x2
fig_position = [-1800 150 1200 800];
if ani_on == 1
    tplot = 0:0.1:t(end);
    Lbox = 0.5;
    dxbox = 4;
    
    xx1 = interp1(t,y(:,1),tplot);
    xx2 = interp1(t,y(:,3),tplot);
    mov(length(tplot)) = struct('cdata',[],'colormap',[]);
    
    minX1 = min(x1)-0.1*(max(x1)-min(x1));
    maxX1 = max(x1)+0.1*(max(x1)-min(x1));
    minX2 = min(x2)-0.1*(max(x2)-min(x2));
    maxX2 = max(x2)+0.1*(max(x2)-min(x2));
    
    for ii = 1:length(tplot)
        
        fig1=figure;
        subplot(211); hold on
        plot([-100 xx1(ii)],[0 0],'k','Linewidth',3);
        plot([xx1(ii) xx2(ii)+dxbox],[0 0],'k','Linewidth',3);
        fill([xx1(ii)-Lbox/2 xx1(ii)+Lbox/2 xx1(ii)+Lbox/2 xx1(ii)-Lbox/2],[-Lbox/2 -Lbox/2 Lbox/2 Lbox/2],'g');
        fill([xx2(ii)-Lbox/2 xx2(ii)+Lbox/2 xx2(ii)+Lbox/2 xx2(ii)-Lbox/2]+dxbox,[-Lbox/2 -Lbox/2 Lbox/2 Lbox/2],'m');
        plot([0 0],[-100 100],'r--');
        plot([dxbox dxbox],[-100 100],'r--')
        text(xx1(ii)-Lbox/4,0,'m_1','Fontsize',16)
        text(xx2(ii)+dxbox-Lbox/4,0,'m_2','Fontsize',16)
        set(gca,'Fontsize',16,'box','on');
        xlim([-dxbox minX2+dxbox+4]);
        ylim([-Lbox/2 Lbox/2]);
%         set(gca,'Position',[-0.2 0.6 1.4 0.34]);
        axis equal
        hold off
        
             
        subplot(212); hold on
        plot(xx1(ii),xx2(ii),'r.','Markersize',20);
        plot(xx1(1:ii),xx2(1:ii),'b')
        xlabel({'$$x_1$$'},'Interpreter','latex');
        ylabel({'$$x_2$$'},'Interpreter','latex');
        xlim([minX1 maxX1]);
        ylim([minX2 maxX2]);
        set(gca,'Fontsize',16,'box','on');
        hold off
        
        annotation(fig1,'textbox',[0.3 0.01 0.45 0.03],'String',{'Copyright 2018 by W. Nam All rights reserved.'},...
            'HorizontalAlignment','center','Fontsize',14,'FitBoxToText','off','LineStyle','none');
        set(gcf,'Position',fig_position);
        
        mov(ii) = getframe(gcf);
        close(fig1)
        
        disp([num2str(ii),'/',num2str(length(tplot))])
        
    end
    
    fig = figure;
    set(gcf,'Position',fig_position);
    movie(fig,mov,2,24)
    
    if save_on == 1
        movie2avi(mov, ['TwoMAssNoDamp_x1_vs_x2.avi'], 'compression', 'None');
    end
end



%% transformation process
% x=[x1'; x2'];
% 
% 
% if ani_on == 1
%     
%     rset = [0:0.2:1];
%     
% %     figure;
% %     plot(rset,1-abs(rset-0.5).^0.1);
%     
%     minX1 = min(x1)-0.1*(max(x1)-min(x1));
%     maxX1 = max(x1)+0.1*(max(x1)-min(x1));
%     minX2 = min(x2)-0.1*(max(x2)-min(x2));
%     maxX2 = max(x2)+0.1*(max(x2)-min(x2));
%     
%     for ri = 1:length(rset)
%         r = rset(ri);
%         Vr = [1-r*(1-V(1,1)) r*V(1,2); r*V(2,1) 1-r*(1-V(2,2))];
%         beta = Vr\x;
%         
%         b1 = beta(1,:);
%         b2 = beta(2,:);
%         
%         fig1=figure;
%         plot(b1,b2,'b')
%         %         xlabel({'$$\tilde{x}_1$$'},'Interpreter','latex');
%         %         ylabel({'$$\tilde{x}_2$$'},'Interpreter','latex');
% %         if r == 0, xlim([-1.2 1.2]);  ylim([-2 2]);
% %         elseif r == 0.2, xlim([-2 2]);  ylim([-3 3]);
% %         elseif r == 0.4, xlim([-6 6]);  ylim([-4 4]);
% %         elseif r == 0.6, xlim([-6.5 6.5]);  ylim([-3.1 3.1]);
% %         elseif r == 0.8, xlim([-2.5 2.5]);  ylim([-2 2]);
% %         elseif r == 1, xlim([-2 2]);  ylim([-2 2]);
% %         end
%         xlim([-6.5 6.5]);  ylim([-3.1 3.1]);
%         set(gca,'Fontsize',16,'box','on');
%         
%         annotation(fig1,'textbox',[0.3 0.01 0.45 0.03],'String',{'Copyright 2018 by W. Nam All rights reserved.'},...
%             'HorizontalAlignment','center','Fontsize',14,'FitBoxToText','off','LineStyle','none');
%         set(gcf,'Position',fig_position);
%         
%         mov(ri) = getframe(gcf);
%         close(fig1)
%         
%         disp([num2str(ri),'/',num2str(length(rset))])
%         
%     end
%     
%     fig = figure;
%     set(gcf,'Position',fig_position);
%     movie(fig,mov,2,1)
%     
%     if save_on == 1
%         movie2avi(mov, ['TwoMAssNoDamp_Conversion_x1x2_to_b1b2.avi'], 'compression', 'None');
%     end
% end




%% modal coordinate
x=[x1'; x2'];
beta = V\x;

b1 = beta(1,:);
b2 = beta(2,:);

% figure;
% plot(b1,t);


%% (x1 vs x2) and (b1 vs b2)
if ani_on == 1
    tplot = 0:0.1:t(end);
    Lbox = 0.5;
    dxbox = 4;
    
    xx1 = interp1(t,y(:,1),tplot);
    xx2 = interp1(t,y(:,3),tplot);
    bb1 = interp1(t,b1,tplot);
    bb2 = interp1(t,b2,tplot);
    mov(length(tplot)) = struct('cdata',[],'colormap',[]);
    
    minX1 = min(x1)-0.1*(max(x1)-min(x1));
    maxX1 = max(x1)+0.1*(max(x1)-min(x1));
    minX2 = min(x2)-0.1*(max(x2)-min(x2));
    maxX2 = max(x2)+0.1*(max(x2)-min(x2));
    
    minB1 = min(b1)-0.1*(max(b1)-min(b1));
    maxB1 = max(b1)+0.1*(max(b1)-min(b1));
    minB2 = min(b2)-0.1*(max(b2)-min(b2));
    maxB2 = max(b2)+0.1*(max(b2)-min(b2));
    
    for ii = 1:length(tplot)
        fig1=figure;
        subplot(221); hold on
        plot([-100 xx1(ii)],[0 0],'k','Linewidth',3);
        plot([xx1(ii) xx2(ii)+dxbox],[0 0],'k','Linewidth',3);
        fill([xx1(ii)-Lbox/2 xx1(ii)+Lbox/2 xx1(ii)+Lbox/2 xx1(ii)-Lbox/2],[-Lbox/2 -Lbox/2 Lbox/2 Lbox/2],'g');
        fill([xx2(ii)-Lbox/2 xx2(ii)+Lbox/2 xx2(ii)+Lbox/2 xx2(ii)-Lbox/2]+dxbox,[-Lbox/2 -Lbox/2 Lbox/2 Lbox/2],'m');
        text(xx1(ii)-Lbox/5,0,'m_1','Fontsize',16)
        text(xx2(ii)+dxbox-Lbox/5,0,'m_2','Fontsize',16)
        set(gca,'Fontsize',16,'box','on');
        xlim([minX1-4 minX2+dxbox+4]);
        ylim([-Lbox Lbox]);
        set(gca,'Position',[-0.2 0.6 1.4 0.34]);
        axis equal
        hold off
        
        subplot(223); hold on
        plot(xx1(ii),xx2(ii),'r.','Markersize',20);
        plot(xx1(1:ii),xx2(1:ii),'b')
        xlabel({'$$x_1$$'},'Interpreter','latex');
        ylabel({'$$x_2$$'},'Interpreter','latex');
        xlim([minX1 maxX1]);
        ylim([minX2 maxX2]);
        set(gca,'Fontsize',16,'box','on');
        hold off
        
        subplot(224); hold on
        plot(bb1(ii),bb2(ii),'r.','Markersize',20);
        plot(bb1(1:ii),bb2(1:ii),'b')
        xlabel({'$$\tilde{x}_1$$'},'Interpreter','latex');
        ylabel({'$$\tilde{x}_2$$'},'Interpreter','latex');
        xlim([minB1 maxB1]);
        ylim([minB2 maxB2]);
        set(gca,'Fontsize',16,'box','on');
        hold off
        
        annotation(fig1,'textbox',[0.3 0.01 0.45 0.03],'String',{'Copyright 2018 by W. Nam All rights reserved.'},...
            'HorizontalAlignment','center','Fontsize',14,'FitBoxToText','off','LineStyle','none');
        set(gcf,'Position',fig_position);
        
        mov(ii) = getframe(gcf);
        close(fig1)
        
        disp([num2str(ii),'/',num2str(length(tplot))])
        
    end
    
    fig = figure;
    set(gcf,'Position',fig_position);
    movie(fig,mov,2,24)
    
    if save_on == 1
        movie2avi(mov, ['TwoMAssNoDamp_x1x2_b1b2.avi'], 'compression', 'None');
    end
end



%% (b1 vs b2) and (t vs b1) and (t vs b2)
if ani_on == 1
    
    tplot = 0:0.05:t(end);
    
    xx1 = interp1(t,y(:,1),tplot);
    xx2 = interp1(t,y(:,3),tplot);
    bb1 = interp1(t,b1,tplot);
    bb2 = interp1(t,b2,tplot);
    mov(length(tplot)) = struct('cdata',[],'colormap',[]);
    
    minB1 = min(b1)-0.1*(max(b1)-min(b1));
    maxB1 = max(b1)+0.1*(max(b1)-min(b1));
    minB2 = min(b2)-0.1*(max(b2)-min(b2));
    maxB2 = max(b2)+0.1*(max(b2)-min(b2));
    
    for ii = 1:length(tplot)
        fig1=figure;
        
        subplot(221); hold on
        plot(bb1(ii),bb2(ii),'r.','Markersize',20);
        plot(bb1(1:ii),bb2(1:ii),'b')
        xlabel({'$$\tilde{x}_1$$'},'Interpreter','latex');
        ylabel({'$$\tilde{x}_2$$'},'Interpreter','latex');
        xlim([minB1 maxB1]);
        ylim([minB2 maxB2]);
        set(gca,'Fontsize',16,'box','on');
        hold off
        
        subplot(222); hold on
        plot(tplot(ii),bb2(ii),'r.','Markersize',20);
        plot(tplot(1:ii),bb2(1:ii),'b')
        xlim([0 tplot(end)+0.1]);
        ylim([minB2 maxB2]);
        xlabel({'$$t$$'},'Interpreter','latex');
        ylabel({'$$\tilde{x}_2$$'},'Interpreter','latex');
        set(gca,'Fontsize',16,'box','on');
        hold off
        
        subplot(223); hold on
        plot(bb1(ii),tplot(ii),'r.','Markersize',20);
        plot(bb1(1:ii),tplot(1:ii),'b')
        ylabel({'$$t$$'},'Interpreter','latex');
        xlabel({'$$\tilde{x}_1$$'},'Interpreter','latex');
        xlim([minB1 maxB1]);
        ylim([0 tplot(end)+0.1]);
        set(gca,'Fontsize',16,'box','on');
        set(gca,'Ydir','reverse')
        hold off
        
        annotation(fig1,'textbox',[0.3 0.01 0.45 0.03],'String',{'Copyright 2018 by W. Nam All rights reserved.'},...
            'HorizontalAlignment','center','Fontsize',14,'FitBoxToText','off','LineStyle','none');
        set(gcf,'Position',fig_position);
        mov(ii) = getframe(gcf);
        close(fig1)
        
        disp([num2str(ii),'/',num2str(length(tplot))])
        
    end
    
    fig = figure;
    set(gcf,'Position',fig_position);
    movie(fig,mov,2,24)
    
    if save_on == 1
        movie2avi(mov, ['TwoMAssNoDamp_b1b2.avi'], 'compression', 'None');
    end
    
end





