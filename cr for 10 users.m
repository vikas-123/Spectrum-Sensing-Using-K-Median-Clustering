%% 
clear
u=500;
N=2*u;%samples
a=2;
C=2;
Crs=10; %Number of cognitive radio users
PdAnd=0;

Pf=0.01:0.01:1;
Pfa=Pf.^2;
%---------signal-----%
t=1:N;
s1  = randn(1,N);
count =0;
Snrdb=10;
Snreal=power(10,Snrdb/10);

for i=1:length(Pf)
lamda(i)=gammaincinv(1-Pfa(i),u)*2; %theshold
for j=1:Crs %for each node
detect=0;

d=7:0.1:8;


PL=C*(d(j)^-a); 
for sim=1:100
noise = randn(1,N); %Noise production with zero mean and s^2 var
noise_power = mean(noise.^2); %noise average power
amp = sqrt(noise.^2*Snreal);
s1=amp.*s1./abs(s1);
% SNRdB_Sample=10*log10(s1.^2./(noise.^2));
Rec_signal=s1+noise;%received signal

localSNR(j)=mean(abs(s1).^2)*PL/noise_power;%local snr
Pdth(j,i)=marcumq(sqrt(2*localSNR(j)),sqrt(lamda(i )),u);%Pd for j node
%Computation of Test statistic for energy detection
Sum=abs(Rec_signal).^2*PL;



%fprintf('%i\n',Sum);

Test(j,sim)=sum(Sum);


 
%fprintf('%i\n',Test(j,sim));

%count = count+1;

if (abs(Test(j,sim)-449.472966900000)< abs(Test(j,sim)-472.741436700000))
    detect=detect+1;
end


%if (Test(j,sim)>lamda(i))

    %detect=detect+1;
%fprintf('%i\n',detect );

%end
end %END Monte Carlo
%fprintf('%i\n',max );

Pdsim(j)=detect/sim;%Pd of simulation for the j-th CRuser

%fprintf('%i\n',Pdsim(j) );


end
PdAND(i)=prod(Pdsim);


PdOR(i)=1-prod(1-Pdsim);
end
PdAND5=(Pdth(5,:)).^5;

Pmd5=1-PdAND5;
PdANDth=(Pdth(Crs,:)).^Crs;
%fprintf('%i\n',Crs);
%fprintf('%i\n',PdANDth );
PmdANDth=1-PdANDth; %Probability of miss detection
Pmdsim=1-PdAND;
figure(1);
 plot(Pfa,Pmdsim,'r-*');
title('Complementary ROC of Cooperative sensing with K-medians using 10 CRs');
grid on
axis([0.0001,1,0.0001,1]);
xlabel('Probability of False alarm (Pf)');
ylabel('Probability of  Detection (Pd)');
%legend('Simulation','Theory n=10','Theory n=5');
%%%%%%