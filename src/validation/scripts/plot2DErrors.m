function plot2DErrors(figtitle,validationstruct)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    arguments
        figtitle
        validationstruct
    end

    figTitle = figtitle;
    validationStruct = validationstruct;
    y = validationStruct.y;
    err = validationStruct.err;

    [qx,qy] = meshgrid(y,y);
    width = length(qx);

    cmin = min(err(:));
    cmax = max(err(:));
    
    meanValues = mean(err,4);

    figure
    tlo = tiledlayout(4,2);
    tlo.TileSpacing = 'compact';

    h(1) = nexttile(tlo);
    contourf(qx,qy,reshape(meanValues(:,1,1),[width,width]),10);
    clim([cmin,cmax])
    legend([num2str(mean(meanValues(:,1,1),'all'))])

    h(2) = nexttile(tlo);
    contourf(qx,qy,reshape(meanValues(:,2,1),[width,width]),10);
    clim([cmin,cmax])
    legend([num2str(mean(meanValues(:,2,1),'all'))])
    %{
    h(3) = nexttile(tlo);
    contourf(qx,qy,reshape(meanValues(:,3,1),[width,width]),10);
    clim([cmin,cmax])
    legend([num2str(mean(meanValues(:,3,1),'all'))])
    %}
    h(3) = nexttile(tlo);
    contourf(qx,qy,reshape(meanValues(:,1,2),[width,width]),10);
    clim([cmin,cmax])
    legend([num2str(mean(meanValues(:,1,2),'all'))])

    h(4) = nexttile(tlo);
    contourf(qx,qy,reshape(meanValues(:,2,2),[width,width]),10);
    clim([cmin,cmax])
    legend([num2str(mean(meanValues(:,2,2),'all'))])
    %{
    h(6) = nexttile(tlo);
    contourf(qx,qy,reshape(meanValues(:,3,2),[width,width]),10);
    clim([cmin,cmax])
    legend([num2str(mean(meanValues(:,3,2),'all'))])
    %}
    h(5) = nexttile(tlo);
    contourf(qx,qy,reshape(meanValues(:,1,3),[width,width]),10);
    clim([cmin,cmax])
    legend([num2str(mean(meanValues(:,1,3),'all'))])
    %annotation('textbox',[.2 .5 .3 .3],'String',['Mean abs error: ' num2str(mean(errBrute_abs,'all'))])

    h(6) = nexttile(tlo);
    contourf(qx,qy,reshape(meanValues(:,2,3),[width,width]),10);
    clim([cmin,cmax])
    legend([num2str(mean(meanValues(:,2,3),'all'))])

    h(7) = nexttile(tlo);
    contourf(qx,qy,reshape(meanValues(:,1,4),[width,width]),10);
    clim([cmin,cmax])
    legend([num2str(mean(meanValues(:,1,4),'all'))])
    %annotation('textbox',[.2 .5 .3 .3],'String',['Mean abs error: ' num2str(mean(errBrute_abs,'all'))])

    h(8) = nexttile(tlo);
    contourf(qx,qy,reshape(meanValues(:,2,4),[width,width]),10);
    clim([cmin,cmax])
    legend([num2str(mean(meanValues(:,2,4),'all'))])

    %{
    h(9) = nexttile(tlo);
    contourf(qx,qy,reshape(meanValues(:,3,3),[width,width]),10);
    clim([cmin,cmax])
    legend([num2str(mean(meanValues(:,3,3),'all'))])
    %}
    titleText = [validationStruct.errorMethod{1} ' error for ' ...
        num2str(validationStruct.yLims(1)) ' < y < ' num2str(validationStruct.yLims(2))];

    title(tlo,titleText,'FontWeight','normal')
    
    set(h, 'Colormap', jet)
    cbh = colorbar(h(end)); 
    cbh.Layout.Tile = 'east'; 

    %savefig(['..' filesep 'figs' filesep '2D_Errors_' figTitle interpType])


end

