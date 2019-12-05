% min_index_marrts = Inf;
% min_index_marrtsfn = Inf;
% for j = 1:7
%     for i = 1 : 12                                                                                  % 对每个智能体
%         if ~isempty(solutions_marrts{i,j}.path)                                                     % 如果该智能体有路径
%             index = find(solutions_marrts{i,j}.pathcost,1);                                         % 返回pathcost中第一个非零元素的索引值
%             if index < min_index_marrts
%                 min_index_marrts = index;
%             end
%         end
%         if ~isempty(solutions_marrtsfn{i,j}.path)
%             index = find(solutions_marrtsfn{i,j}.pathcost,1);
%             if index < min_index_marrtsfn
%                 max_index_marrtsfn = index;
%             end
%         end
%     end
% end
for j = 1 : 10
    for i = 1 : 12                                                                                  % 对每个智能体
%         if ~isempty(solutions_marrts{i,j}.path)                                                     % 如果该智能体有路径
%             index = find(solutions_marrts{i,j}.pathcost,1);                                         % 返回pathcost中第一个非零元素的索引值
%             if index < min_index_marrts
%                 min_index_marrts = index;
%             end
%             solutions_marrts{i,j}.pathcost(1:index,:) = solutions_marrts{i,j}.pathcost(index,:);    % 令pathcost中非零元素等于pathcost中最大值
%             index = find(solutions_marrts{i,:}.numnodes,1);                                         % 返回pathcost中第一个非零元素的索引值
%             if index > 200
%                 solutions_marrts{i,:}.numnodes(1:200,:) = 1:200;
%                 solutions_marrts{i,:}.numnodes(200:(index-1),:) = 200;
%             else
%                 solutions_marrts{i,:}.numnodes(1:(index-1),:) = 1:(index-1);
%             end
%         end
%         if ~isempty(solutions_marrtsfn{i,j}.path)                                                     % 如果该智能体有路径
%             index = find(solutions_marrtsfn{i,j}.pathcost,1);                                         % 返回pathcost中第一个非零元素的索引值
%             if index > max_index_marrtsfn
%                 max_index_marrtsfn = index;
%             end
%             solutions_marrtsfn{i,j}.pathcost(1:index,:) = solutions_marrtsfn{i,j}.pathcost(index,:);    % 令pathcost中非零元素等于pathcost中最大值
%             index = find(solutions_marrtsfn{i,:}.numnodes,1);                                         % 返回pathcost中第一个非零元素的索引值
%            if index > 1000
%                solutions_marrtsfn{i,:}.numnodes(1:1000,:) = 1:1000;
%                solutions_marrtsfn{i,:}.numnodes(1000:(index-1),:) = 1000;
%            else
%                solutions_marrtsfn{i,:}.numnodes(1:(index-1),:) = 1:(index-1);
%            end
%         end
        if ~isempty(is_solutions_marrts{i,j}.path)                                                     % 如果该智能体有路径
            index = find(is_solutions_marrts{i,j}.pathcost,1);                                         % 返回pathcost中第一个非零元素的索引值
            is_solutions_marrts{i,j}.pathcost(1:index,:) = is_solutions_marrts{i,j}.pathcost(index,:);    % 令pathcost中非零元素等于pathcost中最大值
    %         index = find(is_solutions_marrts{i,:}.numnodes,1);                                         % 返回pathcost中第一个非零元素的索引值
    %         if index > 200
    %             is_solutions_marrts{i,:}.numnodes(1:200,:) = 1:200;
    %             is_solutions_marrts{i,:}.numnodes(200:(index-1),:) = 200;
    %         else
    %             is_solutions_marrts{i,:}.numnodes(1:(index-1),:) = 1:(index-1);
    %         end
        end
        if ~isempty(is_solutions_marrtsfn{i,j}.path)                                                     % 如果该智能体有路径
            index = find(is_solutions_marrtsfn{i,j}.pathcost,1);                                         % 返回pathcost中第一个非零元素的索引值
            is_solutions_marrtsfn{i,j}.pathcost(1:index,:) = is_solutions_marrtsfn{i,j}.pathcost(index,:);    % 令pathcost中非零元素等于pathcost中最大值
%             index = find(is_solutions_marrtsfn{i,:}.numnodes,1);                                         % 返回pathcost中第一个非零元素的索引值
%             if index > 200
%                 is_solutions_marrtsfn{i,:}.numnodes(1:200,:) = 1:200;
%                 is_solutions_marrtsfn{i,:}.numnodes(200:(index-1),:) = 200;
%             else
%                 is_solutions_marrtsfn{i,:}.numnodes(1:(index-1),:) = 1:(index-1);
%             end
        end
    end
end

% 原版
% count = 0;
% path_cost_marrts = zeros(5000,1);                                                                     
% for j = 1 : 10
%     for i = 1 : 12                                                                                  % 对每一个智能体
%         if ~isempty(solutions_marrts{i,j}.path)                                                     % 如果智能体路径不为空
%             count = count + 1;                                                                      % 统计路径不为空的智能体个数
%             for k = 1 : 5000                                                                        % 对path_cost的每一个位置
% %                 if isempty(solutions_marrts{i,j}.pathcost(k,:))                                     % 如果当前pathcost值为零
% %                     path_cost_marrts(k,:) = Inf;                                                    % 智能体平均pathcost设置为无穷大
% %                     coutinue;                                                                       % 跳过该次循环
% %                 end
%                 path_cost_marrts(k,:) = path_cost_marrts(k,:) + solutions_marrts{i,j}.pathcost(k,:); % 把pathcost值加起来
%             end
%         end
%     end
% end
% path_cost_marrts = path_cost_marrts ./ count;                                      % 计算非零位置pathcost的平均值
% % save('path_cost.mat','path_cost_marrts');
% save('repeat_120_path_cost.mat','path_cost_marrts','-append');
% 
% count = 0;
% path_cost_marrtsfn = zeros(5000,1);                                                                     
% for j = 1 : 10
%     for i = 1 : 12                                                                                  % 对每一个智能体
%         if ~isempty(solutions_marrtsfn{i,j}.path)                                                     % 如果智能体路径不为空
%             count = count + 1;                                                                      % 统计路径不为空的智能体个数
%             for k = 1 : 5000                                                                        % 对path_cost的每一个位置
% %                 if isempty(solutions_marrts{i,j}.pathcost(k,:))                                     % 如果当前pathcost值为零
% %                     path_cost_marrts(k,:) = Inf;                                                    % 智能体平均pathcost设置为无穷大
% %                     coutinue;                                                                       % 跳过该次循环
% %                 end
%                 path_cost_marrtsfn(k,:) = path_cost_marrtsfn(k,:) + solutions_marrtsfn{i,j}.pathcost(k,:); % 把pathcost值加起来
%             end
%         end
%     end
% end
% path_cost_marrtsfn = path_cost_marrtsfn ./ count;                                      % 计算非零位置pathcost的平均值
% % save('path_cost.mat','path_cost_marrts');
% save('repeat_120_path_cost.mat','path_cost_marrtsfn','-append');

count = 0;
path_cost_ismarrts = zeros(5000,1);                                                                     
for j = 1 : 10
    for i = 1 : 12                                                                                  % 对每一个智能体
        if ~isempty(is_solutions_marrts{i,j}.path)                                                     % 如果智能体路径不为空
            count = count + 1;                                                                      % 统计路径不为空的智能体个数
            for k = 1 : 5000                                                                        % 对path_cost的每一个位置
%                 if isempty(solutions_marrts{i,j}.pathcost(k,:))                                     % 如果当前pathcost值为零
%                     path_cost_marrts(k,:) = Inf;                                                    % 智能体平均pathcost设置为无穷大
%                     coutinue;                                                                       % 跳过该次循环
%                 end
                path_cost_ismarrts(k,:) = path_cost_ismarrts(k,:) + is_solutions_marrts{i,j}.pathcost(k,:); % 把pathcost值加起来
            end
        end
    end
end
path_cost_ismarrts = path_cost_ismarrts ./ count;                                      % 计算非零位置pathcost的平均值
% save('path_cost.mat','path_cost_marrts');
save('repeat_120_path_cost.mat','path_cost_ismarrts','-append');

count = 0;
path_cost_ismarrtsfn = zeros(5000,1);                                                                     
for j = 1 : 10
    for i = 1 : 12                                                                                  % 对每一个智能体
        if ~isempty(is_solutions_marrtsfn{i,j}.path)                                                     % 如果智能体路径不为空
            count = count + 1;                                                                      % 统计路径不为空的智能体个数
            for k = 1 : 5000                                                                        % 对path_cost的每一个位置
%                 if isempty(solutions_marrts{i,j}.pathcost(k,:))                                     % 如果当前pathcost值为零
%                     path_cost_marrts(k,:) = Inf;                                                    % 智能体平均pathcost设置为无穷大
%                     coutinue;                                                                       % 跳过该次循环
%                 end
                path_cost_ismarrtsfn(k,:) = path_cost_ismarrtsfn(k,:) + is_solutions_marrtsfn{i,j}.pathcost(k,:); % 把pathcost值加起来
            end
        end
    end
end
path_cost_ismarrtsfn = path_cost_ismarrtsfn ./ count;                                      % 计算非零位置pathcost的平均值
% save('path_cost.mat','path_cost_marrts');
save('repeat_120_path_cost.mat','path_cost_ismarrtsfn','-append');

% 改进版
% count = 0;
% numnodes_marrts = zeros(5000,1);                                                                                                                                                    
% for j = 1 : 5000                                                                                % 对numnodes的每一个位置
%     for i = 1 : 12                                                                              % 对每一个智能体
%         if ~isempty(solutions_marrts{i,:}.path)                                                 % 如果智能体路径不为空
%             if ~isequal(solutions_marrts{i,:}.numnodes(j,:),0)                                  % 如果当前numnodes值不为零
%                 count = count + 1;                                                              % 统计当前pathcost值不为零的智能体个数
%                 numnodes_marrts(j,:) = numnodes_marrts(j,:) + solutions_marrts{i,:}.numnodes(j,:); % 把pathcost值加起来
%             end
%         end
%     end
%     numnodes_marrts(j,:) = numnodes_marrts(j,:) / count;                                      % 计算非零位置pathcost的平均值
%     count = 0;
% end
% % path_cost_marrts(1:4,:) = Inf;
% save('num_nodes.mat','numnodes_marrts');

% count = 0;
% numnodes_marrtsfn = zeros(5000,1);                                                                                                                                                    
% for j = 1 : 5000                                                                                % 对numnodes的每一个位置
%     for i = 1 : 12                                                                              % 对每一个智能体
%         if ~isempty(solutions_marrtsfn{i,:}.path)                                                 % 如果智能体路径不为空
%             if ~isequal(solutions_marrtsfn{i,:}.numnodes(j,:),0)                                  % 如果当前numnodes值不为零
%                 count = count + 1;                                                              % 统计当前pathcost值不为零的智能体个数
%                 numnodes_marrtsfn(j,:) = numnodes_marrtsfn(j,:) + solutions_marrtsfn{i,:}.numnodes(j,:); % 把pathcost值加起来
%             end
%         end
%     end
%     numnodes_marrtsfn(j,:) = numnodes_marrtsfn(j,:) / count;                                      % 计算非零位置pathcost的平均值
%     count = 0;
% end
% % path_cost_marrts(1:4,:) = Inf;
% save('num_nodes.mat','numnodes_marrtsfn','-append');

% count = 0;
% is_numnodes_marrts = zeros(5000,1);                                                                                                                                                    
% for j = 1 : 5000                                                                                % 对numnodes的每一个位置
%     for i = 1 : 12                                                                              % 对每一个智能体
%         if ~isempty(is_solutions_marrts{i,:}.path)                                                 % 如果智能体路径不为空
%             if ~isequal(is_solutions_marrts{i,:}.numnodes(j,:),0)                                  % 如果当前numnodes值不为零
%                 count = count + 1;                                                              % 统计当前pathcost值不为零的智能体个数
%                 is_numnodes_marrts(j,:) = is_numnodes_marrts(j,:) + is_solutions_marrts{i,:}.numnodes(j,:); % 把pathcost值加起来
%             end
%         end
%     end
%     is_numnodes_marrts(j,:) = is_numnodes_marrts(j,:) / count;                                      % 计算非零位置pathcost的平均值
%     count = 0;
% end
% % path_cost_marrts(1:4,:) = Inf;
% save('num_nodes.mat','is_numnodes_marrts','-append');
% 
% count = 0;
% is_numnodes_marrtsfn = zeros(5000,1);                                                                                                                                                    
% for j = 1 : 5000                                                                                % 对numnodes的每一个位置
%     for i = 1 : 12                                                                              % 对每一个智能体
%         if ~isempty(is_solutions_marrtsfn{i,:}.path)                                                 % 如果智能体路径不为空
%             if ~isequal(is_solutions_marrtsfn{i,:}.numnodes(j,:),0)                                  % 如果当前numnodes值不为零
%                 count = count + 1;                                                              % 统计当前pathcost值不为零的智能体个数
%                 is_numnodes_marrtsfn(j,:) = is_numnodes_marrtsfn(j,:) + is_solutions_marrtsfn{i,:}.numnodes(j,:); % 把pathcost值加起来
%             end
%         end
%     end
%     is_numnodes_marrtsfn(j,:) = is_numnodes_marrtsfn(j,:) / count;                                      % 计算非零位置pathcost的平均值
%     count = 0;
% end
% % path_cost_marrts(1:4,:) = Inf;
% save('num_nodes.mat','is_numnodes_marrtsfn','-append');

% count = 0;
% path_cost_marrts = zeros(5000,1);
% for j = 1 : 5000                                                                                % 对path_cost的每一个位置
% %     if j < min_index_marrts
% %         path_cost_marrts(j,:) = Inf;
% %         continue;
% %     end
%     for k = 1 : 10
%         for i = 1 : 12                                                                              % 对每一个智能体
%             if ~isempty(solutions_marrts{i,k}.path)                                                 % 如果智能体路径不为空
%                 if ~isequal(solutions_marrts{i,k}.pathcost(j,:),0)                                  % 如果当前pathcost值不为零
%                     count = count + 1;                                                              % 统计当前pathcost值不为零的智能体个数
%                     path_cost_marrts(j,:) = path_cost_marrts(j,:) + solutions_marrts{i,k}.pathcost(j,:); % 把pathcost值加起来
%                 end
%             end
%         end
%     end
%     path_cost_marrts(j,:) = path_cost_marrts(j,:) / count;                                      % 计算非零位置pathcost的平均值
%     count = 0;
% end
% % path_cost_marrts(1:4,:) = Inf;
% save('repeat_120_path_cost.mat','path_cost_marrts');
% 
% count = 0;
% path_cost_marrtsfn = zeros(5000,1);                                                                                                                                                  
% for j = 1 : 5000                                                                                % 对path_cost的每一个位置
% %     if j < min_index_marrtsfn
% %         path_cost_marrtsfn(j,:) = Inf;
% %         continue;
% %     end
%     for k = 1 : 10  
%         for i = 1 : 12                                                                              % 对每一个智能体
%             if ~isempty(solutions_marrtsfn{i,k}.path)                                                 % 如果智能体路径不为空
%                 if ~isequal(solutions_marrtsfn{i,k}.pathcost(j,:),0)                                  % 如果当前pathcost值不为零
%                     count = count + 1;                                                              % 统计当前pathcost值不为零的智能体个数
%                     path_cost_marrtsfn(j,:) = path_cost_marrtsfn(j,:) + solutions_marrtsfn{i,k}.pathcost(j,:); % 把pathcost值加起来
%                 end
%             end
%         end
%     end
%     path_cost_marrtsfn(j,:) = path_cost_marrtsfn(j,:) / count;                                      % 计算非零位置pathcost的平均值
%     count = 0;
% end
% % path_cost_marrtsfn(1:11,:) = Inf;
% save('repeat_120_path_cost.mat','path_cost_marrtsfn','-append');

% count = 0;
% path_cost_ismarrts = zeros(5000,1);                                                                                                                                                  
% for j = 1 : 5000                                                                                % 对path_cost的每一个位置
%     for i = 1 : 12                                                                              % 对每一个智能体
%         if ~isempty(is_solutions_marrts{i,:}.path)                                                 % 如果智能体路径不为空
%             if ~isequal(is_solutions_marrts{i,:}.pathcost(j,:),0)                                  % 如果当前pathcost值不为零
%                 count = count + 1;                                                              % 统计当前pathcost值不为零的智能体个数
%                 path_cost_ismarrts(j,:) = path_cost_ismarrts(j,:) + is_solutions_marrts{i,:}.pathcost(j,:); % 把pathcost值加起来
%             end
%         end
%     end
%     path_cost_ismarrts(j,:) = path_cost_ismarrts(j,:) / count;                                      % 计算非零位置pathcost的平均值
%     count = 0;
% end
% % path_cost_ismarrts(1,:) = Inf;
% save('path_cost.mat','path_cost_ismarrts','-append');
% 
% count = 0;
% path_cost_ismarrtsfn = zeros(5000,1);                                                                                                                                                  
% for j = 1 : 5000                                                                                % 对path_cost的每一个位置
%     for i = 1 : 12                                                                              % 对每一个智能体
%         if ~isempty(is_solutions_marrtsfn{i,:}.path)                                                 % 如果智能体路径不为空
%             if ~isequal(is_solutions_marrtsfn{i,:}.pathcost(j,:),0)                                  % 如果当前pathcost值不为零
%                 count = count + 1;                                                              % 统计当前pathcost值不为零的智能体个数
%                 path_cost_ismarrtsfn(j,:) = path_cost_ismarrtsfn(j,:) + is_solutions_marrtsfn{i,:}.pathcost(j,:); % 把pathcost值加起来
%             end
%         end
%     end
%     path_cost_ismarrtsfn(j,:) = path_cost_ismarrtsfn(j,:) / count;                                      % 计算非零位置pathcost的平均值
%     count = 0;
% end
% % path_cost_ismarrtsfn(1:5,:) = Inf;
% save('path_cost.mat','path_cost_ismarrtsfn','-append');