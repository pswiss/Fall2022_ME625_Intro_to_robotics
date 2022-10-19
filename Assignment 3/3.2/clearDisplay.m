function clearDisplay()
% This function clears the curret figure without touching the actual window
    delete(get(gcf, 'children'))
end

