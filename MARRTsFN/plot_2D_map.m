% solutions_marrts = cell(12,1);
sol_marrts = cell(12,1);                                                         % ��ʱ������ʼ��
sol_marrtsfn = cell(12,1);

% sol_ismarrts = cell(12,1);
% sol_ismarrtsfn = cell(12,1);
for rand_instance = 1 : 1
    agent = 1;
    map_index = 5;
    % ��������������ͼ��ʼ��
    choose_map = {zeros(10,10);zeros(30,30);zeros(50,50);zeros(70,70);zeros(90,90)}; % ��ͼѡ������ʼ��
    input_map = choose_map{map_index,1};                                    % ��ͼ��ʼ��     
    agent_count = agent;                                                    % ���������������ʼ��     
    [rows,cols] = size(input_map);                                          % ��ͼ������������
    % ��ʼ���ϰ���λ��
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
    input_map(x1,y1) = 1;                                                   % ���ѡ��1��������Ϊ�ϰ������
    input_map(x2,y2) = 1;                                                   % ���ѡ��1��������Ϊ�ϰ������
    input_map(x4,y4) = 1;                                                   % ���ѡ��1��������Ϊ�ϰ������
    input_map(x5,y5) = 1;                                                   % ���ѡ��1��������Ϊ�ϰ������
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
    % ��ʼ��������λ�ú�Ŀ��
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
    position = [55,85];
    goal = [60,15];
%     input_map = solutions_marrtsfn{rand_instance,:}.map;
%     position = solutions_marrtsfn{rand_instance,:}.init_position;
%     goal = solutions_marrtsfn{rand_instance,:}.goal;
    % ����MA-RRTs�㷨
%     marrts = MARRTs(input_map,position,goal,agent_count);                           % ��ʼ��MARRTs�㷨���������
%     marrts = runMARRTs(marrts);                                                     % ����MARRTs�㷨
%     sol_marrts{rand_instance} = marrts;                                            % �����������
%     % ����MA-RRTsFN�㷨
    marrtsfn = MARRTsFN(input_map,position,goal,agent_count);                           % ��ʼ��MARRTs�㷨���������
    marrtsfn = runRRTfn(marrtsfn);                                                     % ����MARRTs�㷨
    sol_marrtsfn{rand_instance} = marrtsfn;                                            % �����������
%     % ���е���rrt�㷨
%     single_solution = [];                                                           % ����������Ľ��ʼ��Ϊ��
%     for i = 1 : agent_count                                                         % ��ÿһ�������壬������һ�ν�
%         rrts = RRTs(input_map,A(i).position,A(i).goal,1);                           % ��ʼ��RRT�㷨���������
%         rrts = runRRTs(rrts);                                                       % ����rrt�㷨
%         single_solution = [single_solution;rrts];                                   % ��õĽ�洢��single_solution��
%     end
%     % ����isMA-RRTs�㷨
%     is_marrts = MARRTs(input_map,position,goal,agent_count);                         % ��ʼ��MARRTs�㷨���������
%     is_marrts = runMARRTs(is_marrts,single_solution);                                % ����MARRTs�㷨
%     sol_ismarrts{rand_instance} = is_marrts;                                          % �����������
%     % ����isMA-RRTsFN�㷨
%     is_marrtsfn = MARRTsFN(input_map,position,goal,agent_count);                         % ��ʼ��MARRTs�㷨���������
%     is_marrtsfn = runRRTfn(is_marrtsfn,single_solution);                                % ����MARRTs�㷨
%     sol_ismarrtsfn{rand_instance} = is_marrtsfn;                                          % �����������
end
% ������
% solutions_marrts(:) = sol_marrts(:);
% solutions_marrtsfn(:) = sol_marrtsfn(:);
% is_solutions_marrts(:) = sol_ismarrts(:);
% is_solutions_marrtsfn(:) = sol_ismarrtsfn(:);
% save('all_marrts.mat','solutions_marrts','solutions_marrtsfn','is_solutions_marrts','is_solutions_marrtsfn'); 
% save('all_marrts.mat','solutions_marrts','-append');% ��������ļ�