%Test script to time alphaShape generation for increasing dimensions

dimensions = 1:10;

numPoints = 50;
alpha = 1;

timings = zeros([length(dimensions),1]);

for d = 1:length(dimensions)
    
    points = rand([numPoints, d]);

    tic;
    findAlphaShape(points,alpha);
    timeTaken = toc;
    
    timings(d) = timeTaken;

    disp(['dim ' num2str(d) ' complete: ' num2str(timeTaken) 'seconds'])

end


figure
plot(timings);
xlabel('Dimensions')
ylabel('Time taken (s)')
