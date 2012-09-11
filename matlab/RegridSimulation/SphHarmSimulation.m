%% Reference: http://blog.163.com/dingkediling@126/blog/static/6161300720091018112144480/

%% use sphere harmonic function expansion l <= L,0 <= m <= l
function [Alpha,Expand] = SphHarmSimulation(L,theta,phi,value)

if L < 0
    disp('Come on, at least l=3 to simulate');
    return;
else
    [Expand,rabbish] = SphericalHarmonicL(0,theta,phi);
    Expand=reshape(Expand,1,[]);
    Value=reshape(value,1,[]);
    for l = 1:L
        [Re,Im] = SphericalHarmonicL(l,theta,phi);
        Re=reshape(Re,l+1,[]);
        Im=reshape(Im,l+1,[]);
        Expand = [Expand;Re;Im];
    end
    
    %% Least square method
    % To solve Expand^T Expand Alpha = Expand^T value
    A=Expand';
    B=A'*A;
    %size(B)
    %size(A')
    %size(Value')
    z=A'*Value';

    Alpha = z \ B;
    
    %% Start Simulation
    [simlat,simlon] = meshgrid(-pi/2:pi/90:pi/2,-pi:pi/90:pi);
    sim = ones(size(simlat));
    
    ifun=1;
    sim = sim * Alpha(ifun);
    ifun = ifun + 1;
    
    for l = 1:L
        [Re,Im]=SphericalHarmonicL(l,simlat,simlon);
        for m = 1:l+1
            tmp(:,:)=Re(m,:,:);
            sim = sim + Alpha(ifun)*tmp;
            ifun = ifun + 1;
            tmp(:,:)=Im(m,:,:);
            sim = sim + Alpha(ifun)*tmp;
            ifun = ifun + 1;
        end
    end
    mesh(simlat,simlon,sim)
end

  



