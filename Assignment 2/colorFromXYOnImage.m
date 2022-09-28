function color = colorFromXYOnImage(image, x, y)
    % For a given .png file, will output the color at a x pixel, y pixel
    % value. IMPORTANT: in your main function, insert the following line: 
    % image = imread('your_image_filename.png'); and then pass the image to
    % this file using that variable. This is necessary so you're not
    % constantly reading the image from your drive.
    color = reshape( image(x,y,:) ,[3,1]);
end