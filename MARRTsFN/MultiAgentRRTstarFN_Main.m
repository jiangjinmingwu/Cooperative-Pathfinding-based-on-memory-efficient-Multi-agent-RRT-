%
%
% ��ʼ����ͼ�� 1�����ϰ��� -1�����������ʼλ�ú�Ŀ��λ��    
% input_map = zeros(10,10);
% input_map = zeros(30,30);
% input_map = zeros(50,50);
% input_map = zeros(70,70);
% input_map = zeros(90,90);


% solutions_marrts = cell(12,1);                                              % ��������ʼ��
% solutions = cell(12,1);
% parfor rand_instance = 1 : 12
%     agent = 3;
%     map_index = 3;
%     % ��������������ͼ��ʼ��
%     choose_map = {zeros(10,10);zeros(30,30);zeros(50,50);zeros(70,70);zeros(90,90)}; % ��ͼѡ������ʼ��
%     input_map = choose_map{map_index,1};                                    % ��ͼ��ʼ��     
%     agent_count = agent;                                                    % ���������������ʼ��     
%     [rows,cols] = size(input_map);                                          % ��ͼ������������
%     % ��ʼ���ϰ���λ��
%     for i = 1 : (rows*cols/10)                                              % ȡ����������1/10��Ϊ�ϰ������
%         input_map(ceil((rows-1)*rand),ceil((cols-1)*rand)) = 1;             % ���ѡ��1��������Ϊ�ϰ������
%     end
%     % ��ʼ��������λ�ú�Ŀ��
%     valid = false;                                                          % ��ʼ����������Ч�̶�Ϊ��
%     A = [];                                                                 % ��������������ʼ��Ϊ��
%     for i = 1 : agent_count
%         while valid == false
%             rand_position = [ceil((rows-1)*rand),ceil((cols-1)*rand)];              % ���ѡ��1��������Ϊ�������ʼλ�ø���
%             rand_goal = [ceil((rows-1)*rand),ceil((cols-1)*rand)];                  % ���ѡ��1��������Ϊ������Ŀ��λ�ø���
%             if (input_map(rand_position(1),rand_position(2)) ~= 1) && ...
%                     (input_map(rand_position(1),rand_position(2)) ~= -1) && ...
%                     (input_map(rand_goal(1),rand_goal(2)) ~= 1) && ...
%                     (input_map(rand_goal(1),rand_goal(2)) ~= -1)                     % ������ĳ�ʼλ�ò��غϣ�Ŀ��λ�ò��غϣ����ϰ��ﲻ����
%                 input_map(rand_position(1),rand_position(2)) = -1;                   % ��ʼλ����-1
%                 input_map(rand_goal(1),rand_goal(2)) = -1;                           % Ŀ��λ����-1
%                 backup_A = Agent(rand_position,rand_goal,input_map);                % ��ʼ����������,��ÿ��������ĵ�ͼ�������Լ��ĳ�ʼλ�ú�Ŀ��λ�á�
%                 A = [A;backup_A];                                                   % �Ѹ������������δ�������
%                 valid = true;                                                       % ��Ч�̶�Ϊ��
%             end
%         end
%         valid = false;                                                              % ��Ч�̶�����
%     end
%     position = A(1).position;                                                       % �洢�������λ�ã���Ϊ��ʼ״̬�ڵ㣬��������
%     goal = A(1).goal;                                                               % �洢�������Ŀ�꣬��ΪĿ��״̬�ڵ㣬��������
%     if agent_count > 1
%         for i = 2 : agent_count
%             position = [position,A(i).position];
%             goal = [goal,A(i).goal];
%         end
%     end
%     % ����MA-RRTs�㷨
%     marrts = MARRTs(input_map,position,goal,agent_count);                           % ��ʼ��MARRTs�㷨���������
%     marrts = runMARRTs(marrts);                                                     % ����MARRTs�㷨
%     solutions{rand_instance,:} = marrts;                                            % �����������
% end
% % ������
% solutions_marrts(:) = solutions(:);
% save('marrts.mat','solutions_marrts');                                                  % ��������ļ�
% 
% solutions_marrtsfn = cell(12,1);                                              % ��������ʼ��
% solutions = cell(12,1);
% parfor rand_instance = 1 : 12
%     agent = 3;
%     map_index = 3;
%     % ��������������ͼ��ʼ��
%     choose_map = {zeros(10,10);zeros(30,30);zeros(50,50);zeros(70,70);zeros(90,90)}; % ��ͼѡ������ʼ��
%     input_map = choose_map{map_index,1};                                    % ��ͼ��ʼ��     
%     agent_count = agent;                                                    % ���������������ʼ��     
%     [rows,cols] = size(input_map);                                          % ��ͼ������������
%     % ��ʼ���ϰ���λ��
%     for i = 1 : (rows*cols/10)                                              % ȡ����������1/10��Ϊ�ϰ������
%         input_map(ceil((rows-1)*rand),ceil((cols-1)*rand)) = 1;             % ���ѡ��1��������Ϊ�ϰ������
%     end
%     % ��ʼ��������λ�ú�Ŀ��
%     valid = false;                                                          % ��ʼ����������Ч�̶�Ϊ��
%     A = [];                                                                 % ��������������ʼ��Ϊ��
%     for i = 1 : agent_count
%         while valid == false
%             rand_position = [ceil((rows-1)*rand),ceil((cols-1)*rand)];              % ���ѡ��1��������Ϊ�������ʼλ�ø���
%             rand_goal = [ceil((rows-1)*rand),ceil((cols-1)*rand)];                  % ���ѡ��1��������Ϊ������Ŀ��λ�ø���
%             if (input_map(rand_position(1),rand_position(2)) ~= 1) && ...
%                     (input_map(rand_position(1),rand_position(2)) ~= -1) && ...
%                     (input_map(rand_goal(1),rand_goal(2)) ~= 1) && ...
%                     (input_map(rand_goal(1),rand_goal(2)) ~= -1)                     % ������ĳ�ʼλ�ò��غϣ�Ŀ��λ�ò��غϣ����ϰ��ﲻ����
%                 input_map(rand_position(1),rand_position(2)) = -1;                   % ��ʼλ����-1
%                 input_map(rand_goal(1),rand_goal(2)) = -1;                           % Ŀ��λ����-1
%                 backup_A = Agent(rand_position,rand_goal,input_map);                % ��ʼ����������,��ÿ��������ĵ�ͼ�������Լ��ĳ�ʼλ�ú�Ŀ��λ�á�
%                 A = [A;backup_A];                                                   % �Ѹ������������δ�������
%                 valid = true;                                                       % ��Ч�̶�Ϊ��
%             end
%         end
%         valid = false;                                                              % ��Ч�̶�����
%     end
%     position = A(1).position;                                                       % �洢�������λ�ã���Ϊ��ʼ״̬�ڵ㣬��������
%     goal = A(1).goal;                                                               % �洢�������Ŀ�꣬��ΪĿ��״̬�ڵ㣬��������
%     if agent_count > 1
%         for i = 2 : agent_count
%             position = [position,A(i).position];
%             goal = [goal,A(i).goal];
%         end
%     end
%     % ����MA-RRTsFN�㷨
%     marrtsfn = MARRTsFN(input_map,position,goal,agent_count);                           % ��ʼ��MARRTs�㷨���������
%     marrtsfn = runRRTfn(marrtsfn);                                                     % ����MARRTs�㷨
%     solutions{rand_instance,:} = marrtsfn;                                            % �����������
% end
% % ������
% solutions_marrtsfn(:) = solutions(:);
% save('marrts.mat','solutions_marrtsfn','-append');                                       % ��������ļ�
% 
% is_solutions_marrts = cell(12,1);                                              % ��������ʼ��
% solutions = cell(12,1);
% parfor rand_instance = 1 : 12
%     agent = 3;
%     map_index = 3;
%     % ��������������ͼ��ʼ��
%     choose_map = {zeros(10,10);zeros(30,30);zeros(50,50);zeros(70,70);zeros(90,90)}; % ��ͼѡ������ʼ��
%     input_map = choose_map{map_index,1};                                    % ��ͼ��ʼ��     
%     agent_count = agent;                                                    % ���������������ʼ��     
%     [rows,cols] = size(input_map);                                          % ��ͼ������������
%     % ��ʼ���ϰ���λ��
%     for i = 1 : (rows*cols/10)                                              % ȡ����������1/10��Ϊ�ϰ������
%         input_map(ceil((rows-1)*rand),ceil((cols-1)*rand)) = 1;             % ���ѡ��1��������Ϊ�ϰ������
%     end
%     % ��ʼ��������λ�ú�Ŀ��
%     valid = false;                                                          % ��ʼ����������Ч�̶�Ϊ��
%     A = [];                                                                 % ��������������ʼ��Ϊ��
%     for i = 1 : agent_count
%         while valid == false
%             rand_position = [ceil((rows-1)*rand),ceil((cols-1)*rand)];              % ���ѡ��1��������Ϊ�������ʼλ�ø���
%             rand_goal = [ceil((rows-1)*rand),ceil((cols-1)*rand)];                  % ���ѡ��1��������Ϊ������Ŀ��λ�ø���
%             if (input_map(rand_position(1),rand_position(2)) ~= 1) && ...
%                     (input_map(rand_position(1),rand_position(2)) ~= -1) && ...
%                     (input_map(rand_goal(1),rand_goal(2)) ~= 1) && ...
%                     (input_map(rand_goal(1),rand_goal(2)) ~= -1)                     % ������ĳ�ʼλ�ò��غϣ�Ŀ��λ�ò��غϣ����ϰ��ﲻ����
%                 input_map(rand_position(1),rand_position(2)) = -1;                   % ��ʼλ����-1
%                 input_map(rand_goal(1),rand_goal(2)) = -1;                           % Ŀ��λ����-1
%                 backup_A = Agent(rand_position,rand_goal,input_map);                % ��ʼ����������,��ÿ��������ĵ�ͼ�������Լ��ĳ�ʼλ�ú�Ŀ��λ�á�
%                 A = [A;backup_A];                                                   % �Ѹ������������δ�������
%                 valid = true;                                                       % ��Ч�̶�Ϊ��
%             end
%         end
%         valid = false;                                                              % ��Ч�̶�����
%     end
%     position = A(1).position;                                                       % �洢�������λ�ã���Ϊ��ʼ״̬�ڵ㣬��������
%     goal = A(1).goal;                                                               % �洢�������Ŀ�꣬��ΪĿ��״̬�ڵ㣬��������
%     if agent_count > 1
%         for i = 2 : agent_count
%             position = [position,A(i).position];
%             goal = [goal,A(i).goal];
%         end
%     end
%     % ���е���rrt�㷨
%     single_solution = [];                                                           % ����������Ľ��ʼ��Ϊ��
%     for i = 1 : agent_count                                                         % ��ÿһ�������壬������һ�ν�
%         rrts = RRTs(input_map,A(i).position,A(i).goal,1);                           % ��ʼ��RRT�㷨���������
%         rrts = runRRTs(rrts);                                                       % ����rrt�㷨
%         single_solution = [single_solution;rrts];                                   % ��õĽ�洢��single_solution��
%     end
%     % ����is_MA-RRTs�㷨
%     is_marrts = MARRTs(input_map,position,goal,agent_count);                         % ��ʼ��MARRTs�㷨���������
%     is_marrts = runMARRTs(is_marrts,single_solution);                                % ����MARRTs�㷨
%     solutions{rand_instance,:} = is_marrts;                                          % �����������
% end
% % ������
% is_solutions_marrts(:) = solutions(:);
% save('is_marrts.mat','is_solutions_marrts');                                        % ��������ļ�

is_solutions_marrtsfn = cell(12,10);                                              % ��������ʼ��
is_solutions_marrts = cell(12,10);
% solutions_marrtsfn = cell(12,10);
% solutions_marrts = cell(12,10);
% sol_marrts = cell(12,10);                                                         % ��ʱ������ʼ��
% sol_marrtsfn = cell(12,10);
sol_ismarrts = cell(12,10);
sol_ismarrtsfn = cell(12,10);
parfor repeat = 1 : 10
    for rand_instance = 1 : 12
        agent = 3;
        map_index = 3;
        % ��������������ͼ��ʼ��
        choose_map = {zeros(10,10);zeros(30,30);zeros(50,50);zeros(70,70);zeros(90,90)}; % ��ͼѡ������ʼ��
        input_map = choose_map{map_index,1};                                    % ��ͼ��ʼ��     
        agent_count = agent;                                                    % ���������������ʼ��     
        [rows,cols] = size(input_map);                                          % ��ͼ������������
        % ��ʼ���ϰ���λ��
        for i = 1 : (rows*cols/10)                                              % ȡ����������1/10��Ϊ�ϰ������
            input_map(ceil((rows-1)*rand),ceil((cols-1)*rand)) = 1;             % ���ѡ��1��������Ϊ�ϰ������
        end
        % ��ʼ��������λ�ú�Ŀ��
        valid = false;                                                          % ��ʼ����������Ч�̶�Ϊ��
        A = [];                                                                 % ��������������ʼ��Ϊ��
        for i = 1 : agent_count
            while valid == false
                rand_position = [ceil((rows-1)*rand),ceil((cols-1)*rand)];              % ���ѡ��1��������Ϊ�������ʼλ�ø���
                rand_goal = [ceil((rows-1)*rand),ceil((cols-1)*rand)];                  % ���ѡ��1��������Ϊ������Ŀ��λ�ø���
                if (input_map(rand_position(1),rand_position(2)) ~= 1) && ...
                        (input_map(rand_position(1),rand_position(2)) ~= -1) && ...
                        (input_map(rand_goal(1),rand_goal(2)) ~= 1) && ...
                        (input_map(rand_goal(1),rand_goal(2)) ~= -1)                     % ������ĳ�ʼλ�ò��غϣ�Ŀ��λ�ò��غϣ����ϰ��ﲻ����
                    input_map(rand_position(1),rand_position(2)) = -1;                   % ��ʼλ����-1
                    input_map(rand_goal(1),rand_goal(2)) = -1;                           % Ŀ��λ����-1
                    backup_A = Agent(rand_position,rand_goal,input_map);                % ��ʼ����������,��ÿ��������ĵ�ͼ�������Լ��ĳ�ʼλ�ú�Ŀ��λ�á�
                    A = [A;backup_A];                                                   % �Ѹ������������δ�������
                    valid = true;                                                       % ��Ч�̶�Ϊ��
                end
            end
            valid = false;                                                              % ��Ч�̶�����
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
        position = A(1).position;                                                       % �洢�������λ�ã���Ϊ��ʼ״̬�ڵ㣬��������
        goal = A(1).goal;                                                               % �洢�������Ŀ�꣬��ΪĿ��״̬�ڵ㣬��������
        if agent_count > 1
            for i = 2 : agent_count
                position = [position,A(i).position];
                goal = [goal,A(i).goal];
            end
        end
%         input_map = is_solutions_marrts{rand_instance,:}.map;
%         position = is_solutions_marrts{rand_instance,:}.init_position;
%         goal = is_solutions_marrts{rand_instance,:}.goal;
%         % ����MA-RRTs�㷨
%         marrts = MARRTs(input_map,position,goal,agent_count);                           % ��ʼ��MARRTs�㷨���������
%         marrts = runMARRTs(marrts);                                                     % ����MARRTs�㷨
%         sol_marrts{rand_instance,repeat} = marrts;                                            % �����������
%         % ����MA-RRTsFN�㷨
%         marrtsfn = MARRTsFN(input_map,position,goal,agent_count);                           % ��ʼ��MARRTs�㷨���������
%         marrtsfn = runRRTfn(marrtsfn);                                                     % ����MARRTs�㷨
%         sol_marrtsfn{rand_instance,repeat} = marrtsfn;                                            % �����������
        % ���е���rrt�㷨
        single_solution = [];                                                           % ����������Ľ��ʼ��Ϊ��
        for i = 1 : agent_count                                                         % ��ÿһ�������壬������һ�ν�
            rrts = RRTs(input_map,A(i).position,A(i).goal,1);                           % ��ʼ��RRT�㷨���������
            rrts = runRRTs(rrts);                                                       % ����rrt�㷨
            single_solution = [single_solution;rrts];                                   % ��õĽ�洢��single_solution��
        end
    %     % ����isMA-RRTs�㷨
        is_marrts = MARRTs(input_map,position,goal,agent_count);                         % ��ʼ��MARRTs�㷨���������
        is_marrts = runMARRTs(is_marrts,single_solution);                                % ����MARRTs�㷨
        sol_ismarrts{rand_instance,repeat} = is_marrts;                                          % �����������
%         % ����isMA-RRTsFN�㷨
        is_marrtsfn = MARRTsFN(input_map,position,goal,agent_count);                         % ��ʼ��MARRTs�㷨���������
        is_marrtsfn = runRRTfn(is_marrtsfn,single_solution);                                % ����MARRTs�㷨
        sol_ismarrtsfn{rand_instance,repeat} = is_marrtsfn;                                          % �����������
    end
end
% ������
% solutions_marrts(:,:) = sol_marrts(:,:);
% solutions_marrtsfn(:,:) = sol_marrtsfn(:,:);
is_solutions_marrts(:,:) = sol_ismarrts(:,:);
is_solutions_marrtsfn(:,:) = sol_ismarrtsfn(:,:);
% save('all_marrts.mat','solutions_marrts','solutions_marrtsfn','is_solutions_marrts','is_solutions_marrtsfn'); 
save('all_repeat_all_marrts.mat','is_solutions_marrts','is_solutions_marrtsfn','-append');% ��������ļ�

%     single_solution = [];                                                           % ����������Ľ��ʼ��Ϊ��
%     for i = 1 : agent_count                                                         % ��ÿһ�������壬������һ�ν�
%         rrts = RRTs(input_map,A(i).position,A(i).goal,1);                            % ��ʼ��RRT�㷨���������
%         rrts = runRRTs(rrts);                                                        % ����rrt�㷨
%         single_solution = [single_solution;rrts];                                    % ��õĽ�洢��single_solution��
%     end
%     rrtfn = MARRTsFN(input_map,position,goal,agent_count);                               % ��ʼ��RRT�㷨���������
%     rrtfn = runRRTfn(rrtfn);%,single_solution);                                                            % ����rrt�㷨�����뵥�����������еĽ��
%     marrts = MARRTs(input_map,position,goal,agent_count);                               % ��ʼ��RRT�㷨���������
%     marrts = runMARRTs(marrts);%,single_solution);                                                            % ����rrt�㷨�����뵥�����������еĽ��
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
% plot(marrts.numiterations,marrts.pathcost,'DisplayName','maRRTs','Color','k');                                         % ���Ƶ���������·�����۹�ϵͼ
% hold on;
% plot(rrtfn.numiterations,rrtfn.pathcost,'DisplayName','maRRTsFN','Color','b');                                         % ���Ƶ���������·�����۹�ϵͼ
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