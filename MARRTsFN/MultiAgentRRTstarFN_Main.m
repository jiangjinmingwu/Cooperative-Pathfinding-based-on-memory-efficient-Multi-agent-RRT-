%
%
% 初始化地图： 1——障碍物 -1——智能体初始位置和目标位置    
% input_map = zeros(10,10);
% input_map = zeros(30,30);
% input_map = zeros(50,50);
% input_map = zeros(70,70);
% input_map = zeros(90,90);


% solutions_marrts = cell(12,1);                                              % 解容器初始化
% solutions = cell(12,1);
% parfor rand_instance = 1 : 12
%     agent = 3;
%     map_index = 3;
%     % 智能体数量，地图初始化
%     choose_map = {zeros(10,10);zeros(30,30);zeros(50,50);zeros(70,70);zeros(90,90)}; % 地图选择器初始化
%     input_map = choose_map{map_index,1};                                    % 地图初始化     
%     agent_count = agent;                                                    % 智能体的数量，初始化     
%     [rows,cols] = size(input_map);                                          % 地图的行数和列数
%     % 初始化障碍物位置
%     for i = 1 : (rows*cols/10)                                              % 取网格数量的1/10作为障碍物格子
%         input_map(ceil((rows-1)*rand),ceil((cols-1)*rand)) = 1;             % 随机选择1个网格作为障碍物格子
%     end
%     % 初始化智能体位置和目标
%     valid = false;                                                          % 初始化采样点有效程度为否
%     A = [];                                                                 % 智能体对象数组初始化为空
%     for i = 1 : agent_count
%         while valid == false
%             rand_position = [ceil((rows-1)*rand),ceil((cols-1)*rand)];              % 随机选择1个网格作为智能体初始位置格子
%             rand_goal = [ceil((rows-1)*rand),ceil((cols-1)*rand)];                  % 随机选择1个网格作为智能体目标位置格子
%             if (input_map(rand_position(1),rand_position(2)) ~= 1) && ...
%                     (input_map(rand_position(1),rand_position(2)) ~= -1) && ...
%                     (input_map(rand_goal(1),rand_goal(2)) ~= 1) && ...
%                     (input_map(rand_goal(1),rand_goal(2)) ~= -1)                     % 智能体的初始位置不重合，目标位置不重合，和障碍物不干涉
%                 input_map(rand_position(1),rand_position(2)) = -1;                   % 初始位置置-1
%                 input_map(rand_goal(1),rand_goal(2)) = -1;                           % 目标位置置-1
%                 backup_A = Agent(rand_position,rand_goal,input_map);                % 初始化智能体类,【每个智能体的地图仅包含自己的初始位置和目标位置】
%                 A = [A;backup_A];                                                   % 把各个智能体依次存入数组
%                 valid = true;                                                       % 有效程度为真
%             end
%         end
%         valid = false;                                                              % 有效程度重置
%     end
%     position = A(1).position;                                                       % 存储智能体的位置，作为初始状态节点，是行向量
%     goal = A(1).goal;                                                               % 存储智能体的目标，作为目标状态节点，是行向量
%     if agent_count > 1
%         for i = 2 : agent_count
%             position = [position,A(i).position];
%             goal = [goal,A(i).goal];
%         end
%     end
%     % 运行MA-RRTs算法
%     marrts = MARRTs(input_map,position,goal,agent_count);                           % 初始化MARRTs算法，分配参数
%     marrts = runMARRTs(marrts);                                                     % 运行MARRTs算法
%     solutions{rand_instance,:} = marrts;                                            % 结果存入数组
% end
% % 保存结果
% solutions_marrts(:) = solutions(:);
% save('marrts.mat','solutions_marrts');                                                  % 结果存入文件
% 
% solutions_marrtsfn = cell(12,1);                                              % 解容器初始化
% solutions = cell(12,1);
% parfor rand_instance = 1 : 12
%     agent = 3;
%     map_index = 3;
%     % 智能体数量，地图初始化
%     choose_map = {zeros(10,10);zeros(30,30);zeros(50,50);zeros(70,70);zeros(90,90)}; % 地图选择器初始化
%     input_map = choose_map{map_index,1};                                    % 地图初始化     
%     agent_count = agent;                                                    % 智能体的数量，初始化     
%     [rows,cols] = size(input_map);                                          % 地图的行数和列数
%     % 初始化障碍物位置
%     for i = 1 : (rows*cols/10)                                              % 取网格数量的1/10作为障碍物格子
%         input_map(ceil((rows-1)*rand),ceil((cols-1)*rand)) = 1;             % 随机选择1个网格作为障碍物格子
%     end
%     % 初始化智能体位置和目标
%     valid = false;                                                          % 初始化采样点有效程度为否
%     A = [];                                                                 % 智能体对象数组初始化为空
%     for i = 1 : agent_count
%         while valid == false
%             rand_position = [ceil((rows-1)*rand),ceil((cols-1)*rand)];              % 随机选择1个网格作为智能体初始位置格子
%             rand_goal = [ceil((rows-1)*rand),ceil((cols-1)*rand)];                  % 随机选择1个网格作为智能体目标位置格子
%             if (input_map(rand_position(1),rand_position(2)) ~= 1) && ...
%                     (input_map(rand_position(1),rand_position(2)) ~= -1) && ...
%                     (input_map(rand_goal(1),rand_goal(2)) ~= 1) && ...
%                     (input_map(rand_goal(1),rand_goal(2)) ~= -1)                     % 智能体的初始位置不重合，目标位置不重合，和障碍物不干涉
%                 input_map(rand_position(1),rand_position(2)) = -1;                   % 初始位置置-1
%                 input_map(rand_goal(1),rand_goal(2)) = -1;                           % 目标位置置-1
%                 backup_A = Agent(rand_position,rand_goal,input_map);                % 初始化智能体类,【每个智能体的地图仅包含自己的初始位置和目标位置】
%                 A = [A;backup_A];                                                   % 把各个智能体依次存入数组
%                 valid = true;                                                       % 有效程度为真
%             end
%         end
%         valid = false;                                                              % 有效程度重置
%     end
%     position = A(1).position;                                                       % 存储智能体的位置，作为初始状态节点，是行向量
%     goal = A(1).goal;                                                               % 存储智能体的目标，作为目标状态节点，是行向量
%     if agent_count > 1
%         for i = 2 : agent_count
%             position = [position,A(i).position];
%             goal = [goal,A(i).goal];
%         end
%     end
%     % 运行MA-RRTsFN算法
%     marrtsfn = MARRTsFN(input_map,position,goal,agent_count);                           % 初始化MARRTs算法，分配参数
%     marrtsfn = runRRTfn(marrtsfn);                                                     % 运行MARRTs算法
%     solutions{rand_instance,:} = marrtsfn;                                            % 结果存入数组
% end
% % 保存结果
% solutions_marrtsfn(:) = solutions(:);
% save('marrts.mat','solutions_marrtsfn','-append');                                       % 结果存入文件
% 
% is_solutions_marrts = cell(12,1);                                              % 解容器初始化
% solutions = cell(12,1);
% parfor rand_instance = 1 : 12
%     agent = 3;
%     map_index = 3;
%     % 智能体数量，地图初始化
%     choose_map = {zeros(10,10);zeros(30,30);zeros(50,50);zeros(70,70);zeros(90,90)}; % 地图选择器初始化
%     input_map = choose_map{map_index,1};                                    % 地图初始化     
%     agent_count = agent;                                                    % 智能体的数量，初始化     
%     [rows,cols] = size(input_map);                                          % 地图的行数和列数
%     % 初始化障碍物位置
%     for i = 1 : (rows*cols/10)                                              % 取网格数量的1/10作为障碍物格子
%         input_map(ceil((rows-1)*rand),ceil((cols-1)*rand)) = 1;             % 随机选择1个网格作为障碍物格子
%     end
%     % 初始化智能体位置和目标
%     valid = false;                                                          % 初始化采样点有效程度为否
%     A = [];                                                                 % 智能体对象数组初始化为空
%     for i = 1 : agent_count
%         while valid == false
%             rand_position = [ceil((rows-1)*rand),ceil((cols-1)*rand)];              % 随机选择1个网格作为智能体初始位置格子
%             rand_goal = [ceil((rows-1)*rand),ceil((cols-1)*rand)];                  % 随机选择1个网格作为智能体目标位置格子
%             if (input_map(rand_position(1),rand_position(2)) ~= 1) && ...
%                     (input_map(rand_position(1),rand_position(2)) ~= -1) && ...
%                     (input_map(rand_goal(1),rand_goal(2)) ~= 1) && ...
%                     (input_map(rand_goal(1),rand_goal(2)) ~= -1)                     % 智能体的初始位置不重合，目标位置不重合，和障碍物不干涉
%                 input_map(rand_position(1),rand_position(2)) = -1;                   % 初始位置置-1
%                 input_map(rand_goal(1),rand_goal(2)) = -1;                           % 目标位置置-1
%                 backup_A = Agent(rand_position,rand_goal,input_map);                % 初始化智能体类,【每个智能体的地图仅包含自己的初始位置和目标位置】
%                 A = [A;backup_A];                                                   % 把各个智能体依次存入数组
%                 valid = true;                                                       % 有效程度为真
%             end
%         end
%         valid = false;                                                              % 有效程度重置
%     end
%     position = A(1).position;                                                       % 存储智能体的位置，作为初始状态节点，是行向量
%     goal = A(1).goal;                                                               % 存储智能体的目标，作为目标状态节点，是行向量
%     if agent_count > 1
%         for i = 2 : agent_count
%             position = [position,A(i).position];
%             goal = [goal,A(i).goal];
%         end
%     end
%     % 运行单个rrt算法
%     single_solution = [];                                                           % 单个智能体的解初始化为空
%     for i = 1 : agent_count                                                         % 对每一个智能体，单独求一次解
%         rrts = RRTs(input_map,A(i).position,A(i).goal,1);                           % 初始化RRT算法，分配参数
%         rrts = runRRTs(rrts);                                                       % 运行rrt算法
%         single_solution = [single_solution;rrts];                                   % 求得的解存储在single_solution中
%     end
%     % 运行is_MA-RRTs算法
%     is_marrts = MARRTs(input_map,position,goal,agent_count);                         % 初始化MARRTs算法，分配参数
%     is_marrts = runMARRTs(is_marrts,single_solution);                                % 运行MARRTs算法
%     solutions{rand_instance,:} = is_marrts;                                          % 结果存入数组
% end
% % 保存结果
% is_solutions_marrts(:) = solutions(:);
% save('is_marrts.mat','is_solutions_marrts');                                        % 结果存入文件

is_solutions_marrtsfn = cell(12,10);                                              % 解容器初始化
is_solutions_marrts = cell(12,10);
% solutions_marrtsfn = cell(12,10);
% solutions_marrts = cell(12,10);
% sol_marrts = cell(12,10);                                                         % 临时变量初始化
% sol_marrtsfn = cell(12,10);
sol_ismarrts = cell(12,10);
sol_ismarrtsfn = cell(12,10);
parfor repeat = 1 : 10
    for rand_instance = 1 : 12
        agent = 3;
        map_index = 3;
        % 智能体数量，地图初始化
        choose_map = {zeros(10,10);zeros(30,30);zeros(50,50);zeros(70,70);zeros(90,90)}; % 地图选择器初始化
        input_map = choose_map{map_index,1};                                    % 地图初始化     
        agent_count = agent;                                                    % 智能体的数量，初始化     
        [rows,cols] = size(input_map);                                          % 地图的行数和列数
        % 初始化障碍物位置
        for i = 1 : (rows*cols/10)                                              % 取网格数量的1/10作为障碍物格子
            input_map(ceil((rows-1)*rand),ceil((cols-1)*rand)) = 1;             % 随机选择1个网格作为障碍物格子
        end
        % 初始化智能体位置和目标
        valid = false;                                                          % 初始化采样点有效程度为否
        A = [];                                                                 % 智能体对象数组初始化为空
        for i = 1 : agent_count
            while valid == false
                rand_position = [ceil((rows-1)*rand),ceil((cols-1)*rand)];              % 随机选择1个网格作为智能体初始位置格子
                rand_goal = [ceil((rows-1)*rand),ceil((cols-1)*rand)];                  % 随机选择1个网格作为智能体目标位置格子
                if (input_map(rand_position(1),rand_position(2)) ~= 1) && ...
                        (input_map(rand_position(1),rand_position(2)) ~= -1) && ...
                        (input_map(rand_goal(1),rand_goal(2)) ~= 1) && ...
                        (input_map(rand_goal(1),rand_goal(2)) ~= -1)                     % 智能体的初始位置不重合，目标位置不重合，和障碍物不干涉
                    input_map(rand_position(1),rand_position(2)) = -1;                   % 初始位置置-1
                    input_map(rand_goal(1),rand_goal(2)) = -1;                           % 目标位置置-1
                    backup_A = Agent(rand_position,rand_goal,input_map);                % 初始化智能体类,【每个智能体的地图仅包含自己的初始位置和目标位置】
                    A = [A;backup_A];                                                   % 把各个智能体依次存入数组
                    valid = true;                                                       % 有效程度为真
                end
            end
            valid = false;                                                              % 有效程度重置
        end
        %         input_map = is_solutions_marrts{rand_instance,:}.map;
        %         position = is_solutions_marrts{rand_instance,:}.init_position;
        %         goal = is_solutions_marrts{rand_instance,:}.goal;
        %         A = Agent(position(1,1:2),goal(1,1:2),input_map);
        %         if agent_count > 1
        %             for i = 2 : agent_count
        %                 backup_A = Agent(position(1,(2*i-1):2*i),goal(1,(2*i-1):2*i),input_map);
        %                 A = [A;backup_A];
        %             end
        %         end
        position = A(1).position;                                                       % 存储智能体的位置，作为初始状态节点，是行向量
        goal = A(1).goal;                                                               % 存储智能体的目标，作为目标状态节点，是行向量
        if agent_count > 1
            for i = 2 : agent_count
                position = [position,A(i).position];
                goal = [goal,A(i).goal];
            end
        end
%         input_map = is_solutions_marrts{rand_instance,:}.map;
%         position = is_solutions_marrts{rand_instance,:}.init_position;
%         goal = is_solutions_marrts{rand_instance,:}.goal;
%         % 运行MA-RRTs算法
%         marrts = MARRTs(input_map,position,goal,agent_count);                           % 初始化MARRTs算法，分配参数
%         marrts = runMARRTs(marrts);                                                     % 运行MARRTs算法
%         sol_marrts{rand_instance,repeat} = marrts;                                            % 结果存入数组
%         % 运行MA-RRTsFN算法
%         marrtsfn = MARRTsFN(input_map,position,goal,agent_count);                           % 初始化MARRTs算法，分配参数
%         marrtsfn = runRRTfn(marrtsfn);                                                     % 运行MARRTs算法
%         sol_marrtsfn{rand_instance,repeat} = marrtsfn;                                            % 结果存入数组
        % 运行单个rrt算法
        single_solution = [];                                                           % 单个智能体的解初始化为空
        for i = 1 : agent_count                                                         % 对每一个智能体，单独求一次解
            rrts = RRTs(input_map,A(i).position,A(i).goal,1);                           % 初始化RRT算法，分配参数
            rrts = runRRTs(rrts);                                                       % 运行rrt算法
            single_solution = [single_solution;rrts];                                   % 求得的解存储在single_solution中
        end
    %     % 运行isMA-RRTs算法
        is_marrts = MARRTs(input_map,position,goal,agent_count);                         % 初始化MARRTs算法，分配参数
        is_marrts = runMARRTs(is_marrts,single_solution);                                % 运行MARRTs算法
        sol_ismarrts{rand_instance,repeat} = is_marrts;                                          % 结果存入数组
%         % 运行isMA-RRTsFN算法
        is_marrtsfn = MARRTsFN(input_map,position,goal,agent_count);                         % 初始化MARRTs算法，分配参数
        is_marrtsfn = runRRTfn(is_marrtsfn,single_solution);                                % 运行MARRTs算法
        sol_ismarrtsfn{rand_instance,repeat} = is_marrtsfn;                                          % 结果存入数组
    end
end
% 保存结果
% solutions_marrts(:,:) = sol_marrts(:,:);
% solutions_marrtsfn(:,:) = sol_marrtsfn(:,:);
is_solutions_marrts(:,:) = sol_ismarrts(:,:);
is_solutions_marrtsfn(:,:) = sol_ismarrtsfn(:,:);
% save('all_marrts.mat','solutions_marrts','solutions_marrtsfn','is_solutions_marrts','is_solutions_marrtsfn'); 
save('all_repeat_all_marrts.mat','is_solutions_marrts','is_solutions_marrtsfn','-append');% 结果存入文件

%     single_solution = [];                                                           % 单个智能体的解初始化为空
%     for i = 1 : agent_count                                                         % 对每一个智能体，单独求一次解
%         rrts = RRTs(input_map,A(i).position,A(i).goal,1);                            % 初始化RRT算法，分配参数
%         rrts = runRRTs(rrts);                                                        % 运行rrt算法
%         single_solution = [single_solution;rrts];                                    % 求得的解存储在single_solution中
%     end
%     rrtfn = MARRTsFN(input_map,position,goal,agent_count);                               % 初始化RRT算法，分配参数
%     rrtfn = runRRTfn(rrtfn);%,single_solution);                                                            % 运行rrt算法并传入单个智能体运行的结果
%     marrts = MARRTs(input_map,position,goal,agent_count);                               % 初始化RRT算法，分配参数
%     marrts = runMARRTs(marrts);%,single_solution);                                                            % 运行rrt算法并传入单个智能体运行的结果
%     ymax = max(rrtfn.pathcost(:,1),marrts.pathcost(:,1));
%     ymin = min(marrts.pathcost(:,end),rrtfn.pathcost(:,end));
%     solutions_rrtfn{n} = rrtfn;
%     solutions_marrts{n} = marrts;
%     save('test.mat','marrts')
%     save('test.mat','solutions_rrtfn','solutions_marrts')    
% if ymin == ymax
%     axis_bias = 30;
% else
%     axis_bias = (ymax-ymin)/4;
% end
% plot(marrts.numiterations,marrts.pathcost,'DisplayName','maRRTs','Color','k');                                         % 绘制迭代次数和路径代价关系图
% hold on;
% plot(rrtfn.numiterations,rrtfn.pathcost,'DisplayName','maRRTsFN','Color','b');                                         % 绘制迭代次数和路径代价关系图
% ylim manual
% xlim manual
% ylim([ymin-axis_bias,ymax+axis_bias])
% xlim([0,rrtfn.maxiterations]);
% xticks(0:1000:5000);
% yticks(ymin:axis_bias:ymax);
% ax = gca;
% ax.FontSize = 13;
% % set(gca,'FontSize',11);
% title('One Agent Navigation');
% xlabel('Number of iterations');
% ylabel('Path Cost');
% legend('Location','southoutside','Orientation','horizontal');
% grid on;
% hold off;