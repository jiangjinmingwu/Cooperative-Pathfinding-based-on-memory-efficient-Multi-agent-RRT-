classdef Agent
    %UNTITLED �˴���ʾ�йش����ժҪ
    %   �˴���ʾ��ϸ˵��
    
    properties
        position    % Ŀǰ��λ��
        path        % �ҵ���·��
        goal        % ���յ�Ŀ��
        map         % �������ͼ
    end
    
    methods
        function agent = Agent(position,goal,currentmap)
            %UNTITLED ��������ʵ��
            %   �˴���ʾ��ϸ˵��
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
%             %METHOD1 �˴���ʾ�йش˷�����ժҪ
%             %   �˴���ʾ��ϸ˵��
%             outputArg = obj.Property1 + inputArg;
%         end
    end
end

