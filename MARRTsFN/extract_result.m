for i = 1 : 12                                                                                  % ��ÿ��������
    if ~isempty(solutions_marrts{i,:}.path)                                                     % �������������·��
        index = find(solutions_marrts{i,:}.pathcost,1);                                         % ����pathcost�е�һ������Ԫ�ص�����ֵ
        solutions_marrts{i,:}.pathcost(1:index,:) = solutions_marrts{i,:}.pathcost(index,:);    % ��pathcost�з���Ԫ�ص���pathcost�����ֵ
%         index = find(solutions_marrts{i,:}.numnodes,1);                                         % ����pathcost�е�һ������Ԫ�ص�����ֵ
%         if index > 200
%             solutions_marrts{i,:}.numnodes(1:200,:) = 1:200;
%             solutions_marrts{i,:}.numnodes(200:(index-1),:) = 200;
%         else
%             solutions_marrts{i,:}.numnodes(1:(index-1),:) = 1:(index-1);
%         end
    end
    if ~isempty(solutions_marrtsfn{i,:}.path)                                                     % �������������·��
        index = find(solutions_marrtsfn{i,:}.pathcost,1);                                         % ����pathcost�е�һ������Ԫ�ص�����ֵ
        solutions_marrtsfn{i,:}.pathcost(1:index,:) = solutions_marrtsfn{i,:}.pathcost(index,:);    % ��pathcost�з���Ԫ�ص���pathcost�����ֵ
%         index = find(solutions_marrtsfn{i,:}.numnodes,1);                                         % ����pathcost�е�һ������Ԫ�ص�����ֵ
%        if index > 1000
%            solutions_marrtsfn{i,:}.numnodes(1:1000,:) = 1:1000;
%            solutions_marrtsfn{i,:}.numnodes(1000:(index-1),:) = 1000;
%        else
%            solutions_marrtsfn{i,:}.numnodes(1:(index-1),:) = 1:(index-1);
%        end
    end
%     if ~isempty(is_solutions_marrts{i,:}.path)                                                     % �������������·��
% %         index = find(is_solutions_marrts{i,:}.pathcost,1);                                         % ����pathcost�е�һ������Ԫ�ص�����ֵ
% %         is_solutions_marrts{i,:}.pathcost(1:index,:) = is_solutions_marrts{i,:}.pathcost(index,:);    % ��pathcost�з���Ԫ�ص���pathcost�����ֵ
%         index = find(is_solutions_marrts{i,:}.numnodes,1);                                         % ����pathcost�е�һ������Ԫ�ص�����ֵ
%         if index > 200
%             is_solutions_marrts{i,:}.numnodes(1:200,:) = 1:200;
%             is_solutions_marrts{i,:}.numnodes(200:(index-1),:) = 200;
%         else
%             is_solutions_marrts{i,:}.numnodes(1:(index-1),:) = 1:(index-1);
%         end
%     end
%     if ~isempty(is_solutions_marrtsfn{i,:}.path)                                                     % �������������·��
%         index = find(is_solutions_marrtsfn{i,:}.pathcost,1);                                         % ����pathcost�е�һ������Ԫ�ص�����ֵ
%         is_solutions_marrtsfn{i,:}.pathcost(1:index,:) = is_solutions_marrtsfn{i,:}.pathcost(index,:);    % ��pathcost�з���Ԫ�ص���pathcost�����ֵ
%         index = find(is_solutions_marrtsfn{i,:}.numnodes,1);                                         % ����pathcost�е�һ������Ԫ�ص�����ֵ
%         if index > 200
%             is_solutions_marrtsfn{i,:}.numnodes(1:200,:) = 1:200;
%             is_solutions_marrtsfn{i,:}.numnodes(200:(index-1),:) = 200;
%         else
%             is_solutions_marrtsfn{i,:}.numnodes(1:(index-1),:) = 1:(index-1);
%         end
%     end
end

% ԭ��
% count = 0;
% path_cost_marrts = zeros(5000,1);                                                                     
% for i = 1 : 12                                                                                  % ��ÿһ��������
%     if ~isempty(solutions_marrts{i,:}.path)                                                     % ���������·����Ϊ��
%         count = count + 1;                                                                      % ͳ��·����Ϊ�յ����������
%         for j = 1 : 5000                                                                        % ��path_cost��ÿһ��λ��
%             if isempty(solutions_marrts{i,:}.pathcost(j,:))                                     % �����ǰpathcostֵΪ��
%                 path_cost_marrts(j,:) = Inf;                                                    % ������ƽ��pathcost����Ϊ�����
%                 coutinue;                                                                       % �����ô�ѭ��
%             end
%             path_cost_marrts(j,:) = path_cost_marrts(j,:) + solutions_marrts{i,:}.pathcost(j,:); % ��pathcostֵ������
%         end
%     end
% end
% path_cost_marrts = path_cost_marrts ./ count;                                      % �������λ��pathcost��ƽ��ֵ
% save('path_cost.mat','path_cost_marrts');

% �Ľ���
% count = 0;
% numnodes_marrts = zeros(5000,1);                                                                                                                                                    
% for j = 1 : 5000                                                                                % ��numnodes��ÿһ��λ��
%     for i = 1 : 12                                                                              % ��ÿһ��������
%         if ~isempty(solutions_marrts{i,:}.path)                                                 % ���������·����Ϊ��
%             if ~isequal(solutions_marrts{i,:}.numnodes(j,:),0)                                  % �����ǰnumnodesֵ��Ϊ��
%                 count = count + 1;                                                              % ͳ�Ƶ�ǰpathcostֵ��Ϊ������������
%                 numnodes_marrts(j,:) = numnodes_marrts(j,:) + solutions_marrts{i,:}.numnodes(j,:); % ��pathcostֵ������
%             end
%         end
%     end
%     numnodes_marrts(j,:) = numnodes_marrts(j,:) / count;                                      % �������λ��pathcost��ƽ��ֵ
%     count = 0;
% end
% % path_cost_marrts(1:4,:) = Inf;
% save('num_nodes.mat','numnodes_marrts');

% count = 0;
% numnodes_marrtsfn = zeros(5000,1);                                                                                                                                                    
% for j = 1 : 5000                                                                                % ��numnodes��ÿһ��λ��
%     for i = 1 : 12                                                                              % ��ÿһ��������
%         if ~isempty(solutions_marrtsfn{i,:}.path)                                                 % ���������·����Ϊ��
%             if ~isequal(solutions_marrtsfn{i,:}.numnodes(j,:),0)                                  % �����ǰnumnodesֵ��Ϊ��
%                 count = count + 1;                                                              % ͳ�Ƶ�ǰpathcostֵ��Ϊ������������
%                 numnodes_marrtsfn(j,:) = numnodes_marrtsfn(j,:) + solutions_marrtsfn{i,:}.numnodes(j,:); % ��pathcostֵ������
%             end
%         end
%     end
%     numnodes_marrtsfn(j,:) = numnodes_marrtsfn(j,:) / count;                                      % �������λ��pathcost��ƽ��ֵ
%     count = 0;
% end
% % path_cost_marrts(1:4,:) = Inf;
% save('num_nodes.mat','numnodes_marrtsfn','-append');

% count = 0;
% is_numnodes_marrts = zeros(5000,1);                                                                                                                                                    
% for j = 1 : 5000                                                                                % ��numnodes��ÿһ��λ��
%     for i = 1 : 12                                                                              % ��ÿһ��������
%         if ~isempty(is_solutions_marrts{i,:}.path)                                                 % ���������·����Ϊ��
%             if ~isequal(is_solutions_marrts{i,:}.numnodes(j,:),0)                                  % �����ǰnumnodesֵ��Ϊ��
%                 count = count + 1;                                                              % ͳ�Ƶ�ǰpathcostֵ��Ϊ������������
%                 is_numnodes_marrts(j,:) = is_numnodes_marrts(j,:) + is_solutions_marrts{i,:}.numnodes(j,:); % ��pathcostֵ������
%             end
%         end
%     end
%     is_numnodes_marrts(j,:) = is_numnodes_marrts(j,:) / count;                                      % �������λ��pathcost��ƽ��ֵ
%     count = 0;
% end
% % path_cost_marrts(1:4,:) = Inf;
% save('num_nodes.mat','is_numnodes_marrts','-append');
% 
count = 0;
is_numnodes_marrtsfn = zeros(5000,1);                                                                                                                                                    
for j = 1 : 5000                                                                                % ��numnodes��ÿһ��λ��
    for i = 1 : 12                                                                              % ��ÿһ��������
        if ~isempty(is_solutions_marrtsfn{i,:}.path)                                                 % ���������·����Ϊ��
            if ~isequal(is_solutions_marrtsfn{i,:}.numnodes(j,:),0)                                  % �����ǰnumnodesֵ��Ϊ��
                count = count + 1;                                                              % ͳ�Ƶ�ǰpathcostֵ��Ϊ������������
                is_numnodes_marrtsfn(j,:) = is_numnodes_marrtsfn(j,:) + is_solutions_marrtsfn{i,:}.numnodes(j,:); % ��pathcostֵ������
            end
        end
    end
    is_numnodes_marrtsfn(j,:) = is_numnodes_marrtsfn(j,:) / count;                                      % �������λ��pathcost��ƽ��ֵ
    count = 0;
end
% path_cost_marrts(1:4,:) = Inf;
save('num_nodes.mat','is_numnodes_marrtsfn','-append');

% count = 0;
% path_cost_marrts = zeros(5000,1);                                                                                                                                                    
% for j = 1 : 5000                                                                                % ��path_cost��ÿһ��λ��
%     for i = 1 : 12                                                                              % ��ÿһ��������
%         if ~isempty(solutions_marrts{i,:}.path)                                                 % ���������·����Ϊ��
%             if ~isequal(solutions_marrts{i,:}.pathcost(j,:),0)                                  % �����ǰpathcostֵ��Ϊ��
%                 count = count + 1;                                                              % ͳ�Ƶ�ǰpathcostֵ��Ϊ������������
%                 path_cost_marrts(j,:) = path_cost_marrts(j,:) + solutions_marrts{i,:}.pathcost(j,:); % ��pathcostֵ������
%             end
%         end
%     end
%     path_cost_marrts(j,:) = path_cost_marrts(j,:) / count;                                      % �������λ��pathcost��ƽ��ֵ
%     count = 0;
% end
% % path_cost_marrts(1:4,:) = Inf;
% save('path_cost.mat','path_cost_marrts','-append');
% 
% count = 0;
% path_cost_marrtsfn = zeros(5000,1);                                                                                                                                                  
% for j = 1 : 5000                                                                                % ��path_cost��ÿһ��λ��
%     for i = 1 : 12                                                                              % ��ÿһ��������
%         if ~isempty(solutions_marrtsfn{i,:}.path)                                                 % ���������·����Ϊ��
%             if ~isequal(solutions_marrtsfn{i,:}.pathcost(j,:),0)                                  % �����ǰpathcostֵ��Ϊ��
%                 count = count + 1;                                                              % ͳ�Ƶ�ǰpathcostֵ��Ϊ������������
%                 path_cost_marrtsfn(j,:) = path_cost_marrtsfn(j,:) + solutions_marrtsfn{i,:}.pathcost(j,:); % ��pathcostֵ������
%             end
%         end
%     end
%     path_cost_marrtsfn(j,:) = path_cost_marrtsfn(j,:) / count;                                      % �������λ��pathcost��ƽ��ֵ
%     count = 0;
% end
% % path_cost_marrtsfn(1:11,:) = Inf;
% save('path_cost.mat','path_cost_marrtsfn','-append');

% count = 0;
% path_cost_ismarrts = zeros(5000,1);                                                                                                                                                  
% for j = 1 : 5000                                                                                % ��path_cost��ÿһ��λ��
%     for i = 1 : 12                                                                              % ��ÿһ��������
%         if ~isempty(is_solutions_marrts{i,:}.path)                                                 % ���������·����Ϊ��
%             if ~isequal(is_solutions_marrts{i,:}.pathcost(j,:),0)                                  % �����ǰpathcostֵ��Ϊ��
%                 count = count + 1;                                                              % ͳ�Ƶ�ǰpathcostֵ��Ϊ������������
%                 path_cost_ismarrts(j,:) = path_cost_ismarrts(j,:) + is_solutions_marrts{i,:}.pathcost(j,:); % ��pathcostֵ������
%             end
%         end
%     end
%     path_cost_ismarrts(j,:) = path_cost_ismarrts(j,:) / count;                                      % �������λ��pathcost��ƽ��ֵ
%     count = 0;
% end
% % path_cost_ismarrts(1,:) = Inf;
% save('path_cost.mat','path_cost_ismarrts','-append');
% 
count = 0;
path_cost_ismarrtsfn = zeros(5000,1);                                                                                                                                                  
for j = 1 : 5000                                                                                % ��path_cost��ÿһ��λ��
    for i = 1 : 12                                                                              % ��ÿһ��������
        if ~isempty(is_solutions_marrtsfn{i,:}.path)                                                 % ���������·����Ϊ��
            if ~isequal(is_solutions_marrtsfn{i,:}.pathcost(j,:),0)                                  % �����ǰpathcostֵ��Ϊ��
                count = count + 1;                                                              % ͳ�Ƶ�ǰpathcostֵ��Ϊ������������
                path_cost_ismarrtsfn(j,:) = path_cost_ismarrtsfn(j,:) + is_solutions_marrtsfn{i,:}.pathcost(j,:); % ��pathcostֵ������
            end
        end
    end
    path_cost_ismarrtsfn(j,:) = path_cost_ismarrtsfn(j,:) / count;                                      % �������λ��pathcost��ƽ��ֵ
    count = 0;
end
% path_cost_ismarrtsfn(1:5,:) = Inf;
save('path_cost.mat','path_cost_ismarrtsfn','-append');