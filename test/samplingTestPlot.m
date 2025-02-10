function samplingTestPlot

    % Data for 2D
    labels = {'Grid-like', 'Gradient', 'Random', 'CrustCrumb'};
    means_2D = [0.0713, 0.0462, 0.1742, 0.0442];
    std_2D = [0.0465, 0.0210, 0.1081, 0.0311];
    
    % Data for 3D
    means_3D = [0.0428; 0.0406; 0.1099; 0.0353];
    std_3D = [0.0140; 0.0038; 0.0641; 0.0097];

        
    % Create figure for bar plot     
    figure
    %hb = bar(means_2D);

    hold on

    for i = 1:4
        bar(i,means_2D(i))
    end
    x = 1:4;
    er = errorbar(x,means_2D,std_2D,'LineStyle','none', ...
        'Color','k','LineWidth',1);
    hold off

    set(gca, 'xtick', 1:4, 'xticklabel', labels, 'FontSize', 20)
    ylabel('Error','FontSize',30)
    xlabel('Sampling design','FontSize',30)
    ylim([0,0.3]);


    figure
    hold on
    for i = 1:4
        bar(i,means_3D(i))
    end
    x = 1:4;
    er = errorbar(x,means_3D,std_3D,'LineStyle','none', ...
        'Color','k','LineWidth',1);
    hold off
    set(gca, 'xtick', 1:4, 'xticklabel', labels, 'FontSize', 20)
    
    ylabel('Error','FontSize',30)
    xlabel('Sampling design','FontSize',30)
    ylim([0,0.3]);


end

