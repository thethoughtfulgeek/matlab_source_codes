clear
clc

x = rand(1,50);
y = rand(1,50);
pts = [x', y'];

[VX,VY] = voronoi(pts(:,1),pts(:,2));
h = plot(VX,VY,'-b',pts(:,1),pts(:,2),'.r');

xlim([min(x) max(x)]);
ylim([min(y) max(y)]);

% Assign labels to the points X.
nump = size(pts,1);
plabels = arrayfun(@(n) {sprintf('pts%d', n)}, (1:nump)');
hold on
Hpl = text(pts(:,1), pts(:,2)-0.01, plabels, 'color', 'r', ...
      'FontWeight', 'bold', 'HorizontalAlignment',...
      'center', 'BackgroundColor', 'none');

% Compute the Voronoi diagram.
[V,R] = voronoin(pts);

% Assign labels to the Voronoi vertices V.
% By convention the first vertex is at infinity.
numv = size(V,1);
vlabels = arrayfun(@(n) {sprintf('V%d', n)}, (2:numv)');
hold on
Hpl = text(V(2:end,1), V(2:end,2)-0.01, vlabels, ...
      'FontWeight', 'bold', 'HorizontalAlignment',...
      'center', 'BackgroundColor', 'none');
hold off


save('Polygon_Vertices_Coord.txt','V','-ascii')

fileID = fopen('Polygon_Indices.txt','wt+');
[nrows,ncols] = size(R);

for row = 1:nrows
    [~,num_indices] = size(R{nrows});
    %for num_ind = 1 : num_indices
    formatSpec = '%d ';
    fprintf(fileID,formatSpec,R{row});
    %end
    fprintf(fileID,'\n');
end

fclose(fileID);
%type Polygon_Indices.dat