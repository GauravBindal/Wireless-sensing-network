close all;
clc;
clear all;
a=1;
weight=ones(100,1);
b=101;
sensor_nodes=ones(100,1);
N=100; % Number of nodes
percent_cls_nodes = 20;
percent_mal_nodes = 20;
radius_nodes = 0.01;
sink_coord=[50;150];
data=1;
malicious_data=zeros(100,1000);
for i=1:1:N
    malicious_data(i,:)=randi([0,1],1,1000);
end
x_coord=randi([1,N],1,N);
x_coord(N+1)=150;
y_coord=randi([1,N],1,N);
y_coord(N+1)=50;
random_malicious_nodes = randi([1,N],1,percent_mal_nodes*N/100);
random_cluster_head = randi([1,N],1,percent_cls_nodes*N/100);
plot(x_coord,y_coord,'mo',...
    'LineWidth',0.1,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor',[0 1 0],...
    'MarkerSize',10);

 for i=1:1:N
    for j=1:1:percent_mal_nodes
        if random_malicious_nodes(j)==i
            hold on;
             sensor_nodes(i,1)=0;
%             plot(x_coord(i),y_coord(i),'mo',...
%             'LineWidth',0.1,...
%             'MarkerEdgeColor','k',...
%             'MarkerFaceColor',[1 0 0],...
%              'MarkerSize',5);
         
        end
    end
    for k=1:1:percent_cls_nodes
        if random_cluster_head(k)==i
            hold on;
            plot(x_coord(i),y_coord(i),'mo',...
            'LineWidth',0.1,...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor','k',...
             'MarkerSize',10);
        end
    end
end
hold on;
plot(sink_coord(2,:),sink_coord(1,:),'mo',...
    'LineWidth',0.1,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor',[0 0 1],...
    'MarkerSize',20);
cluster_map =containers.Map('KeyType','int32','ValueType','int32');
for i=1:1:N
    xval=x_coord(i);
    yval=y_coord(i);
    distance=inf;
   for k=1:1:percent_cls_nodes
        if random_cluster_head(k)~=i
            cluster_x_value = x_coord(random_cluster_head(k));
            cluster_y_value = y_coord(random_cluster_head(k));
            p = sqrt(((cluster_x_value-xval).^2)+((cluster_y_value-yval).^2));
            
            if distance>p
                distance = p;
                nearest_cluster = random_cluster_head(k);
            end
        else
            distance = 0;
            nearest_cluster = N+1;        
        end
            
   end
    hold on;
    cluster_map(i)=nearest_cluster;
    plot([xval x_coord(nearest_cluster)],[yval y_coord(nearest_cluster)],'m--');
    
end

for k=1:1:percent_cls_nodes
        hold on;
        plot([x_coord(random_cluster_head(k)) sink_coord(2,:)],[y_coord(random_cluster_head(k)) sink_coord(1,:)],'k--');
end
tic
for i=1:1:N
    if sensor_nodes(i)==0
        for j=1:1:10    
            if malicious_data(i,j)~=data
                weight(i,1)=weight(i,1)-0.20;
            else
                if weight(i,1)<1
                    weight(i,1)=weight(i,1)+0.20;
                end
            end
            if(weight(i,1)<0.7)
                hold on;
                plot(x_coord(i),y_coord(i),'mo',...
                'LineWidth',0.1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor',[1 0 0] ,...
                'MarkerSize',10);
                break;
            end
        end

    end
end
t=toc;
disp(t);



