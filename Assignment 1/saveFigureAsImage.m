function saveFigureAsImage(filename)
    % A simple function to save the view of the current window as an image
    mkdir('figures');
    exportgraphics(gcf, ['figures\',filename,'.png']);    
end

