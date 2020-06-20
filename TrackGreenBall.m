%% Introduction
%
% The MATLAB Support Package for Ryze Tello Drones allows you to 
% capture images from the Ryze drone and bring those right into MATLAB for 
% processing.  

%% 1. Takeoff the drone
%
% Take off the Ryze Tello drone from a level surface. 
%
% Execute the following command at the MATLAB command prompt to take-off of 
% the drone.
%
   takeoff(tello);
%
%% 2. Track the ball
%
% We will call the |trackBall| funtion on the images captured by the drone 
% in a loop. The |trackBall| funtion accepts the following inputs:
%    
% * Connection to the Ryze Tello drone
% * Image captured from the drone's FPV camera
% * Minimum value for green component intensity for the pixel to be
%   considered green. Adjust this value based on the flying environment
% * Minimum offset of drone from the image center. If the offset
%   goes above this value, then the drone position has to be adjusted.
%   
%
% The drone tracks the ball for a duration for 60 seconds.
%
   tim = tic;
   duration = 60;
   minGreenIntensity = 40;
   minOffset = 30;
   while(toc(tim) < duration)
    img = snapshot(cameraObj);
    trackBall(tello, img, minGreenIntensity, minOffset);
    pause(1);
   end
%
% <<../outside_threshold.png>>
% 
% The green ball is outside the bounds. Move the drone to keep it within
% threshold.
%
% <<../inside_threshold.png>>
%
% % The green ball is now within the threshold.
%
%% Task 6 &mdash; Land the drone
%
% Land the drone. 
%
   land(tello);
%
%% |trackBall| algorithm
%
% The |trackBall| algorithm is used to:
%
% * Extract RGB color components from the FPV camera image.
% * Find indices of green pixels in the image.
% * Find the center of the green ball in the captured image.
% * Find the displacement of the green ball from the center of the image.
% * Determine the direction to move the drone to bring the ball to center 
% of the image.
%
% For more information on the |trackBall| function, open the |trackGreenBall|
% example and then execute the following command in the MATLAB command line:
% executing the following command
%
%    open('trackBall.m')
%
