function E_db = farfield(num_theta, K0, Z, x, deltax,eta0)


M = length(x);
Ve = zeros(M,num_theta);
Ie = zeros(M,num_theta);

phi = linspace(0,pi,num_theta);


for i = 1 : num_theta
    Ve(:,i) = exp(1i*K0*x'*cos(phi(i)));
    Ie(:,i) = Z\Ve(:,i);
end


for i = 1 : num_theta
    cosTheta = cos(phi(i));
    sinTheta = sin(phi(i));
    E_rad(i) = 0;
    % numerical integration
    for m = 1:M
        x_m = x(m) + deltax;
        E_rad(i) = E_rad(i) + deltax*(Ie(m,i)*eta0 + 0*Ie(m,i)*sinTheta)*exp(1i*K0*x_m*cosTheta); % Summation representation of the integral
    end

end
E_db = mag2db(abs(E_rad));