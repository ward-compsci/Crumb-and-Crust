function forearmMesh = createForearmMesh()
    
    sizevar = struct();
    sizevar.xc=0;
    sizevar.yc=0;
    sizevar.zc=0;
    sizevar.r = 45;
    sizevar.height = 100;
    sizevar.dist = 3;


    forearmMesh = create_mesh(['..' filesep 'output' filesep 'mesh' filesep 'forearmMesh'],'cylinder',sizevar,'stnd');
    
   
    forearmMesh.link = [1 1 1];
    forearmMesh.source.coord = [15 -40 0];
    forearmMesh.source.num = 1;
    forearmMesh.source.fwhm = 0;
    forearmMesh.source.distributed = 0;
    forearmMesh.source.fixed = 0;

    forearmMesh.meas.coord = [-10 -43 0];
    forearmMesh.meas.num = 1;
    forearmMesh.meas.fixed = 0;

    save_mesh(forearmMesh,['..' filesep 'output' filesep 'mesh' filesep 'forearmMesh']);
    forearmMesh = load_mesh(['..' filesep 'output' filesep 'mesh' filesep 'forearmMesh']);
    
    forearmMesh.elements = cast(forearmMesh.elements,'double');

end