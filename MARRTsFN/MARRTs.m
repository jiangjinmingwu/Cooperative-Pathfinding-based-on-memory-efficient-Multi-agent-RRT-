classdef MARRTs
    %UNTITLED2 �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    
    properties
        map                 % ��ʼ����ĵ�ͼ
        init_position       % ��ʼ�������λ�ü���
        goal                % �����������Ŀ�꼯��
        path                % �����·��
        n                   % ��ͼ�ĸ�����
        rows                % ��ͼ������
        cols                % ��ͼ������
        c_max               % greedy�㷨��չ�������ۣ�����չʱ���ı߳���
        agent_count         % �����������
        cost                % ���и��ڵ㵽�丸�ڵ�ıߴ���
        edges               % ���и��ڵ�ı߳�
        nodes               % ���еĽڵ�
        parent              % �ڵ�ĸ��ڵ�
        max_runtime         % RRT�����ʱ��
        possibility         % ������ΪĿ���ĸ���
        pathcost            % ��¼·������
%         numiterations       % ��¼��������
        maxiterations       % ����������
        numnodes           	% ���нڵ���
%         firstsol            % ��һ����
%         bestsol             % ���Ľ�
%         optisol             % ��õĽ�
%         runtime             % ���ص�һ�����ʱ��
    end
    
    methods
        function rrt = MARRTs(map,position,goal,Agent_count)                           % ��ʼ��RRT�㷨
            %UNTITLED2 ��������ʵ��
            %   �˴���ʾ��ϸ˵��
            rrt.map = map;                                                          % rrt�㷨�ĵ�ͼ
            [rrt.rows,rrt.cols] = size(map);                                        % ���ص�ͼ�������������ֱ�ֵ��rows��cols
            rrt.nodes = [];                                                         % ���нڵ㼯��ʼ��Ϊ��
            rrt.init_position = position;                                           % �����������ʼ��λ��
            rrt.goal = goal;                                                        % �������������յ�Ŀ��
            rrt.n = rrt.rows * rrt.cols;                                            % ��ͼ�еĸ�����
            rrt.agent_count = Agent_count;                                          % �洢�����������
            rrt.c_max = 1.2*rrt.cols*rrt.agent_count;                               % greedy�㷨��չ��������
            rrt.cost = 0;                                                           % ���и��ڵ㵽���ڵ�Ĵ��۳�ʼ��,���ڵ��costΪ0
            rrt.parent = 0;                                                         % ���ڵ������ʼ��,���ڵ��޸��ڵ�
            rrt.max_runtime = 5.000;                                                % RRT�����ʱ��Ϊ5��
%             rrt.runtime = Inf;                                                      % ���ص�һ�����ʱ��Ϊ�����
            rrt.possibility = 0.1;                                                  % ������ΪĿ���ĸ���Ϊ0.1
            rrt.maxiterations = 5000;
%             rrt.optisol = sum(abs(position - goal));                                % ��õĽ�Ϊŷʽ����
        end
        
        function rrt = runMARRTs(rrt,single_solution)                                % ����RRT�㷨
            %METHOD1 �˴���ʾ�йش˷�����ժҪ
            %   �˴���ʾ��ϸ˵��
            rrt.nodes = rrt.init_position;                                          % ���еĽڵ㣬��ʼ״̬��ֻ���������ʼλ�ýڵ�
            rrt.edges = {-1};                                                       % ���б߳�ʼ��Ϊֻ��-1��Ԫ�����飬������ڵ�û�и��ڵ㣬�����ڵ�ı߲�����
            iterations = 0;                                                         % ��¼�����Ĵ���
            path_cost = [];                                                         % ��¼ÿ�ε���·�����۳�ʼ��Ϊ��
            num_nodes = [];                                                         % ��¼���еĽڵ���Ŀ
            while true                                                                % �����������������ڵ����趨����ֵ
                if rand() < rrt.possibility %&& iterations > 100                   % ��������������С���趨����ֵ
                    x_rand = rrt.goal;                                              % ������ΪĿ���
                else
                    if nargin == 2                                                  % ����������Ϊ3
                        x_rand = SAMPLE(rrt,single_solution);                     % ��������״̬�ռ��������һ���ڵ㲢����informed_node
                    else                                                            % ����������Ϊ2
                        x_rand = SAMPLE(rrt);                                     % ��ֻ������״̬�ռ����
                    end
                end
                extend = EXTEND(rrt,rrt.nodes,rrt.edges,x_rand);                  % �������������չ
                rrt.nodes = extend.nodes;                                           % ������չ�õ��������ĵ�
                rrt.edges = extend.edges;                                           % ������չ�õ��������ıߣ�ÿ�����ӽڵ�λ�ô洢�����ڵ�ı�
                rrt.cost = extend.cost;                                             % ������չ�õ����µ㼰�ڽ��ڵ㵽�����ڵ�Ĵ������飬ÿ�����ӽڵ�λ�ô洢�����ڵ�ıߴ���
                rrt.parent = extend.parent;                                         % ������չ�õ����������ڵ�ĸ��ڵ����飬ÿ�����ӽڵ�λ�ô洢�丸�ڵ������е�����
                iterations = iterations + 1;                                        % ����������1
                if iterations > rrt.maxiterations
                    flag = 0;
                    for i = 1:size(rrt.nodes,1)                                             % �����е�ÿһ���ڵ�
                        if isequal(rrt.nodes(i,:),rrt.goal)                                 % ����ýڵ��Ŀ��ڵ����
                            goal_index = i;                                                 % Ŀ��ڵ������е��±�
                            index = goal_index;                                             % �洢Ŀ��ڵ������е��±�
                            path_index = [];                                                % �±�������Ϊ·����ʼ��
                            while index ~= 0                                                % ֱ��������ڵ㣬ѭ������
                                path_index = [path_index;index];                            % ��Ŀ��ڵ������е��±겢��·������
                                index = rrt.parent(index);                                  % Ŀ��ڵ����ΪԭĿ��ڵ�ĸ��ڵ�
                            end
                            path_index = flipud(path_index);                                % ��·��������з�ת�õ�����㵽�յ��·��
                            Path = {};                                                      % ����Ϊ·����ʼ��
                            for k = 2 : size(path_index,1)                                  % �Գ����ڵ������ڵ�
                                Path = [Path;rrt.edges{path_index(k)}];                     % �����ǵ����ڵ�ı߲���·������
                            end
                            rrt.path = Path;                                                % ���յõ���·���洢��rrt��path��
                            best_solution = COST(rrt,rrt.parent,rrt.cost,goal_index);
                            fprintf('number of iterations = %d, cost of path = %d\n',iterations,best_solution);
                            flag = 1;
                            break;
                        end
                    end
                    if flag == 0
                        for i = 2:size(rrt.edges,1)                                             % �����е�ÿһ����
                            for j = 1:size(rrt.edges{i})                                        % ���������ϵ�ÿһ��·����
                                if isequal(rrt.edges{i}(j),rrt.goal)                            % �����·�������Ŀ��ڵ�
                                    rrt.nodes = [rrt.nodes;rrt.goal];                           % ���Ŀ��ڵ㲢������
                                    rrt.parent = [rrt.parent;rrt.parent(i)];                    % Ŀ��ڵ�ĸ��ڵ�����Ϊ������ָ��ĸ��ڵ�
                                    rrt.edges = [rrt.edges;rrt.edges{i}(1:j)];                  % Ŀ��ڵ㵽���ڵ�ı�����Ϊ�����ߵ�jλ�õı�
                                    rrt.cost = [rrt.cost;rrt.agent_count*j];                    % Ŀ��㵽���ڵ�Ĵ�������Ϊ�ߴ��۵��Ͻ�
                                    goal_index = size(rrt.nodes,1);                             % Ŀ��ڵ������е��±�
                                    index = goal_index;
                                    path_index = [];                                            % �±�������Ϊ·����ʼ��
                                    while index ~= 0                                            % ֱ��������ڵ㣬ѭ������
                                        path_index = [path_index;index];                        % ��Ŀ��ڵ������е��±겢��·������
                                        index = rrt.parent(index);                              % Ŀ��ڵ����ΪԭĿ��ڵ�ĸ��ڵ�
                                    end
                                    path_index = flipud(path_index);                            % ��·��������з�ת�õ�����㵽�յ��·��
                                    Path = {};                                                  % ����Ϊ·����ʼ��
                                    for k = 2 : size(path_index,1)                              % �Գ����ڵ������ڵ�
                                        Path = [Path;rrt.edges{path_index(k)}];                 % �����ǵ����ڵ�ı߲���·������
                                    end
                                    rrt.path = Path;                                            % ���յõ���·���洢��rrt��path��
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
                    % ��ͼ
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
                    % ��ͼ
                    rrt.pathcost = path_cost;
                    rrt.numnodes = num_nodes;
                    return;
                end
                flag = 0;
                for i = 1:size(rrt.nodes,1)                                             % �����е�ÿһ���ڵ�
                    if isequal(rrt.nodes(i,:),rrt.goal)                                 % ����ýڵ��Ŀ��ڵ����
                        goal_index = i;                                                 % Ŀ��ڵ������е��±�
                        index = goal_index;                                             % �洢Ŀ��ڵ������е��±�
                        path_index = [];                                                % �±�������Ϊ·����ʼ��
                        while index ~= 0                                                % ֱ��������ڵ㣬ѭ������
                            path_index = [path_index;index];                            % ��Ŀ��ڵ������е��±겢��·������
                            index = rrt.parent(index);                                  % Ŀ��ڵ����ΪԭĿ��ڵ�ĸ��ڵ�
                        end
                        path_index = flipud(path_index);                                % ��·��������з�ת�õ�����㵽�յ��·��
                        Path = {};                                                      % ����Ϊ·����ʼ��
                        for k = 2 : size(path_index,1)                                  % �Գ����ڵ������ڵ�
                            Path = [Path;rrt.edges{path_index(k)}];                     % �����ǵ����ڵ�ı߲���·������
                        end
                        rrt.path = Path;                                                % ���յõ���·���洢��rrt��path��
                        path_cost(iterations,:) = COST(rrt,rrt.parent,rrt.cost,goal_index);
                        num_nodes(iterations,:) = size(rrt.nodes,1);
                        fprintf('number of iterations = %d, num of nodes = %d, cost of path = %d\n',iterations,num_nodes(end,:),path_cost(end,:));
                        flag = 1;
                        break;
                    end
                end                                                 
                if flag == 0
                    for i = 2:size(rrt.edges,1)                                             % �����е�ÿһ����
                        for j = 1:size(rrt.edges{i})                                        % ���������ϵ�ÿһ��·����
                            if isequal(rrt.edges{i}(j),rrt.goal)                            % �����·�������Ŀ��ڵ�
                                rrt.nodes = [rrt.nodes;rrt.goal];                           % ���Ŀ��ڵ㲢������
                                rrt.parent = [rrt.parent;rrt.parent(i)];                    % Ŀ��ڵ�ĸ��ڵ�����Ϊ������ָ��ĸ��ڵ�
                                rrt.edges = [rrt.edges;rrt.edges{i}(1:j)];                  % Ŀ��ڵ㵽���ڵ�ı�����Ϊ�����ߵ�jλ�õı�
                                rrt.cost = [rrt.cost;rrt.agent_count*j];                    % Ŀ��㵽���ڵ�Ĵ�������Ϊ�ߴ��۵��Ͻ�
                                goal_index = size(rrt.nodes,1);                             % Ŀ��ڵ������е��±�
                                index = goal_index;
                                path_index = [];                                            % �±�������Ϊ·����ʼ��
                                while index ~= 0                                            % ֱ��������ڵ㣬ѭ������
                                    path_index = [path_index;index];                        % ��Ŀ��ڵ������е��±겢��·������
                                    index = rrt.parent(index);                              % Ŀ��ڵ����ΪԭĿ��ڵ�ĸ��ڵ�
                                end
                                path_index = flipud(path_index);                            % ��·��������з�ת�õ�����㵽�յ��·��
                                Path = {};                                                  % ����Ϊ·����ʼ��
                                for k = 2 : size(path_index,1)                              % �Գ����ڵ������ڵ�
                                    Path = [Path;rrt.edges{path_index(k)}];                 % �����ǵ����ڵ�ı߲���·������
                                end
                                rrt.path = Path;                                            % ���յõ���·���洢��rrt��path��
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
        
        function rand_node = SAMPLE(rrt,single_solution)                          % ������״̬�ռ��������һ���ڵ�
            valid = false;                                                          % ����״̬�ڵ��ʼ����Ч�̶�Ϊ��                                                                                   % ��������������������Ч�������ϲ�������Ч
            while valid == false                                                    % ��������1��������Чʱ��ѭ������
                rand_sample = [ceil((rrt.rows-1)*rand),ceil((rrt.cols-1)*rand)];    % �ڵ�ͼ���������һ����Ϊ�����
                if (rrt.map(rand_sample(1),rand_sample(2)) ~= 1)           % �������㲻���ϰ���ʱ�������������������ʼλ�ã���Ŀ��λ�á����Գ����ռ����������״ֻ̬���м�״̬
                    rand_node = rand_sample;                                        % �洢���������
                    valid = true;                                                   % ������1��������Ч�̶�Ϊ��
                end
            end
            if rrt.agent_count > 1                                                  % �����������������1
                for j = 2 : rrt.agent_count                                         % ���������������в���
                    valid = false;                                                  % ����״̬�ڵ��ʼ����Ч�̶�Ϊ��
                    while valid == false                                            % ��������j��������Чʱ��ѭ������
                        rand_sample = [ceil((rrt.rows-1)*rand),ceil((rrt.cols-1)*rand)];        % �ڵ�ͼ���������һ����Ϊ�����
                        if(rrt.map(rand_sample(1),rand_sample(2)) ~= 1)                         % �����㲻���ϰ���ʱ
                            rand_node = [rand_node,rand_sample];                                % �洢������
                            valid = true;                                                       % ��������Ч�̶�Ϊ��
                        end
                    end
                end
            end
            if nargin == 2                                                                      % ������������Ŀ����3
                solution_cost = zeros(rrt.agent_count,1);                                       % ��Ĵ��۳�ʼ��Ϊ0
                max_cost = 0;                                                                   % ��������۳�ʼ��Ϊ0
                for i = 1 : rrt.agent_count                                                     % ��ÿһ��������Ľ�
                    if ~isempty(single_solution(i).path)                                        % �����·����Ϊ��
                        for j = 1 : size(single_solution(i).path,1)                             % �Խ��ÿһ����
                            solution_cost(i) = solution_cost(i) + size(single_solution(i).path{j},1);   % �������ǵĳ��Ȳ��ۼӵ������������
                        end
                        if solution_cost(i) > max_cost                                          % ���������Ľ�Ĵ��۴���������
                            max_cost = solution_cost(i);                                        % �������۸���Ϊ�ý�Ĵ���
                        end
                    end
                end
                rand_cost = ceil(rand()*max_cost);                                              % �������۷�Χ�����ѡ��һ������ֵ
                informed_rand = zeros(rrt.agent_count*2,1);                                     % ����ڵ��ʼ��Ϊ0                                                         
                for i = 1 : rrt.agent_count                                                     % ��ÿһ���������ҵ������·����
                    cumul_cost = 0;                                                             % �ۼӴ��۳�ʼ��Ϊ0
                    if ~isempty(single_solution(i).path)                                        % �����·����Ϊ��
                        for j = 1 : size(single_solution(i).path,1)                             % �Խ��ÿһ����
                            old_cumul_cost = cumul_cost;                                        % ����ԭ�����ۼӴ���
                            cumul_cost = cumul_cost + size(single_solution(i).path{j},1);       % �����ۼ�
                            if cumul_cost >= rand_cost                                           % �����һ�������ڷ����ۼӴ��۴����������
                                if j == 1                                 
                                    informed_rand((2*i-1):2*i) = single_solution(i).path{j}(rand_cost,:); % ������ڵ������rand_costֵΪ������·����
                                    break;
                                else
                                    if rand_cost-old_cumul_cost < 1 || rand_cost-old_cumul_cost > size(single_solution(i).path{j},1)
                                        a = 1;
                                    end
                                    informed_rand((2*i-1):2*i) = single_solution(i).path{j}(rand_cost-old_cumul_cost,:);% ������ڵ�����Ը�������ۼ�ȥ��һ���ۼƴ��۵�ֵΪ������·���� 
                                    break;
                                end
                            end
                            if cumul_cost < rand_cost && j == size(single_solution(i).path,1)   % ��������һ���߷����ۼӴ��ۻ���С���������
                                informed_rand((2*i-1):2*i) = single_solution(i).path{j}(end,:); % ������ڵ�������һ���������һ��·����
                                break;
                            end
                        end
                        informed_rand(2*i-1) = ceil(informed_rand(2*i-1) + normrnd(0,1) * 0.5);   % �������λ����ԭλ��ƫ��һ����̬�ֲ��������0.5�ľ���
                        informed_rand(2*i) = ceil(informed_rand(2*i) + normrnd(0,1) * 0.5);       % �������λ����ԭλ��ƫ��һ����̬�ֲ��������0.5�ľ���
%                         nearest_node = NEAREST(single_solution(i),single_solution(i).nodes,informed_rand((2*i-1):2*i));   % ��������i�������ҵ���������������Ľڵ�
%                         informed_rand((2*i-1):2*i) = nearest_node.node;                           % ��������Ϊ������Ľڵ�
                    end
                end
                for i = 1:2:size(rand_node,2)                                           % ��ÿ�������������һ������ڵ�
                    if ~isequal(informed_rand(i:i+1),[0,0])                             % �����������informed�����Ľ����Ϊ��0��0��
                        rand_node(i:i+1) = informed_rand(i:i+1);                        % ��ö�����ڵ��滻Ϊinformed�����Ľ��
                    end
                end
            end
        end
        
        function extend = EXTEND(rrt,nodes,edges,x)                               % �����������x��չ
            tree_nodes = nodes;                                                     % �������ڵ�
            tree_edges = edges;                                                     % �������ı�
            Parent = rrt.parent;                                                    % ���ڵ������ʼ��
            Cost = rrt.cost;                                                        % ���ݸ��ڵ㵽���ڵ�Ĵ���
            x_nearest = NEAREST(rrt,nodes,x);                                       % �ҵ�������������еĽڵ�
            greedy = GREEDY(rrt,x_nearest.node,x);                                % �������㷨�ҵ��½ڵ��·��
            x_new = greedy.x_new;                                                   % �洢x_new�ڵ�
            p_new = greedy.Path;                                                    % �洢x_nearest��x_new�ı�
            c_nearest_new = greedy.cost;                                            % �洢x_nearest��x_new�ıߴ���
            if ~isempty(p_new)                                                      % ������½ڵ��б� 
                alreadyintree = 0;                                                  % �½ڵ������еĵı�־λ
                for i = 1:size(tree_nodes,1)                                        % ������ÿһ���ڵ�
                    if isequal(tree_nodes(i,:),x_new)                              % ���x_new�Ѿ�������
                        alreadyintree = 1;
                        break;
                    end
                end
                if alreadyintree == 1                                               % ����½ڵ��Ѿ�������
                    extend.nodes = tree_nodes;                                          % ���������Ľڵ�
                    extend.edges = tree_edges;                                          % ���������ı�
                    extend.parent = Parent;                                             % ����������parent����
                    extend.cost = Cost;                                                 % ����������Cost����
                    return;                                                         % �򲻱ؽ��и���
                end
                % ��ͼ
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
                % ��ͼ
                tree_nodes = [tree_nodes;x_new];                                    % ��x_new���뱸�����ڵ���
                c_new = COST(rrt,Parent,Cost,x_nearest.indx) + c_nearest_new;       % x_new�ĸ��ڵ��ʼ��Ϊx_nearest�������ڵ�Ĵ��۳�ʼ��Ϊx_nearest�����ڵ�Ĵ��ۼ�x_nearest��x_new�Ĵ���
                c_new_parent = c_nearest_new;                                       % x_new�����ڵ�ı߳�ʼ��Ϊx_nearest��x_new�ıߴ���
                Parent = [Parent;x_nearest.indx];                                   % ���½ڵ�ĸ��ڵ�����Ϊx_nearest
                x_near = NEAR(rrt,nodes,x_new,size(nodes,1));                       % �ҵ���x_newΪ���ĵ������ڵĽڵ�
                flag = 0;                                                           % ���ñ�ǣ���ǳ�Ϊx_new���ڵ��x_near�ڵ�
                if ~isempty(x_near.nodes)                                           % ����ڽ��ڵ㼯�ǿ�
                    % ��ͼ
%                     rectangle('Position',[x_new(1,1)-x_near.radius,x_new(1,2)-x_near.radius,x_near.radius*2,x_near.radius*2],'Curvature',[1 1]);
%                     plot(x_new(1,1),x_new(1,2),'bo','MarkerSize',2,'MarkerFaceColor','r');
                    % ��ͼ
                    for i = 1:size(x_near.nodes,1)                                  % ����Щ�ڵ�
                        near_new = GREEDY(rrt,x_near.nodes(i,:),x_new);           % �������㷨��x_near��x_new��չ
                        if isequal(near_new.x_new,x_new)                            % �����չ�õ����½ڵ��x_new��ȣ�˵������֮�������ֱ�ӵı�������
                            c_new_bynear = COST(rrt,Parent,Cost,x_near.index(i)) + near_new.cost;   % �����x_nearΪ��ĸ�ڵ㣬��x_new�Ĵ���Ϊx_near�����ڵ�Ĵ��ۼ�x_near��x_new�Ĵ���
                            if c_new_bynear < c_new                                 % ����ô��۱���x_nearestΪ���ڵ���۸���
                                c_new = c_new_bynear;                               % ����x_new�����ڵ�Ĵ���
                                c_new_parent = near_new.cost;                       % �洢x_new�����ڵ�Ĵ���
                                p_new = near_new.Path;                              % ����x_new�ڵ�ָ�򸸽ڵ�ı�
                                Parent(end,:) = [];                                 % ɾ�����ڵ��������һ��
                                Parent = [Parent;x_near.index(i)];                  % ��x_near����Ϊx_new�ĸ��ڵ�
                                flag = i;                                           % �����i�����
                            end
                        end
                    end
                end
                Cost = [Cost;c_new_parent];                                           % �½ڵ㵽���ڵ�Ĵ��۴����������
                tree_edges = [tree_edges;p_new];                                    % ���еı߸���
                % ��ͼ
%                 x = tree_edges{end,1}(:,1);
%                 y = tree_edges{end,1}(:,2);
%                 line(x,y,'Color','cyan','LineWidth',3);
                % ��ͼ
                if ~isempty(x_near.nodes)                                           % ����ڽ��ڵ㼯�ǿ�
                    for i = 1:size(x_near.nodes,1)                                  % ����x_newΪ���ĵ������ڵ����нڵ�
                        if i == flag                                                % ����x_new�ĸ��ڵ�����
                            continue;
                        end
                        new_near = GREEDY(rrt,x_new,x_near.nodes(i,:));           % ��x_new��x_near��չ
                        if isequal(new_near.x_new,x_near.nodes(i,:)) && COST(rrt,Parent,Cost,x_near.index(i)) > c_new + new_near.cost  % �����չ�õ����µ���x_near�ڵ㲢����x_new��Ϊx_near�ĸ��ڵ�õ��Ĵ��۱�x_near�����е�ԭ����С
                            Parent(x_near.index(i)) = size(Parent,1);               % x_near�ĸ��ڵ������е������������һ���ڵ�x_new������
                            tree_edges{x_near.index(i),:} = new_near.Path;          % x_nearָ���丸�ڵ�ı߸���Ϊָ��x_new�ı�
                            Cost(x_near.index(i)) = new_near.cost;                  % x_nearָ���丸�ڵ�ıߴ��۸���
                        end
                    end
                end
            end
            extend.nodes = tree_nodes;                                          % ���������Ľڵ�
            extend.edges = tree_edges;                                          % ���������ı�
            extend.parent = Parent;                                             % ����������parent����
            extend.cost = Cost;                                                 % ����������Cost����
        end
        
        function cumulative_cost = COST(rrt,Parent,Cost,node_index)                         % ����ڵ㵽���ڵ�Ĵ���
            index = node_index;                                                 % �洢�ڵ������е�����
            cumulative_cost = 0;                                                % �ڵ㵽���ڵ�Ĵ��۳�ʼ��Ϊ0
            while ~isequal(index,1)                                             % �����ۼӴ��ۣ�ֱ�����ڵ�
                cumulative_cost = cumulative_cost + Cost(index);            % �ۼӵ�ǰ�ڵ�ָ���丸�ڵ�ıߵĴ���
                index = Parent(index);                                      % ��������Ϊ��ǰ�ڵ�ĸ��ڵ�
            end
        end
        
        function nearest = NEAREST(rrt,Nodes,x)
            min_dist = Inf;                                                         % ��ʼ����С����Ϊ�����
            for i = 1 : size(Nodes,1)                                              % �����е�ÿһ���ڵ㶼����һ�ξ��룬ȡ������С�Ľڵ�
                dist = DIST(rrt,Nodes(i,:),x);                                      % ���������ڵ�֮��ľ���
                if dist < min_dist                                                  % �ҵ������������С�Ľڵ�
                    min_dist = dist;                                                % ������С����
                    nearest.node = Nodes(i,:);                                      % �洢��С����ڵ�
                    nearest.indx = i;                                               % �洢��С����ڵ������е�����
                end
            end
        end
        
        function dist = DIST(rrt,star,dest)
            distance = abs(star - dest);                                            % ���������յ�ľ���
            dist = sum(distance);                                                   % ��������ܾ���
        end
        
        function greedy = GREEDY(rrt,start,dest)                                  % �����㷨
            x = start;                                                              % x��Ϊ��ʼ��
            x_new = zeros(1,rrt.agent_count*2);                                     % Xnew��ʼ��
            c = 0;                                                                  % ·�����۳�ʼ��Ϊ0                                                              
            Path = zeros(rrt.c_max,rrt.agent_count*2);                              % ����������·����ʼ����Ϊ������
            waypoint = zeros(rrt.agent_count,2);                                    % ·��������ʼ��
            loop_count = 0;                                                         % ѭ��������ʼ��Ϊ0
            Map = repmat(rrt.map,1,1,rrt.agent_count);                              % ÿ�������屣��һ�ݵ�ͼ
            while ~isequal(x,dest) && (c <= rrt.c_max)                              % ����û����չ������ڵ������չ�Ľڵ���ܴ���С������������
                flag1 = 0;                                                          % ��־λ���㣬������������ͬ�������������
                old_c = c;                                                          % �洢��һ��ѭ���Ĵ���ֵ
                old_waypoint = waypoint;                                            % �洢��һ�ε�·����
                for i = 1:2:size(x,2)                                               % ��ÿ����������xλ�õ�����(Xi��X(i+1)) 
                    j = (i+1)/2;                                                    % ȡ��ǰ��������±�
                    x_j = [x(i),x(i+1)];                                            % ȡ������j��xλ��
                    dest_j = [dest(i),dest(i+1)];                                   % �洢������j��Ŀ��λ��
                    if isequal(x_j,dest_j)                                          % ���������j������Ŀ�ĵ�
                        waypoint(j,:) = x_j;                                            % ��������j��Ŀ��λ��ԭ�ز������ȴ�����������
                        flag1 = flag1 + 1;                                          % ͳ�Ƶ���Ŀ�ĵص�������
                        continue;                                                   % ������һ���������·��
                    end
                    % �ҵ���������ͼ�еĺ��ӣ����ڣ��ڵ㲢�����ڽڵ��---------------------------------------------------------------
%                     child_nodes = children(rrt,A(j).map,x_j(1),x_j(2));             % �ҵ���������ͼ�еĺ��ӣ����ڣ��ڵ㲢�����ڽڵ��
                    child_nodes = zeros(4,2);                                       % ���ӽڵ㼯��ʼ��
                    index = 0;                                                              % ����������ʼ��Ϊ0
                    Y = x_j(1);
                    X = x_j(2);
                    if Y-1 > 0 && rrt.map(Y-1,X) ~= 1                                            % ����ýڵ���Ϸ��ڵ��ڵ�ͼ���Ҳ����ϰ���
                        index = index + 1;                                                  % ����������1
                        child_nodes(index,:) = [Y-1,X];                                     % ��ýڵ���뺢�ӽڵ㼯
                    end
                    if Y+1 <= rrt.rows && rrt.map(Y+1,X) ~= 1                                    % ����ýڵ���·��ڵ��ڵ�ͼ���Ҳ����ϰ���
                        index = index + 1;                                                  % ����������1
                        child_nodes(index,:) = [Y+1,X];                                     % ��ýڵ���뺢�ӽڵ㼯
                    end
                    if X-1 > 0 && rrt.map(Y,X-1) ~= 1                                            % ����ýڵ���󷽽ڵ��ڵ�ͼ���Ҳ����ϰ���
                        index = index + 1;                                                  % ����������1
                        child_nodes(index,:) = [Y,X-1];                                     % ��ýڵ���뺢�ӽڵ㼯
                    end
                    if X+1 <= rrt.cols && rrt.map(Y,X+1) ~= 1                                    % ����ýڵ���ҷ��ڵ��ڵ�ͼ���Ҳ����ϰ���
                        index = index + 1;                                                  % ����������1
                        child_nodes(index,:) = [Y,X+1];                                     % ��ýڵ���뺢�ӽڵ㼯
                    end
                    if index < 4
                        child_nodes((index+1):end,:) = [];                                  % ��Ϊ0����ɾ��
                    end
                    % �ҵ���������ͼ�еĺ��ӣ����ڣ��ڵ㲢�����ڽڵ��---------------------------------------------------------------
                    if ~isempty(child_nodes)                                        % ������ӽڵ㲻Ϊ������СHֵ�������Ϊ·����
                        % �ҵ���СHֵ�ڵ�------------------------------------------------------------------------------------------
                        min_H = Inf;                                                            % ��С�����ʼ��
                        for k = 1:size(child_nodes,1)                                              % ��ÿ�����ӽڵ�
                            distance = abs(child_nodes(k,:) - dest_j);                                            % ���������յ�ľ���
                            H_value = sum(distance) + rand;                                        % ��������ܾ������С��1��ƫ��Ԥ��Hֵ���
%                             H_value = DIST(rrt,child_nodes(i,:),dest_j) + rand;                      % �����䵽Ŀ����Hֵ,����С��1��ƫ��Ԥ��Hֵ���
                            if H_value < min_H
                                min_H = H_value;                                                % ����СHֵ����
                                x_min = child_nodes(k,:);                                    % �洢�ú��ӽڵ�
                            end
                        end
%                         x_min = minHvalueNode(rrt,child_nodes,dest_j);              % �ҵ����ӽڵ㼯������������ֵ��С�Ľڵ� 
                        % �ҵ���СHֵ�ڵ�------------------------------------------------------------------------------------------
                        waypoint(j,:) = x_min;                                          % ������j���Ӹõ�Ϊ·����
                        c = c + 1;                                                  % ���ۼ�1
                        x(i:i+1) = x_min;                                           % ����������j��xλ�����ж��Ƿ񵽴�Ŀ�ĵ�
                    else                                                            % ������ӽڵ�Ϊ�գ������ʱ������·���߻�����������ͬ��
                        waypoint(j,:) = [x(i),x(i+1)];                                  % ��������j��������·���ϴ�����·��
                        flag1 = flag1 + 1;                                          % ͳ����·���������������
                    end                                                             
                end
%                 Path(1,:) = start(:);
                loop_count = loop_count + 1;                                        % ѭ��������1��ѭ������·��������Ӽ�����
                old_x_new = x_new;                                                  % �洢ԭ����Xnew�ڵ�
                x_new = x;                                                          % ����Xnew�ڵ�
                old_path = Path;                                                    % �洢ԭ��������������·��
                if flag1 == rrt.agent_count                                         % ��������������·���������͵���Ŀ�ĵص������Ӻ͵������������壨��������һ��ѭ��������룩
                    for i = 1:2:rrt.agent_count*2                                   % ������������·������·������
                        Path(loop_count,i:i+1) = waypoint((i+1)/2,:);                 % �洢����������·��
                    end
                    Path(all(Path==0,2),:) = [];
%                     Path(loop_count,:) = reshape(waypoint',[1,rrt.agent_count*2]);
                    break;                                                          % ����whileѭ��
                end
                % ���������·���Ƿ���ײ-------------------------------------------------------------------------------------------
                no_collision = 1;                                                   % ֻ��һ����������·��������
                if rrt.agent_count > 1                                              % ����������������������1
                    for m = 1 : (rrt.agent_count - 1)                               % ��������������������μ��
                        for p = (m+1) : rrt.agent_count
                            distance = abs(waypoint(m,:) - waypoint(p,:));                  % �������������Ӧʱ������ľ���
                            dist = sum(distance);                                   % ��������ܾ���
%                             if DIST(rrt,A(m).path(:),A(p).path(:)) < 2              % �����ǰ�����������С��3�����ж�Ϊ��ײ
                            if dist < 2                                             % �����ǰ�����������С��3�����ж�Ϊ��ײ
                                if dist == 0
                                    no_collision = 0;
                                    break;
                                else
                                    if isequal(old_waypoint(m,:),waypoint(p,:)) &&...
                                            isequal(old_waypoint(p,:),waypoint(m,:)) % ���ǰһ�������������λ�ú���һ�������������λ�ý���
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
%                 if ~collisionfree(rrt,A)                                            % �������������·���໥������ߺ��ϰ������
                % ���������·���Ƿ���ײ-------------------------------------------------------------------------------------------
                if ~no_collision                                                    % ���������·���໥����
                    old_path(all(old_path==0,2),:) = [];
                    greedy.Path = old_path;                                         % ����ԭ��������������·��
                    greedy.x_new = old_x_new;                                       % ����ԭ����Xnew�ڵ�
                    greedy.cost = old_c;                                            % ����ԭ������������·���Ĵ���
                    return;
                end
                % ����������·��
                for i = 1:2:rrt.agent_count*2                                       % ������������·������·������
                    Path(loop_count,i:i+1) = waypoint((i+1)/2,:);                       % �洢����������·��
                end
                % ����������·��
            end
            Path(all(Path==0,2),:) = [];
            greedy.x_new = x_new;                                                   % ���ص�ǰ��Xnew�ڵ�
            greedy.Path = Path;                                                     % ���ص�ǰ��Xnew�ı�
            greedy.cost = c;                                                        % ���ص�ǰ��Xnew�ıߴ���
        end
        
        function child_nodes = children(rrt,Gm,Y,X)                                 % �ҵ�x������ͼ�еĺ��ӣ����ڣ��ڵ㣬���������ҵ�˳�����near_nodes
            child_nodes = zeros(4,2);                                               % ���ӽڵ㼯��ʼ��
            index = 0;                                                              % ����������ʼ��Ϊ0
            if Y-1 > 0 && Gm(Y-1,X) ~= 1                                            % ����ýڵ���Ϸ��ڵ��ڵ�ͼ���Ҳ����ϰ���
                index = index + 1;                                                  % ����������1
                child_nodes(index,:) = [Y-1,X];                                     % ��ýڵ���뺢�ӽڵ㼯
            end
            if Y+1 <= rrt.rows && Gm(Y+1,X) ~= 1                                    % ����ýڵ���·��ڵ��ڵ�ͼ���Ҳ����ϰ���
                index = index + 1;                                                  % ����������1
                child_nodes(index,:) = [Y+1,X];                                     % ��ýڵ���뺢�ӽڵ㼯
            end
            if X-1 > 0 && Gm(Y,X-1) ~= 1                                            % ����ýڵ���󷽽ڵ��ڵ�ͼ���Ҳ����ϰ���
                index = index + 1;                                                  % ����������1
                child_nodes(index,:) = [Y,X-1];                                     % ��ýڵ���뺢�ӽڵ㼯
            end
            if X+1 <= rrt.cols && Gm(Y,X+1) ~= 1                                    % ����ýڵ���ҷ��ڵ��ڵ�ͼ���Ҳ����ϰ���
                index = index + 1;                                                  % ����������1
                child_nodes(index,:) = [Y,X+1];                                     % ��ýڵ���뺢�ӽڵ㼯
            end
            if index < 4
                child_nodes((index+1):end,:) = [];                                  % ��Ϊ0����ɾ��
            end
        end
        
        function min_node = minHvalueNode(rrt,children,dest)                        % �ҵ�������СHֵ�ĺ��ӽڵ�
            min_H = Inf;                                                            % ��С�����ʼ��
            for i = 1:size(children,1)                                              % ��ÿ�����ӽڵ�     
                H_value = DIST(rrt,children(i,:),dest) + rand;                      % �����䵽Ŀ����Hֵ,����С��1��ƫ��Ԥ��Hֵ���
                if H_value < min_H
                    min_H = H_value;                                                % ����СHֵ����
                    backup_node = children(i,:);                                    % �洢�ú��ӽڵ�
                end
            end
            min_node = backup_node;                                                 % ��СHֵ�ڵ㷵��
        end
        
        function no_collision = collisionfree(rrt,waypoint)                                % �������·�����໥�����򷵻�1�����򷵻�0
            no_collision = 1;                                                       % ��������������·��������
            if rrt.agent_count == 1                                                 % ������������������Ϊ1
                no_collision = 1;                                                   % ����Զ������ڸ�������
            else
                for m = 1 : (rrt.agent_count - 1)                                   % ��������������������μ��
                    for p = (m+1) : rrt.agent_count
                        if DIST(rrt,waypoint(m,:),waypoint(p,:)) < 3                    % �����ǰ�����������С��3�����ж�Ϊ��ײ
                            no_collision = 0;
                            return;
                        end   
                    end
                end
            end                                                       
        end
        
        function near = NEAR(rrt,nodes,x_new,n)                                     % �ҵ�x_newΪ���ĵ������ڵĽڵ�
            near.nodes = [];                                                        % ��ʼ��near_node
            near.index = [];                                                        % ��ʼ��near_index
            num = 0;
            gamma = 1.2*rrt.cols*rrt.agent_count;                                   % Michal Cap 2013�����ж����gammaֵ
            eta = rrt.c_max * rrt.agent_count;                                      % Michal Cap 2013�����ж����etaֵ
            d = rrt.agent_count*2;                                                  % Michal Cap 2013�����ж����dimentionsֵ
            radius = min([gamma*(log(n)/n)^(1/d),eta]);                             % karaman 2011�����ж����NEAR�뾶��ʽ
            for i = 1 : size(nodes,1)                                               % �����е�ÿ���ڵ�
                if DIST(rrt,nodes(i,:),x_new) <= radius                             % ����ýڵ��x_new�ľ���С��radius
                    num = num + 1;
                    near.nodes(num,:) = nodes(i,:);                                 % �򽫸ýڵ�����ڽ��ڵ�
                    near.index(num,:) = i;                                          % ���ýڵ����������index
                end
            end
        end
    end
end

