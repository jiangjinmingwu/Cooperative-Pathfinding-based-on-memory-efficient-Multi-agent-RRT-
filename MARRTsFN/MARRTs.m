classdef MARRTs
    %UNTITLED2 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        map                 % 初始导入的地图
        init_position       % 初始智能体的位置集合
        goal                % 智能体的最终目标集合
        path                % 算出的路径
        n                   % 地图的格子数
        rows                % 地图的行数
        cols                % 地图的列数
        c_max               % greedy算法扩展的最大代价（树扩展时最大的边长）
        agent_count         % 智能体的数量
        cost                % 树中各节点到其父节点的边代价
        edges               % 树中各节点的边长
        nodes               % 树中的节点
        parent              % 节点的父节点
        max_runtime         % RRT最长运行时间
        possibility         % 采样点为目标点的概率
        pathcost            % 记录路径代价
%         numiterations       % 记录迭代次数
        maxiterations       % 最大迭代次数
        numnodes           	% 树中节点数
%         firstsol            % 第一个解
%         bestsol             % 最后的解
%         optisol             % 最好的解
%         runtime             % 返回第一个解的时间
    end
    
    methods
        function rrt = MARRTs(map,position,goal,Agent_count)                           % 初始化RRT算法
            %UNTITLED2 构造此类的实例
            %   此处显示详细说明
            rrt.map = map;                                                          % rrt算法的地图
            [rrt.rows,rrt.cols] = size(map);                                        % 返回地图的行数和列数分别赋值给rows和cols
            rrt.nodes = [];                                                         % 树中节点集初始化为空
            rrt.init_position = position;                                           % 所有智能体初始的位置
            rrt.goal = goal;                                                        % 所有智能体最终的目标
            rrt.n = rrt.rows * rrt.cols;                                            % 地图中的格子数
            rrt.agent_count = Agent_count;                                          % 存储智能体的数量
            rrt.c_max = 1.2*rrt.cols*rrt.agent_count;                               % greedy算法扩展的最大代价
            rrt.cost = 0;                                                           % 树中各节点到父节点的代价初始化,根节点的cost为0
            rrt.parent = 0;                                                         % 父节点数组初始化,根节点无父节点
            rrt.max_runtime = 5.000;                                                % RRT最长运行时间为5秒
%             rrt.runtime = Inf;                                                      % 返回第一个解的时间为无穷大
            rrt.possibility = 0.1;                                                  % 采样点为目标点的概率为0.1
            rrt.maxiterations = 5000;
%             rrt.optisol = sum(abs(position - goal));                                % 最好的解为欧式距离
        end
        
        function rrt = runMARRTs(rrt,single_solution)                                % 运行RRT算法
            %METHOD1 此处显示有关此方法的摘要
            %   此处显示详细说明
            rrt.nodes = rrt.init_position;                                          % 树中的节点，初始状态下只有智能体初始位置节点
            rrt.edges = {-1};                                                       % 树中边初始化为只有-1的元胞数组，代表根节点没有父节点，到父节点的边不存在
            iterations = 0;                                                         % 记录迭代的次数
            path_cost = [];                                                         % 记录每次迭代路径代价初始化为空
            num_nodes = [];                                                         % 记录树中的节点数目
            while true                                                                % 如果产生的随机数大于等于设定概率值
                if rand() < rrt.possibility %&& iterations > 100                   % 如果产生的随机数小于设定概率值
                    x_rand = rrt.goal;                                              % 采样点为目标点
                else
                    if nargin == 2                                                  % 如果输入参数为3
                        x_rand = SAMPLE(rrt,single_solution);                     % 则在联合状态空间随机采样一个节点并利用informed_node
                    else                                                            % 如果输入参数为2
                        x_rand = SAMPLE(rrt);                                     % 则只在联合状态空间采样
                    end
                end
                extend = EXTEND(rrt,rrt.nodes,rrt.edges,x_rand);                  % 向随机采样点扩展
                rrt.nodes = extend.nodes;                                           % 更新扩展得到的新树的点
                rrt.edges = extend.edges;                                           % 更新扩展得到的新树的边，每个孩子节点位置存储到父节点的边
                rrt.cost = extend.cost;                                             % 更新扩展得到的新点及邻近节点到树根节点的代价数组，每个孩子节点位置存储到父节点的边代价
                rrt.parent = extend.parent;                                         % 更新扩展得到的新树各节点的父节点数组，每个孩子节点位置存储其父节点在树中的索引
                iterations = iterations + 1;                                        % 迭代次数加1
                if iterations > rrt.maxiterations
                    flag = 0;
                    for i = 1:size(rrt.nodes,1)                                             % 对树中的每一个节点
                        if isequal(rrt.nodes(i,:),rrt.goal)                                 % 如果该节点和目标节点相等
                            goal_index = i;                                                 % 目标节点在树中的下标
                            index = goal_index;                                             % 存储目标节点在树中的下标
                            path_index = [];                                                % 下标序列作为路径初始化
                            while index ~= 0                                                % 直到并入根节点，循环结束
                                path_index = [path_index;index];                            % 将目标节点在树中的下标并入路径数组
                                index = rrt.parent(index);                                  % 目标节点更新为原目标节点的父节点
                            end
                            path_index = flipud(path_index);                                % 对路径数组进行翻转得到从起点到终点的路径
                            Path = {};                                                      % 边作为路径初始化
                            for k = 2 : size(path_index,1)                                  % 对除根节点的其余节点
                                Path = [Path;rrt.edges{path_index(k)}];                     % 将它们到父节点的边并入路径数组
                            end
                            rrt.path = Path;                                                % 最终得到的路径存储在rrt的path中
                            best_solution = COST(rrt,rrt.parent,rrt.cost,goal_index);
                            fprintf('number of iterations = %d, cost of path = %d\n',iterations,best_solution);
                            flag = 1;
                            break;
                        end
                    end
                    if flag == 0
                        for i = 2:size(rrt.edges,1)                                             % 对树中的每一条边
                            for j = 1:size(rrt.edges{i})                                        % 对这条边上的每一个路径点
                                if isequal(rrt.edges{i}(j),rrt.goal)                            % 如果该路径点等于目标节点
                                    rrt.nodes = [rrt.nodes;rrt.goal];                           % 则把目标节点并入树中
                                    rrt.parent = [rrt.parent;rrt.parent(i)];                    % 目标节点的父节点设置为该条边指向的父节点
                                    rrt.edges = [rrt.edges;rrt.edges{i}(1:j)];                  % 目标节点到父节点的边设置为该条边到j位置的边
                                    rrt.cost = [rrt.cost;rrt.agent_count*j];                    % 目标点到父节点的代价设置为边代价的上界
                                    goal_index = size(rrt.nodes,1);                             % 目标节点在树中的下标
                                    index = goal_index;
                                    path_index = [];                                            % 下标序列作为路径初始化
                                    while index ~= 0                                            % 直到并入根节点，循环结束
                                        path_index = [path_index;index];                        % 将目标节点在树中的下标并入路径数组
                                        index = rrt.parent(index);                              % 目标节点更新为原目标节点的父节点
                                    end
                                    path_index = flipud(path_index);                            % 对路径数组进行翻转得到从起点到终点的路径
                                    Path = {};                                                  % 边作为路径初始化
                                    for k = 2 : size(path_index,1)                              % 对除根节点的其余节点
                                        Path = [Path;rrt.edges{path_index(k)}];                 % 将它们到父节点的边并入路径数组
                                    end
                                    rrt.path = Path;                                            % 最终得到的路径存储在rrt的path中
                                    path_cost(iterations,:) = COST(rrt,rrt.parent,rrt.cost,goal_index);
                                    num_nodes(iterations,:) = size(rrt.nodes,1);
                                    fprintf('number of iterations = %d, num of nodes = %d, cost of path = %d\n',iterations,num_nodes(end,:),path_cost(end,:));
                                    flag = 1;
                                    break;
                                end
                            end
                            if flag
                                break;
                            end
                        end
                    end
                    % 画图
%                     if rrt.agent_count == 1
%                         figure(1);
%                         ylim manual
%                         xlim manual
%                         ylim([0,90]);
%                         xlim([0,90]);
%                         hold on;
%                         for i = 2:size(extend.nodes,1)
%                             plot(extend.nodes(i,1),extend.nodes(i,2),'bo','MarkerSize',2,'MarkerFaceColor','k');
% %                             x = [extend.nodes(extend.parent(i,:),1),extend.nodes(i,1)];
% %                             y = [extend.nodes(extend.parent(i,:),2),extend.nodes(i,2)];
% %                             line(x,y,'Color','cyan','LineWidth',3);
%                             for j = 1:size(extend.edges{i,1},1)
%                                 x = extend.edges{i,1}(:,1);
%                                 y = extend.edges{i,1}(:,2);
%                                 line(x,y,'Color','cyan','LineWidth',3);
%                             end
%                         end
%                         plot(rrt.nodes(1,1),rrt.nodes(1,2),'ko','MarkerSize',5,'MarkerFaceColor','k');
%                         plot(rrt.nodes(goal_index,1),rrt.nodes(goal_index,2),'ro','MarkerSize',5,'MarkerFaceColor','r');
% %                         for i = 2 : size(path_index,1)
% %                             x = [rrt.nodes(path_index(i-1),1),rrt.nodes(path_index(i),1)];
% %                             y = [rrt.nodes(path_index(i-1),2),rrt.nodes(path_index(i),2)];
% %                             line(x,y,'Color','red','LineWidth',1);
% %                         end
%                         for i = 1 : size(rrt.path,1)
%                             x = rrt.path{i,1}(:,1);
%                             y = rrt.path{i,1}(:,2);
%                             line(x,y,'Color','red','LineWidth',5);
%                         end
%                         drawnow;
%                         hold off;
%                     end
                    % 画图
                    rrt.pathcost = path_cost;
                    rrt.numnodes = num_nodes;
                    return;
                end
                flag = 0;
                for i = 1:size(rrt.nodes,1)                                             % 对树中的每一个节点
                    if isequal(rrt.nodes(i,:),rrt.goal)                                 % 如果该节点和目标节点相等
                        goal_index = i;                                                 % 目标节点在树中的下标
                        index = goal_index;                                             % 存储目标节点在树中的下标
                        path_index = [];                                                % 下标序列作为路径初始化
                        while index ~= 0                                                % 直到并入根节点，循环结束
                            path_index = [path_index;index];                            % 将目标节点在树中的下标并入路径数组
                            index = rrt.parent(index);                                  % 目标节点更新为原目标节点的父节点
                        end
                        path_index = flipud(path_index);                                % 对路径数组进行翻转得到从起点到终点的路径
                        Path = {};                                                      % 边作为路径初始化
                        for k = 2 : size(path_index,1)                                  % 对除根节点的其余节点
                            Path = [Path;rrt.edges{path_index(k)}];                     % 将它们到父节点的边并入路径数组
                        end
                        rrt.path = Path;                                                % 最终得到的路径存储在rrt的path中
                        path_cost(iterations,:) = COST(rrt,rrt.parent,rrt.cost,goal_index);
                        num_nodes(iterations,:) = size(rrt.nodes,1);
                        fprintf('number of iterations = %d, num of nodes = %d, cost of path = %d\n',iterations,num_nodes(end,:),path_cost(end,:));
                        flag = 1;
                        break;
                    end
                end                                                 
                if flag == 0
                    for i = 2:size(rrt.edges,1)                                             % 对树中的每一条边
                        for j = 1:size(rrt.edges{i})                                        % 对这条边上的每一个路径点
                            if isequal(rrt.edges{i}(j),rrt.goal)                            % 如果该路径点等于目标节点
                                rrt.nodes = [rrt.nodes;rrt.goal];                           % 则把目标节点并入树中
                                rrt.parent = [rrt.parent;rrt.parent(i)];                    % 目标节点的父节点设置为该条边指向的父节点
                                rrt.edges = [rrt.edges;rrt.edges{i}(1:j)];                  % 目标节点到父节点的边设置为该条边到j位置的边
                                rrt.cost = [rrt.cost;rrt.agent_count*j];                    % 目标点到父节点的代价设置为边代价的上界
                                goal_index = size(rrt.nodes,1);                             % 目标节点在树中的下标
                                index = goal_index;
                                path_index = [];                                            % 下标序列作为路径初始化
                                while index ~= 0                                            % 直到并入根节点，循环结束
                                    path_index = [path_index;index];                        % 将目标节点在树中的下标并入路径数组
                                    index = rrt.parent(index);                              % 目标节点更新为原目标节点的父节点
                                end
                                path_index = flipud(path_index);                            % 对路径数组进行翻转得到从起点到终点的路径
                                Path = {};                                                  % 边作为路径初始化
                                for k = 2 : size(path_index,1)                              % 对除根节点的其余节点
                                    Path = [Path;rrt.edges{path_index(k)}];                 % 将它们到父节点的边并入路径数组
                                end
                                rrt.path = Path;                                            % 最终得到的路径存储在rrt的path中
                                path_cost(iterations,:) = COST(rrt,rrt.parent,rrt.cost,goal_index);
                                num_nodes(iterations,:) = size(rrt.nodes,1);
                                fprintf('number of iterations = %d, num of nodes = %d, cost of path = %d\n',iterations,num_nodes(end,:),path_cost(end,:));
                                flag = 1;
                                break;
                            end
                        end
                        if flag
                            break;
                        end
                    end
                end
            end
        end
        
        function rand_node = SAMPLE(rrt,single_solution)                          % 在联合状态空间随机采样一个节点
            valid = false;                                                          % 联合状态节点初始化有效程度为否                                                                                   % 如果所有智能体采样点有效，则联合采样点有效
            while valid == false                                                    % 当智能体1采样点无效时，循环进行
                rand_sample = [ceil((rrt.rows-1)*rand),ceil((rrt.cols-1)*rand)];    % 在地图上随机产生一点作为随机点
                if (rrt.map(rand_sample(1),rand_sample(2)) ~= 1)           % 当采样点不是障碍物时【可以是其他智能体初始位置，或目标位置】可以充分向空间采样，所有状态只是中间状态
                    rand_node = rand_sample;                                        % 存储随机采样点
                    valid = true;                                                   % 智能体1采样点有效程度为真
                end
            end
            if rrt.agent_count > 1                                                  % 如果智能体数量大于1
                for j = 2 : rrt.agent_count                                         % 则对其余智能体进行采样
                    valid = false;                                                  % 联合状态节点初始化有效程度为否
                    while valid == false                                            % 当智能体j采样点无效时，循环进行
                        rand_sample = [ceil((rrt.rows-1)*rand),ceil((rrt.cols-1)*rand)];        % 在地图上随机采样一点作为随机点
                        if(rrt.map(rand_sample(1),rand_sample(2)) ~= 1)                         % 采样点不是障碍物时
                            rand_node = [rand_node,rand_sample];                                % 存储采样点
                            valid = true;                                                       % 采样点有效程度为真
                        end
                    end
                end
            end
            if nargin == 2                                                                      % 如果输入参数数目等于3
                solution_cost = zeros(rrt.agent_count,1);                                       % 解的代价初始化为0
                max_cost = 0;                                                                   % 解的最大代价初始化为0
                for i = 1 : rrt.agent_count                                                     % 对每一个智能体的解
                    if ~isempty(single_solution(i).path)                                        % 如果解路径不为空
                        for j = 1 : size(single_solution(i).path,1)                             % 对解的每一条边
                            solution_cost(i) = solution_cost(i) + size(single_solution(i).path{j},1);   % 计算它们的长度并累加到解代价数组中
                        end
                        if solution_cost(i) > max_cost                                          % 如果计算出的解的代价大于最大代价
                            max_cost = solution_cost(i);                                        % 则最大代价更新为该解的代价
                        end
                    end
                end
                rand_cost = ceil(rand()*max_cost);                                              % 在最大代价范围内随机选择一个代价值
                informed_rand = zeros(rrt.agent_count*2,1);                                     % 随机节点初始化为0                                                         
                for i = 1 : rrt.agent_count                                                     % 对每一个智能体找到其随机路径点
                    cumul_cost = 0;                                                             % 累加代价初始化为0
                    if ~isempty(single_solution(i).path)                                        % 如果解路径不为空
                        for j = 1 : size(single_solution(i).path,1)                             % 对解的每一条边
                            old_cumul_cost = cumul_cost;                                        % 备份原来的累加代价
                            cumul_cost = cumul_cost + size(single_solution(i).path{j},1);       % 依次累加
                            if cumul_cost >= rand_cost                                           % 如果第一条边以内发现累加代价大于随机代价
                                if j == 1                                 
                                    informed_rand((2*i-1):2*i) = single_solution(i).path{j}(rand_cost,:); % 则随机节点等于以rand_cost值为索引的路径点
                                    break;
                                else
                                    if rand_cost-old_cumul_cost < 1 || rand_cost-old_cumul_cost > size(single_solution(i).path{j},1)
                                        a = 1;
                                    end
                                    informed_rand((2*i-1):2*i) = single_solution(i).path{j}(rand_cost-old_cumul_cost,:);% 则随机节点等于以该随机代价减去上一次累计代价的值为索引的路径点 
                                    break;
                                end
                            end
                            if cumul_cost < rand_cost && j == size(single_solution(i).path,1)   % 如果到最后一条边发现累加代价还是小于随机代价
                                informed_rand((2*i-1):2*i) = single_solution(i).path{j}(end,:); % 则随机节点等于最后一条边上最后一个路径点
                                break;
                            end
                        end
                        informed_rand(2*i-1) = ceil(informed_rand(2*i-1) + normrnd(0,1) * 0.5);   % 随机点行位置在原位置偏移一个正态分布随机数乘0.5的距离
                        informed_rand(2*i) = ceil(informed_rand(2*i) + normrnd(0,1) * 0.5);       % 随机点列位置在原位置偏移一个正态分布随机数乘0.5的距离
%                         nearest_node = NEAREST(single_solution(i),single_solution(i).nodes,informed_rand((2*i-1):2*i));   % 在智能体i的树中找到距离该随机点最近的节点
%                         informed_rand((2*i-1):2*i) = nearest_node.node;                           % 随机点更新为该最近的节点
                    end
                end
                for i = 1:2:size(rand_node,2)                                           % 对每个智能体采样的一对随机节点
                    if ~isequal(informed_rand(i:i+1),[0,0])                             % 如果该智能体informed采样的结果不为【0，0】
                        rand_node(i:i+1) = informed_rand(i:i+1);                        % 则该对随机节点替换为informed采样的结果
                    end
                end
            end
        end
        
        function extend = EXTEND(rrt,nodes,edges,x)                               % 向随机采样点x扩展
            tree_nodes = nodes;                                                     % 备份树节点
            tree_edges = edges;                                                     % 备份树的边
            Parent = rrt.parent;                                                    % 父节点数组初始化
            Cost = rrt.cost;                                                        % 备份各节点到根节点的代价
            x_nearest = NEAREST(rrt,nodes,x);                                       % 找到距离最近的树中的节点
            greedy = GREEDY(rrt,x_nearest.node,x);                                % 用搜索算法找到新节点和路径
            x_new = greedy.x_new;                                                   % 存储x_new节点
            p_new = greedy.Path;                                                    % 存储x_nearest到x_new的边
            c_nearest_new = greedy.cost;                                            % 存储x_nearest到x_new的边代价
            if ~isempty(p_new)                                                      % 如果到新节点有边 
                alreadyintree = 0;                                                  % 新节点在树中的的标志位
                for i = 1:size(tree_nodes,1)                                        % 对树中每一个节点
                    if isequal(tree_nodes(i,:),x_new)                              % 如果x_new已经在树中
                        alreadyintree = 1;
                        break;
                    end
                end
                if alreadyintree == 1                                               % 如果新节点已经在树中
                    extend.nodes = tree_nodes;                                          % 返回新树的节点
                    extend.edges = tree_edges;                                          % 返回新树的边
                    extend.parent = Parent;                                             % 返回新树的parent数组
                    extend.cost = Cost;                                                 % 返回新树的Cost数组
                    return;                                                         % 则不必进行更新
                end
                % 画图
%                 if size(tree_nodes,1) > 500
%                     if rrt.agent_count == 1
%                         figure(2);
%                         clf(figure(2),'reset');
%                         ylim manual
%                         xlim manual
%                         ylim([0,90]);
%                         xlim([0,90]);
%                         hold on;
%                         for k = 2:size(tree_nodes,1)
%                             plot(tree_nodes(k,1),tree_nodes(k,2),'bo','MarkerSize',2,'MarkerFaceColor','k');
%     %                                 x = [tree_nodes(Parent(k,:),1),tree_nodes(k,1)];
%     %                                 y = [tree_nodes(Parent(k,:),2),tree_nodes(k,2)];
%     %                                 line(x,y,'Color','cyan','LineWidth',3);
%                             x = tree_edges{k,1}(:,1);
%                             y = tree_edges{k,1}(:,2);
%                             line(x,y,'Color','cyan','LineWidth',3);
%                         end
%                         plot(tree_nodes(1,1),tree_nodes(1,2),'ko','MarkerSize',5,'MarkerFaceColor','k');
%                         drawnow;
%                     end
%                 end
                % 画图
                tree_nodes = [tree_nodes;x_new];                                    % 将x_new并入备份树节点中
                c_new = COST(rrt,Parent,Cost,x_nearest.indx) + c_nearest_new;       % x_new的父节点初始化为x_nearest，到根节点的代价初始化为x_nearest到根节点的代价加x_nearest到x_new的代价
                c_new_parent = c_nearest_new;                                       % x_new到父节点的边初始化为x_nearest到x_new的边代价
                Parent = [Parent;x_nearest.indx];                                   % 将新节点的父节点设置为x_nearest
                x_near = NEAR(rrt,nodes,x_new,size(nodes,1));                       % 找到以x_new为中心的领域内的节点
                flag = 0;                                                           % 设置标记，标记成为x_new父节点的x_near节点
                if ~isempty(x_near.nodes)                                           % 如果邻近节点集非空
                    % 画图
%                     rectangle('Position',[x_new(1,1)-x_near.radius,x_new(1,2)-x_near.radius,x_near.radius*2,x_near.radius*2],'Curvature',[1 1]);
%                     plot(x_new(1,1),x_new(1,2),'bo','MarkerSize',2,'MarkerFaceColor','r');
                    % 画图
                    for i = 1:size(x_near.nodes,1)                                  % 对这些节点
                        near_new = GREEDY(rrt,x_near.nodes(i,:),x_new);           % 用搜索算法从x_near向x_new扩展
                        if isequal(near_new.x_new,x_new)                            % 如果扩展得到的新节点和x_new相等（说明它们之间可以有直接的边相连）
                            c_new_bynear = COST(rrt,Parent,Cost,x_near.index(i)) + near_new.cost;   % 如果以x_near为父母节点，则x_new的代价为x_near到根节点的代价加x_near到x_new的代价
                            if c_new_bynear < c_new                                 % 如果该代价比以x_nearest为父节点代价更低
                                c_new = c_new_bynear;                               % 更新x_new到根节点的代价
                                c_new_parent = near_new.cost;                       % 存储x_new到父节点的代价
                                p_new = near_new.Path;                              % 更新x_new节点指向父节点的边
                                Parent(end,:) = [];                                 % 删除父节点数组最后一行
                                Parent = [Parent;x_near.index(i)];                  % 将x_near设置为x_new的父节点
                                flag = i;                                           % 对序号i做标记
                            end
                        end
                    end
                end
                Cost = [Cost;c_new_parent];                                           % 新节点到父节点的代价存入代价数组
                tree_edges = [tree_edges;p_new];                                    % 树中的边更新
                % 画图
%                 x = tree_edges{end,1}(:,1);
%                 y = tree_edges{end,1}(:,2);
%                 line(x,y,'Color','cyan','LineWidth',3);
                % 画图
                if ~isempty(x_near.nodes)                                           % 如果邻近节点集非空
                    for i = 1:size(x_near.nodes,1)                                  % 对以x_new为中心的邻域内的所有节点
                        if i == flag                                                % 除了x_new的父节点以外
                            continue;
                        end
                        new_near = GREEDY(rrt,x_new,x_near.nodes(i,:));           % 从x_new向x_near扩展
                        if isequal(new_near.x_new,x_near.nodes(i,:)) && COST(rrt,Parent,Cost,x_near.index(i)) > c_new + new_near.cost  % 如果扩展得到的新点是x_near节点并且以x_new作为x_near的父节点得到的代价比x_near在树中的原代价小
                            Parent(x_near.index(i)) = size(Parent,1);               % x_near的父节点在树中的索引等于最后一个节点x_new的索引
                            tree_edges{x_near.index(i),:} = new_near.Path;          % x_near指向其父节点的边更新为指向x_new的边
                            Cost(x_near.index(i)) = new_near.cost;                  % x_near指向其父节点的边代价更新
                        end
                    end
                end
            end
            extend.nodes = tree_nodes;                                          % 返回新树的节点
            extend.edges = tree_edges;                                          % 返回新树的边
            extend.parent = Parent;                                             % 返回新树的parent数组
            extend.cost = Cost;                                                 % 返回新树的Cost数组
        end
        
        function cumulative_cost = COST(rrt,Parent,Cost,node_index)                         % 计算节点到根节点的代价
            index = node_index;                                                 % 存储节点在树中的索引
            cumulative_cost = 0;                                                % 节点到根节点的代价初始化为0
            while ~isequal(index,1)                                             % 依次累加代价，直到根节点
                cumulative_cost = cumulative_cost + Cost(index);            % 累加当前节点指向其父节点的边的代价
                index = Parent(index);                                      % 索引更新为当前节点的父节点
            end
        end
        
        function nearest = NEAREST(rrt,Nodes,x)
            min_dist = Inf;                                                         % 初始化最小距离为无穷大
            for i = 1 : size(Nodes,1)                                              % 对树中的每一个节点都计算一次距离，取距离最小的节点
                dist = DIST(rrt,Nodes(i,:),x);                                      % 计算两个节点之间的距离
                if dist < min_dist                                                  % 找到距离采样点最小的节点
                    min_dist = dist;                                                % 更新最小距离
                    nearest.node = Nodes(i,:);                                      % 存储最小距离节点
                    nearest.indx = i;                                               % 存储最小距离节点在树中的索引
                end
            end
        end
        
        function dist = DIST(rrt,star,dest)
            distance = abs(star - dest);                                            % 计算起点和终点的距离
            dist = sum(distance);                                                   % 计算标量总距离
        end
        
        function greedy = GREEDY(rrt,start,dest)                                  % 搜索算法
            x = start;                                                              % x作为起始点
            x_new = zeros(1,rrt.agent_count*2);                                     % Xnew初始化
            c = 0;                                                                  % 路径代价初始化为0                                                              
            Path = zeros(rrt.c_max,rrt.agent_count*2);                              % 所有智能体路径初始化，为空数组
            waypoint = zeros(rrt.agent_count,2);                                    % 路径点矩阵初始化
            loop_count = 0;                                                         % 循环次数初始化为0
            Map = repmat(rrt.map,1,1,rrt.agent_count);                              % 每个智能体保存一份地图
            while ~isequal(x,dest) && (c <= rrt.c_max)                              % 当还没有扩展到随机节点或者扩展的节点的总代价小于最大代价限制
                flag1 = 0;                                                          % 标志位清零，代表走入死胡同的智能体的数量
                old_c = c;                                                          % 存储上一次循环的代价值
                old_waypoint = waypoint;                                            % 存储上一次的路径点
                for i = 1:2:size(x,2)                                               % 对每个智能体在x位置的坐标(Xi，X(i+1)) 
                    j = (i+1)/2;                                                    % 取当前智能体的下标
                    x_j = [x(i),x(i+1)];                                            % 取智能体j的x位置
                    dest_j = [dest(i),dest(i+1)];                                   % 存储智能体j的目标位置
                    if isequal(x_j,dest_j)                                          % 如果智能体j到达其目的地
                        waypoint(j,:) = x_j;                                            % 则智能体j在目标位置原地不动，等待其余智能体
                        flag1 = flag1 + 1;                                          % 统计到达目的地的智能体
                        continue;                                                   % 计算下一个智能体的路径
                    end
                    % 找到其在网格图中的孩子（相邻）节点并入相邻节点表---------------------------------------------------------------
%                     child_nodes = children(rrt,A(j).map,x_j(1),x_j(2));             % 找到其在网格图中的孩子（相邻）节点并入相邻节点表
                    child_nodes = zeros(4,2);                                       % 孩子节点集初始化
                    index = 0;                                                              % 数组索引初始化为0
                    Y = x_j(1);
                    X = x_j(2);
                    if Y-1 > 0 && rrt.map(Y-1,X) ~= 1                                            % 如果该节点的上方节点在地图内且不是障碍物
                        index = index + 1;                                                  % 数组索引加1
                        child_nodes(index,:) = [Y-1,X];                                     % 则该节点存入孩子节点集
                    end
                    if Y+1 <= rrt.rows && rrt.map(Y+1,X) ~= 1                                    % 如果该节点的下方节点在地图内且不是障碍物
                        index = index + 1;                                                  % 数组索引加1
                        child_nodes(index,:) = [Y+1,X];                                     % 则该节点存入孩子节点集
                    end
                    if X-1 > 0 && rrt.map(Y,X-1) ~= 1                                            % 如果该节点的左方节点在地图内且不是障碍物
                        index = index + 1;                                                  % 数组索引加1
                        child_nodes(index,:) = [Y,X-1];                                     % 则该节点存入孩子节点集
                    end
                    if X+1 <= rrt.cols && rrt.map(Y,X+1) ~= 1                                    % 如果该节点的右方节点在地图内且不是障碍物
                        index = index + 1;                                                  % 数组索引加1
                        child_nodes(index,:) = [Y,X+1];                                     % 则该节点存入孩子节点集
                    end
                    if index < 4
                        child_nodes((index+1):end,:) = [];                                  % 把为0的行删除
                    end
                    % 找到其在网格图中的孩子（相邻）节点并入相邻节点表---------------------------------------------------------------
                    if ~isempty(child_nodes)                                        % 如果孩子节点不为空则将最小H值孩子添加为路径点
                        % 找到最小H值节点------------------------------------------------------------------------------------------
                        min_H = Inf;                                                            % 最小距离初始化
                        for k = 1:size(child_nodes,1)                                              % 对每个孩子节点
                            distance = abs(child_nodes(k,:) - dest_j);                                            % 计算起点和终点的距离
                            H_value = sum(distance) + rand;                                        % 计算标量总距离加上小于1的偏移预防H值相等
%                             H_value = DIST(rrt,child_nodes(i,:),dest_j) + rand;                      % 计算其到目标点的H值,加上小于1的偏移预防H值相等
                            if H_value < min_H
                                min_H = H_value;                                                % 则最小H值更新
                                x_min = child_nodes(k,:);                                    % 存储该孩子节点
                            end
                        end
%                         x_min = minHvalueNode(rrt,child_nodes,dest_j);              % 找到孩子节点集表中启发函数值最小的节点 
                        % 找到最小H值节点------------------------------------------------------------------------------------------
                        waypoint(j,:) = x_min;                                          % 智能体j增加该点为路径点
                        c = c + 1;                                                  % 代价加1
                        x(i:i+1) = x_min;                                           % 更新智能体j的x位置以判断是否到达目的地
                    else                                                            % 如果孩子节点为空（代表此时本身无路可走或者走入死胡同）
                        waypoint(j,:) = [x(i),x(i+1)];                                  % 将智能体j的起点加入路径上代表无路径
                        flag1 = flag1 + 1;                                          % 统计无路径的智能体的数量
                    end                                                             
                end
%                 Path(1,:) = start(:);
                loop_count = loop_count + 1;                                        % 循环次数加1（循环几次路径点就增加几个）
                old_x_new = x_new;                                                  % 存储原来的Xnew节点
                x_new = x;                                                          % 更新Xnew节点
                old_path = Path;                                                    % 存储原来的所有智能体路径
                if flag1 == rrt.agent_count                                         % 如果智能体起点无路径的数量和到达目的地的数量加和等于所有智能体（该条件第一次循环不会进入）
                    for i = 1:2:rrt.agent_count*2                                   % 把所有智能体路径存入路径数组
                        Path(loop_count,i:i+1) = waypoint((i+1)/2,:);                 % 存储所有智能体路径
                    end
                    Path(all(Path==0,2),:) = [];
%                     Path(loop_count,:) = reshape(waypoint',[1,rrt.agent_count*2]);
                    break;                                                          % 跳出while循环
                end
                % 检查智能体路径是否碰撞-------------------------------------------------------------------------------------------
                no_collision = 1;                                                   % 只有一个智能体则路径不干涉
                if rrt.agent_count > 1                                              % 检查智能体数量，如果大于1
                    for m = 1 : (rrt.agent_count - 1)                               % 所有智能体两两组合依次检查
                        for p = (m+1) : rrt.agent_count
                            distance = abs(waypoint(m,:) - waypoint(p,:));                  % 计算两智能体对应时间两点的距离
                            dist = sum(distance);                                   % 计算标量总距离
%                             if DIST(rrt,A(m).path(:),A(p).path(:)) < 2              % 如果当前两智能体距离小于3，则判断为碰撞
                            if dist < 2                                             % 如果当前两智能体距离小于3，则判断为碰撞
                                if dist == 0
                                    no_collision = 0;
                                    break;
                                else
                                    if isequal(old_waypoint(m,:),waypoint(p,:)) &&...
                                            isequal(old_waypoint(p,:),waypoint(m,:)) % 如果前一步两个智能体的位置和这一步两个智能体的位置交换
                                        no_collision = 0;
                                        break;
                                    end
                                end
                            end   
                        end
                        if no_collision == 0
                            break;
                        end
                    end
                end
%                 if ~collisionfree(rrt,A)                                            % 如果所有智能体路径相互干涉或者和障碍物干涉
                % 检查智能体路径是否碰撞-------------------------------------------------------------------------------------------
                if ~no_collision                                                    % 如果智能体路径相互干涉
                    old_path(all(old_path==0,2),:) = [];
                    greedy.Path = old_path;                                         % 返回原来的所有智能体路径
                    greedy.x_new = old_x_new;                                       % 返回原来的Xnew节点
                    greedy.cost = old_c;                                            % 返回原来所有智能体路径的代价
                    return;
                end
                % 更新智能体路径
                for i = 1:2:rrt.agent_count*2                                       % 把所有智能体路径存入路径数组
                    Path(loop_count,i:i+1) = waypoint((i+1)/2,:);                       % 存储所有智能体路径
                end
                % 更新智能体路径
            end
            Path(all(Path==0,2),:) = [];
            greedy.x_new = x_new;                                                   % 返回当前的Xnew节点
            greedy.Path = Path;                                                     % 返回当前到Xnew的边
            greedy.cost = c;                                                        % 返回当前到Xnew的边代价
        end
        
        function child_nodes = children(rrt,Gm,Y,X)                                 % 找到x在网格图中的孩子（相邻）节点，按上下左右的顺序存入near_nodes
            child_nodes = zeros(4,2);                                               % 孩子节点集初始化
            index = 0;                                                              % 数组索引初始化为0
            if Y-1 > 0 && Gm(Y-1,X) ~= 1                                            % 如果该节点的上方节点在地图内且不是障碍物
                index = index + 1;                                                  % 数组索引加1
                child_nodes(index,:) = [Y-1,X];                                     % 则该节点存入孩子节点集
            end
            if Y+1 <= rrt.rows && Gm(Y+1,X) ~= 1                                    % 如果该节点的下方节点在地图内且不是障碍物
                index = index + 1;                                                  % 数组索引加1
                child_nodes(index,:) = [Y+1,X];                                     % 则该节点存入孩子节点集
            end
            if X-1 > 0 && Gm(Y,X-1) ~= 1                                            % 如果该节点的左方节点在地图内且不是障碍物
                index = index + 1;                                                  % 数组索引加1
                child_nodes(index,:) = [Y,X-1];                                     % 则该节点存入孩子节点集
            end
            if X+1 <= rrt.cols && Gm(Y,X+1) ~= 1                                    % 如果该节点的右方节点在地图内且不是障碍物
                index = index + 1;                                                  % 数组索引加1
                child_nodes(index,:) = [Y,X+1];                                     % 则该节点存入孩子节点集
            end
            if index < 4
                child_nodes((index+1):end,:) = [];                                  % 把为0的行删除
            end
        end
        
        function min_node = minHvalueNode(rrt,children,dest)                        % 找到具有最小H值的孩子节点
            min_H = Inf;                                                            % 最小距离初始化
            for i = 1:size(children,1)                                              % 对每个孩子节点     
                H_value = DIST(rrt,children(i,:),dest) + rand;                      % 计算其到目标点的H值,加上小于1的偏移预防H值相等
                if H_value < min_H
                    min_H = H_value;                                                % 则最小H值更新
                    backup_node = children(i,:);                                    % 存储该孩子节点
                end
            end
            min_node = backup_node;                                                 % 最小H值节点返回
        end
        
        function no_collision = collisionfree(rrt,waypoint)                                % 如果所有路径不相互干涉则返回1，否则返回0
            no_collision = 1;                                                       % 假设所有智能体路径不干涉
            if rrt.agent_count == 1                                                 % 检查智能体数量，如果为1
                no_collision = 1;                                                   % 则永远不会存在干涉问题
            else
                for m = 1 : (rrt.agent_count - 1)                                   % 所有智能体两两组合依次检查
                    for p = (m+1) : rrt.agent_count
                        if DIST(rrt,waypoint(m,:),waypoint(p,:)) < 3                    % 如果当前两智能体距离小于3，则判断为碰撞
                            no_collision = 0;
                            return;
                        end   
                    end
                end
            end                                                       
        end
        
        function near = NEAR(rrt,nodes,x_new,n)                                     % 找到x_new为中心的领域内的节点
            near.nodes = [];                                                        % 初始化near_node
            near.index = [];                                                        % 初始化near_index
            num = 0;
            gamma = 1.2*rrt.cols*rrt.agent_count;                                   % Michal Cap 2013论文中定义的gamma值
            eta = rrt.c_max * rrt.agent_count;                                      % Michal Cap 2013论文中定义的eta值
            d = rrt.agent_count*2;                                                  % Michal Cap 2013论文中定义的dimentions值
            radius = min([gamma*(log(n)/n)^(1/d),eta]);                             % karaman 2011论文中定义的NEAR半径公式
            for i = 1 : size(nodes,1)                                               % 对树中的每个节点
                if DIST(rrt,nodes(i,:),x_new) <= radius                             % 如果该节点和x_new的距离小于radius
                    num = num + 1;
                    near.nodes(num,:) = nodes(i,:);                                 % 则将该节点加入邻近节点
                    near.index(num,:) = i;                                          % 将该节点的索引存入index
                end
            end
        end
    end
end

