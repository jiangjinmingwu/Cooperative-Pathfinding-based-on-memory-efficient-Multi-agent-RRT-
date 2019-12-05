% ymax = max([path_cost_marrts(1,:),path_cost_marrtsfn(1,:),path_cost_ismarrts(1,:),path_cost_ismarrtsfn(1,:)]);
% ymin = min([path_cost_marrts(end,:),path_cost_marrtsfn(end,:),path_cost_ismarrts(end,:),path_cost_ismarrtsfn(end,:)]);
% if ymin == ymax
%     axis_bias = 30;
% else
%     axis_bias = (ymax-ymin)/2;
% end
% figure(1)
% x = 1:5000;
% plot(x,path_cost_marrts,'DisplayName','MARRT','Color','k','LineWidth',2);
% hold on;
% plot(1:5000,path_cost_marrtsfn,'--r','DisplayName','MARRTsFN','LineWidth',2);
% plot(1:5000,path_cost_ismarrts,':g','DisplayName','isMARRTs','LineWidth',2);
% plot(1:5000,path_cost_ismarrtsfn,'-.b','DisplayName','isMARRTsFN','LineWidth',2);
% ylim manual
% xlim manual
% ylim([90,140])
% xlim([0,5000]);
% xticks(0:1000:5000);
% yticks([90 100 110 120 130 140]);
% ytickangle(90)
% ax = gca;
% ax.FontSize = 13;
% title('Three Agent Navigation');
% xlabel('Number of iterations');
% ylabel('Path cost');
% legend('Location','southoutside','Orientation','horizontal');
% set(gcf,'Position',[400,400,650,500]);
% grid on;
% hold off;

figure(1)
x = 1:5000;
plot(x,numnodes_marrts,'DisplayName','MARRTs','Color','k','LineWidth',2);
hold on;
plot(1:5000,numnodes_marrtsfn,'--r','DisplayName','MARRTsFN','LineWidth',2);
plot(1:5000,is_numnodes_marrts,':g','DisplayName','isMARRTs','LineWidth',2);
plot(1:5000,is_numnodes_marrtsfn,'-.b','DisplayName','isMARRTsFN','LineWidth',2);
ylim manual
xlim manual
ylim([0,5000])
xlim([0,5000]);
xticks(0:1000:5000);
yticks(0:1000:5000);
ytickangle(90)
ax = gca;
ax.FontSize = 12;
title('Three Agent Navigation');
xlabel('Number of iterations');
ylabel('Number of nodes');
legend('Location','southoutside','Orientation','horizontal');
set(gcf,'Position',[400,400,630,500]);
grid on;
hold off;