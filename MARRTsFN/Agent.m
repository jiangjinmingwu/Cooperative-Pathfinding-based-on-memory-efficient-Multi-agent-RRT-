classdef Agent
    %UNTITLED 此处显示有关此类的摘要
    %   此处显示详细说明
    
    properties
        position    % 目前的位置
        path        % 找到的路径
        goal        % 最终的目标
        map         % 智能体地图
    end
    
    methods
        function agent = Agent(position,goal,currentmap)
            %UNTITLED 构造此类的实例
            %   此处显示详细说明
            if nargin == 3
                agent.position = position;
                agent.goal = goal;
                agent.map = currentmap;
                agent.path = [];
            else
                error('Incorrect Number of Inputs for class Agent')
            end
        end
        
%         function outputArg = method1(oj,inputArg)
%             %METHOD1 此处显示有关此方法的摘要
%             %   此处显示详细说明
%             outputArg = obj.Property1 + inputArg;
%         end
    end
end

