% A simple script to begin a video
    
    mkdir('Videos');
    vidname = ['Videos\',filename,'.mp4'];
    V=VideoWriter(vidname,'MPEG-4');
    V.FrameRate = 10;
    frames = [];


