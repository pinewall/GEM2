% Show pattern of Gradient Matrix

nlat = 30;
nlon = 60;

sparseX = [];
sparseY = [];

for lat = 1:nlat
    for lon = 1:nlon
        currentX = (lat-1) * nlon + lon;
        % bottom part
        if currentX - nlon > 0 && 1==1
            currentLat = lat - 1;
            tmpY1 = (currentLat-1) * nlon + mod((lon - 1) + nlon - 1,nlon) + 1; 
            tmpY2 = (currentLat-1) * nlon + lon;
            tmpY3 = (currentLat-1) * nlon + mod((lon - 1) + nlon + 1,nlon) + 1;
            sparseX = [sparseX;currentX;currentX;currentX];
            sparseY = [sparseY;tmpY1;tmpY2;tmpY3];
        end
        
        % peer part
        currentLat = lat;
        tmpY1 = (currentLat-1) * nlon + mod((lon - 1) + nlon - 1,nlon) + 1; 
        tmpY2 = (currentLat-1) * nlon + lon;
        tmpY3 = (currentLat-1) * nlon + mod((lon - 1) + nlon + 1,nlon) + 1;    
        sparseX = [sparseX;currentX;currentX;currentX];
        sparseY = [sparseY;tmpY1;tmpY2;tmpY3];
        
        % top part
        if currentX + nlon < nlat * nlon && 1==1 
            currentLat = lat + 1;
            tmpY1 = (currentLat-1) * nlon + mod((lon - 1) + nlon - 1,nlon) + 1; 
            tmpY2 = (currentLat-1) * nlon + lon;
            tmpY3 = (currentLat-1) * nlon + mod((lon - 1) + nlon + 1,nlon) + 1;
            sparseX = [sparseX;currentX;currentX;currentX];
            sparseY = [sparseY;tmpY1;tmpY2;tmpY3];
        end        
    end
end

plot(sparseX,sparseY,'o')