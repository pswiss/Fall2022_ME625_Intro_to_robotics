function [xy, h] = createStarVertices(varargin)
% CREATESTARVERTICES Creates vertices for stars with customizable number of rays, 
% position, size, and orientation.
%   
%   XY = CREATESTARVERTICES(NRAYS) specifies the number of rays of a star
%   centered at (0,0) with an outer diameter of 1, an inner diameter of 0.5, 
%   and oriented at 0 degrees. XY is an mx2 matrix of [x,y] vertices where 
%   m=nrays*2+1 where the last vertex wraps to the first.
%
%   CREATESTARVERTICES(NRAYS, CENTER) specifies the center of the star 
%   defined by a 1x2 or 2x1 vector of [x,y] coordinates. Ignored when empty. 
%
%   CREATESTARVERTICES(NRAYS, CENTER, DIAMETERS) specifies the [inner, outer]
%   diameters of the star by a 1x2 or 2x1 vector. If the vector is not in 
%   ascending order, the star orientation will be shifted by 360/nrays/2 
%   degrees. Ignored when empty.
%
%   CREATESTARVERTICES(NRAYS, CENTER, DIAMETERS, ORIENTATION) specifies
%   the orientation of the star in degrees from upward where positive 
%   rotations are counterclockwise about the star's center. The first vertex 
%   in xy(1,:) points in the direction of orientation. Ignored when empty.
%
%   [XY, h] = CREATESTARVERTICES(AX, __) When an axis handle, ax, or gca is
%   supplied in the first input, the star is plotted on the specified axes
%   as a patch object with a FaceColor determined by the axes ColorOrder and 
%   ColorOrderIndex properties. The patch handle is returned in h and can be 
%   used to format the patch.  
%
% Examples
%   See createStarVertices_examples.mlx for several examples. 
%
%   % Create and plot star vertices
%   figure()
%   ax = axes(); 
%   center = [0,0];
%   diameters = [10,20];
%   [xy, h] = createStarVertices(ax, 9, center, diameters, 0);
%
%   % Plot center and inner/outer diameters
%   hold on
%   plot(center(1), center(2), 'c+','LineWidth',1,'MarkerSize', 8)
%   theta = linspace(0,2*pi,100); 
%   plot(cos(theta').*diameters/2+center(1), sin(theta').*diameters/2+center(2), 'c-','LineWidth',1)
%   axis equal
%   grid on
%
% See also PLOT LINE PATCH FILL
% Source: <a href = "https://www.mathworks.com/matlabcentral/fileexchange/89331-createstarvertices">createStarVertices</a>
% Author: <a href = "https://www.mathworks.com/matlabcentral/profile/authors/3753776-adam-danz">Adam Danz</a>

% Copyright (c) 2021  All rights reserved

% Version History
% vs 1.0.0  210325  Created and uploaded to FEX in response to https://www.mathworks.com/matlabcentral/answers/783258
% vs 1.0.1  210325  Update URL
% vs 1.1.0  210328  Patch color now based on axis colororder, using default edge color;  
%                   Improved documentation and examples in mlx file. 

%% Input validation
if nargin == 0
    error('MATLAB:minrhs', 'Not enough input arguments.')
end
if isgraphics(varargin{1},'axes')
    narginchk(1,5)
    ax = varargin{1};
    varargin(1) = [];
    nargoutchk(0,2)
else
    if ~isnumeric(varargin{1})
        % deleted axes is faill isgraphics()
        error('CREATESTARVERTS:InvalidHandle', 'The first input was neither numeric nor a valid axis handle.')
    end
    narginchk(1,4)
    ax = []; 
    nargoutchk(0,1)
end

% Take care of empties since validateattributes can't handle it.
defaults = {[], [0,0], [.5,1], 0};
emptyIdx = cellfun(@isempty,varargin); 
varargin(emptyIdx) = defaults(emptyIdx); 

p = inputParser();
addRequired(p, 'nrays', @(x)validateattributes(x,{'numeric'},{'scalar'}))
addOptional(p, 'center', defaults{2}, @(x)validateattributes(x,{'numeric'},{'vector','numel',2}))
addOptional(p, 'diameters', defaults{3}, @(x)validateattributes(x,{'numeric'},{'vector','numel',2}))
addOptional(p, 'orientation', defaults{4}, @(x)validateattributes(x,{'numeric'},{'scalar'}))
parse(p,varargin{:})

%% Create star vertices(x,y)
th = linspace(0,2*pi,p.Results.nrays*2+1)+pi/2-p.Results.orientation*pi/180;
xy = p.Results.diameters(2)/2 * [cos(th(:)), sin(th(:))];
xy(2:2:end,:) = xy(2:2:end,:)*(p.Results.diameters(1)/p.Results.diameters(2));
xy = xy + repmat(p.Results.center(:).',size(xy,1),1); % xy + p.Results.center(:).' for >=r16b

%% Plot if requested
if ~isempty(ax)
    hstates = {'off','on'}; 
    holdState = ishold(ax);
    cleanup = onCleanup(@()hold(ax,hstates(holdState+1)));
    hold(ax,'on')
    nColorOrder = size(ax.ColorOrder,1);
    cidx = round(mod(ax.ColorOrderIndex, nColorOrder+1e-08)); %[1]
    color = ax.ColorOrder(cidx,:);
    h = patch(ax, xy(:,1), xy(:,2), color);
    ax.ColorOrderIndex = round(mod(ax.ColorOrderIndex+1, nColorOrder+1e-08)); %[1]
    clear('cleanup')
end

%% Footnotes
% [1] This modification of mod() gets around the 0s returned by mod(n,n) and 
%   returns n instead (for integers only).

%% Copyright info
%     Copyright (c) 2021, Adam Danz
%     All rights reserved.
% 
%     Redistribution and use in source and binary forms, with or without
%     modification, are permitted provided that the following conditions are met:
% 
%     * Redistributions of source code must retain the above copyright notice, this
%       list of conditions and the following disclaimer.
% 
%     * Redistributions in binary form must reproduce the above copyright notice,
%       this list of conditions and the following disclaimer in the documentation
%       and/or other materials provided with the distribution
% 
%     * Neither the name of  nor the names of its
%       contributors may be used to endorse or promote products derived from this
%       software without specific prior written permission.
% 
%     THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
%     AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
%     IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
%     DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
%     FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
%     DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
%     SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
%     CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
%     OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
%     OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
