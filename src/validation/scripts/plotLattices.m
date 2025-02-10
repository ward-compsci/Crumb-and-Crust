function plotLattices(npoints, ylims)
%PLOTLATTICES Summary of this function goes here
%   Detailed explanation goes here

    arguments
        npoints = 5
        ylims = [0.01 1]
    end

    labelFontSize = 25;
    titleFontSize = 30;
    scatterSize = 100;
 
    nPoints = npoints;
    yLims = ylims;

    y_true = linspace(yLims(1),yLims(2),nPoints);
    x_true = generateXValues_2(y_true);

    yBrute = generateBruteForcePoints_validation(nPoints,yLims, 2);
    yGradient = generateGradientPoints_validation_2(nPoints, yLims, 2);
    yCrustCrumb = generateCrustCrumbPoints_validation_2 (nPoints, yLims, 2);
    yRandom = generateRandomPoints_validation(nPoints, yLims,2);


    disp(['Brute/Gradient/Random/CC points: ' num2str(numel(yBrute))...
        '/' num2str(numel(yGradient)) '/' num2str(numel(yRandom)) '/' ...
        num2str(numel(yCrustCrumb)) '/' ])

    figure
    tlo = tiledlayout(1,4);
    h(1) = nexttile;
    scatter(yBrute(:,1),yBrute(:,2),scatterSize,'filled');
    %scatter(yBrute(:,1),yBrute(:,2),'b');
    title('Gridlike','FontSize',titleFontSize);
    xlabel('\pi_1 [A.U.]','FontSize',labelFontSize)
    ylabel('\pi_2 [A.U.]','FontSize',labelFontSize)
    grid on
    h(2) = nexttile;
    scatter(-yGradient(:,1)+1,-yGradient(:,2)+1,scatterSize,'filled')
    %scatter(yGradient(:,1),yGradient(:,2),'g')
    title('Gradient based','FontSize',titleFontSize);
    xlabel('\pi_1 [A.U.]','FontSize',labelFontSize)
    %ylabel('\pi_2 [A.U.]','FontSize',labelFontSize)
    grid on
    h(3) = nexttile;
    scatter(yRandom(:,1),yRandom(:,2),scatterSize,'filled')
    %scatter(yRandom(:,1),yRandom(:,2),'o')
    title('Random','FontSize',titleFontSize);
    xlabel('\pi_1 [A.U.]','FontSize',labelFontSize)
    %ylabel('\pi_2 [A.U.]','FontSize',labelFontSize)
    grid on
    h(4) = nexttile;
    scatter(-yCrustCrumb(:,1)+1,-yCrustCrumb(:,2)+1,scatterSize,'filled')
    %scatter(yCrustCrumb(:,1),yCrustCrumb(:,2),'r')
    title('Crust Crumb','FontSize',titleFontSize);
    xlabel('\pi_1 [A.U.]','FontSize',labelFontSize)
    %ylabel('\pi_2 [A.U.]','FontSize',labelFontSize)
    grid on

    %set(gca,'FontSize',20)
    
    axesHandles = findobj(get(tlo,'Children'), 'flat','Type','axes');
    axis(axesHandles,'square')


end

