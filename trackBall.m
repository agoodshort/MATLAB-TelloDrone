function trackBall(ryzeObj, img, greenThreshold, offsetThreshold)
% trackBall function

% Copyright 2020 The MathWorks, Inc.

%% Extract RGB color components from the FPV camera image
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);

%% Calculate the number of rows and coloumns in the FPV camera image
nRows = size(img, 1);
nCols = size(img, 2);

%% Approximate the intensity of green components in the image
greenIntensities = g - r/2 - b/2;

%% Threshold the image to find the regions that we consider to be green enough
bwImg = greenIntensities > greenThreshold;

% Find indices of green pixels in the image
[row, col] = find(bwImg);

% Hover the drone when there are not enough green pixels detected
% This can happen if the green ball is out of frame
if(length(row) < 50 || length(col) < 50)
    disp('hovering');
    
    % Find green pixels and track the ball using drone if there are enough
    % green pixels in the image
else
    % Find center of the green ball in the captured image
    if ~isempty(row) && ~isempty(col)
        XgreenCentre = round(mean(row));
        YgreenCenter = round(mean(col));
        
        % Find the displacement of the green ball from the centre of the
        % image
        rowOffset = (nRows/2) - XgreenCentre;
        colOffset = (nCols/2) - YgreenCenter;
        
        % Display original and binary image
        subplot(1,2,1); imshow(img);
        subplot(1,2,2); imshow(bwImg);
        drawnow;
        
        %% Determine the direction to move the drone
        
        % Negative colOffset indicates that the ball is to the right of the
        % centre of the image(right of the drone). Move the drone to the right to track the
        % ball and keep it within the threshold radius
        if(colOffset < -offsetThreshold && rowOffset >=-offsetThreshold && rowOffset <=offsetThreshold)
            disp("Moving the drone right");
            moveright(ryzeObj);
            
            % Positive colOffset indicates that the ball is to the left of the
            % centre of the image(left of the drone). Move the drone to the left to track the
            % ball and keep it within the threshold radius
        elseif(colOffset  > offsetThreshold && rowOffset >=-offsetThreshold && rowOffset <=offsetThreshold)
            disp("Moving the drone left");
            moveleft(ryzeObj);
            
            % Positive rowOffset indicates that the ball is above the
            % centre of the image(above the drone). Move the drone up to track the
            % ball and keep it within the threshold radius
        elseif(rowOffset > offsetThreshold && colOffset >=-offsetThreshold && colOffset <=offsetThreshold)
            disp("Moving the drone up");
            moveup(ryzeObj);
            
            % Negative rowOffset indicates that the ball is below the
            % centre of the image(below the drone). Move the drone down to track the
            % ball and keep it within the threshold radius
        elseif(rowOffset < -offsetThreshold && colOffset >=-offsetThreshold && colOffset <=offsetThreshold)
            disp("Moving the drone down");
            movedown(ryzeObj);
            
            % Else the ball is within the threshold radius. Keep the drone
            % hovering in this case
        else
            disp("Hovering");
        end
    end
end