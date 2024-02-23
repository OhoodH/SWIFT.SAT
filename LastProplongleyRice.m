d=400;                                      
f=28;                                
h_t= 400;
h_r= 0.5;
gt=17;                                    
gr=15; 
L=3;
Gdt=6;
Gdr=3;
G=32;
%segma_g = 0.01;%موصلية الارض
%alpha_0 = 8.854 *10^(-12); %معامل الفراغ
f_c =28;

D=linspace(1,1000,1000);

PL_ref = 20*log10(d) + 20*log10(f) + 10*log10(D) + 32.44; %Pathloss refrence 

F_antenna =20*log10(h_t) + 20*log10(h_r) - 44.49;

%F_antenna= 20*log10(1 + (h_t*h_r / d ^ 2) ^ 2);قانون ثاني 

F_diff = 10*log10(1 + (h_t*h_r / d ^ 2) ^ 2);

%F_ground = 20*log10(1-(segma_g/alpha_0*f_c)^ 0.5);

PL_total = PL_ref + F_antenna + F_diff  ;

plot(D,PL_ref)
xlabel('distance (km)' )
ylabel('Path loss (dB)')
title('Path Loss (PL)');
grid on
red_point_distance = 400;
red_point_PL_ref = 20*log10(d) + 20*log10(f)+ 10*log10(red_point_distance) + 32.44;
hold on
plot(red_point_distance, red_point_PL_ref, 'ro'); 
hold off

%Calculate Rss [dBm]
Pt = 40; % Transmitted power in watts
RSS=10 * log10(Pt) + 10 * log10(G * (h_t)) + 10 * log10(G * (h_r))- (PL_total - L) ;
%RSS=10*log10( Pt +PL_total + gt - gr);
%RSS =10*log10( Pt-PL_total+gr*(h_r)+gt*(h_t)-L);  %افضل قانون من ناحية مخرجات الرسمة واتجاة السهم 
%RSS=10*log10(Pt)+10*log10(h_t)+10*log10(h_r)-(PL_total)-L;
figure;
plot(D,RSS)
xlabel('distance (km)');
ylabel('Received Signal Strength (RSS) in dBm');
title('Received Signal Strength (RSS)');
grid on;

     
%Calculate SINR [dBm] 
N=6; %defult value 
IP=3;%defult value
SINR=(-RSS/(N+IP));
D=linspace(1,1000,1000);
figure;
plot(D, SINR)
title('Signal-to-Interference-plus-Noise Ratio (SINR)');
xlabel('Distance (Km)');
ylabel('SINR (dB)');
grid on;

%Calculate Throughput [dBm]
B=10;
efc=0.7;
M=4;
R_C=2;
D=linspace(1,1000,1000);
Throughput=B*10*log2(1+(10.^(-SINR/10)));
%Throughput= B * efc * log2(1 + abs(SINR)/(N + IP)) * R_C;
%Throughput=( B *log2(1 + SINR/N));
%Throughput=(B*efc*log2(1+SINR));
%Throughput=10*log10 (B *efc* log2(M) * R_C);
figure;
plot(D, Throughput)
title('Throughput');
xlabel('Distance (Km)');
ylabel('Throughput (Mbps)');
grid on;