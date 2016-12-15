imaqhwinfo
video = videoinput('winvideo',1,'YUY2_320x240');

set(video,'FramesPerTrigger',lnf);
set(video,'ReturnedColorspace','rgb');
video.FrameGrabInterval=5;

start(video);

while(video.FramesAcquired<=100)
    
    data = getsnapshot(video);
    
    diff_im = imsubstract(data(:,:,1),rgb2gray(data));
    diff_im = medfilt2(diff_im,[3,3]);
    diff_im = im2bw(diff_im,0.18);
    diff_im=bwareaopen(diff_im,300);
    
    bw = bwlabel(diff_im,8);
    
    stats = regionprops(bw,'BoundingBox','Centroid');
    imshow(data);
    
    hold on
    
    for object=1:length(stats)
        bb = stats(object).BoundingBox;
        bc = stats(object).Centroid;
        
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
        plot(bc(1),bc(2),'-m+')
        
    end
    
    hold off
    
end

stop(video);

flushdata(video);

clear all;
sprintf('%s','Thanks for watching this tuto');
