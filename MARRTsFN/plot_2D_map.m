% solutions_marrts = cell(12,1);
sol_marrts = cell(12,1);                                                         % 临时变量初始化
sol_marrtsfn = cell(12,1);

% sol_ismarrts = cell(12,1);
% sol_ismarrtsfn = cell(12,1);
for rand_instance = 1 : 1
    agent = 1;
    map_index = 5;
    % 智能体数量，地图初始化
    choose_map = {zeros(10,10);zeros(30,30);zeros(50,50);zeros(70,70);zeros(90,90)}; % 地图选择器初始化
    input_map = choose_map{map_index,1};                                    % 地图初始化     
    agent_count = agent;                                                    % 智能体的数量，初始化     
    [rows,cols] = size(input_map);                                          % 地图的行数和列数
    % 初始化障碍物位置
    x1 = 10 : 20;
    y1 = 10 : 20;
    x2 = 10 : 30;
    y2 = 40 : 50;
    x3 = 80;
    y3 = 10 : 30;
    x4 = 50 : 70;
    y4 = 60 : 70;
    x5 = 60 : 70;
    y5 = 70 : 80;
    x6 = 50 : 60;
    y6 = 20 : 50;
    x7 = 40 : 50;
    y7 = 30 : 40;
    for i = 60 : x3
        input_map(i:x3,y3(i-59)) = 1;
    end
    input_map(x1,y1) = 1;                                                   % 随机选择1个网格作为障碍物格子
    input_map(x2,y2) = 1;                                                   % 随机选择1个网格作为障碍物格子
    input_map(x4,y4) = 1;                                                   % 随机选择1个网格作为障碍物格子
    input_map(x5,y5) = 1;                                                   % 随机选择1个网格作为障碍物格子
    input_map(x6,y6) = 1;
    input_map(x7,y7) = 1;
%     clf(figure(1),'reset');
    clf(figure(2),'reset');
%     figure(1);
%     patch([x1(1) x1(end) x1(end) x1(1)],[y1(1) y1(1) y1(end) y1(end)],'red');
%     patch([x2(1) x2(end) x2(end) x2(1)],[y2(1) y2(1) y2(end) y2(end)],'red');
%     patch([x4(1) x4(end) x4(end) x5(1) x5(1) x4(1)],[y4(1) y4(1) y5(end) y5(end) y4(end) y4(end)],'red');
%     patch([x6(1) x6(end) x6(end) x6(1) x6(1) x7(1) x7(1) x6(1) x6(1)],[y6(1) y6(1) y6(end) y6(end) y7(end) y7(end) y7(1) y7(1) y6(1)],'red');
%     patch([60 x3 x3],[y3(1) y3(1) y3(end)],'red');
    figure(2);
    patch([x1(1) x1(end) x1(end) x1(1)],[y1(1) y1(1) y1(end) y1(end)],'red');
    patch([x2(1) x2(end) x2(end) x2(1)],[y2(1) y2(1) y2(end) y2(end)],'red');
    patch([x4(1) x4(end) x4(end) x5(1) x5(1) x4(1)],[y4(1) y4(1) y5(end) y5(end) y4(end) y4(end)],'red');
    patch([x6(1) x6(end) x6(end) x6(1) x6(1) x7(1) x7(1) x6(1) x6(1)],[y6(1) y6(1) y6(end) y6(end) y7(end) y7(end) y7(1) y7(1) y6(1)],'red');
    patch([60 x3 x3],[y3(1) y3(1) y3(end)],'red');
    % 初始化智能体位置和目标
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
    position = [55,85];
    goal = [60,15];
%     input_map = solutions_marrtsfn{rand_instance,:}.map;
%     position = solutions_marrtsfn{rand_instance,:}.init_position;
%     goal = solutions_marrtsfn{rand_instance,:}.goal;
    % 运行MA-RRTs算法
%     marrts = MARRTs(input_map,position,goal,agent_count);                           % 初始化MARRTs算法，分配参数
%     marrts = runMARRTs(marrts);                                                     % 运行MARRTs算法
%     sol_marrts{rand_instance} = marrts;                                            % 结果存入数组
%     % 运行MA-RRTsFN算法
    marrtsfn = MARRTsFN(input_map,position,goal,agent_count);                           % 初始化MARRTs算法，分配参数
    marrtsfn = runRRTfn(marrtsfn);                                                     % 运行MARRTs算法
    sol_marrtsfn{rand_instance} = marrtsfn;                                            % 结果存入数组
%     % 运行单个rrt算法
%     single_solution = [];                                                           % 单个智能体的解初始化为空
%     for i = 1 : agent_count                                                         % 对每一个智能体，单独求一次解
%         rrts = RRTs(input_map,A(i).position,A(i).goal,1);                           % 初始化RRT算法，分配参数
%         rrts = runRRTs(rrts);                                                       % 运行rrt算法
%         single_solution = [single_solution;rrts];                                   % 求得的解存储在single_solution中
%     end
%     % 运行isMA-RRTs算法
%     is_marrts = MARRTs(input_map,position,goal,agent_count);                         % 初始化MARRTs算法，分配参数
%     is_marrts = runMARRTs(is_marrts,single_solution);                                % 运行MARRTs算法
%     sol_ismarrts{rand_instance} = is_marrts;                                          % 结果存入数组
%     % 运行isMA-RRTsFN算法
%     is_marrtsfn = MARRTsFN(input_map,position,goal,agent_count);                         % 初始化MARRTs算法，分配参数
%     is_marrtsfn = runRRTfn(is_marrtsfn,single_solution);                                % 运行MARRTs算法
%     sol_ismarrtsfn{rand_instance} = is_marrtsfn;                                          % 结果存入数组
end
% 保存结果
% solutions_marrts(:) = sol_marrts(:);
% solutions_marrtsfn(:) = sol_marrtsfn(:);
% is_solutions_marrts(:) = sol_ismarrts(:);
% is_solutions_marrtsfn(:) = sol_ismarrtsfn(:);
% save('all_marrts.mat','solutions_marrts','solutions_marrtsfn','is_solutions_marrts','is_solutions_marrtsfn'); 
% save('all_marrts.mat','solutions_marrts','-append');% 结果存入文件