clear;
clc;
close all;
tic
tau1=4e-9;  %for transition from state 2 to 1
tau2=1e-9;  %for transition from state 3 to 2
tau=0.24;    %for transition from state 4 to 1
taua=100e-9; %for transition from state 3 to 4
s1=1e-15;   %cross section of NC
s2=1e-15;   %cross section of NC
h=2.5*1.6e-19;
I=0.24e3;   %intensity 
W1=s1*I/h;  %rate of transition from state 1 to 2
W2=s2*I/h;  %rate of transition from state 2 to 3
bin_size=10e-3; 
trap=0; %count total number of trap states(3 to 4)
on=0;   %count total number of on states(2 to 1)
i=2;    %index for array
n=9000000;%total number of iterations
t(1)=0;  %time array
next(1)=1;%stores the sequence of states with initial state as 1
on(1)=0;
%[next(2), tinc(1),tr,on1]=state_n(next(1), W1,W2,tau1,tau2,taua,tau); %next state is determined
%on(2)=on1;
%t(2)=t(1)+tinc(1);
while i<=n
    [next(i), tinc(i-1),tr,on1,f,num]=state_n(next(i-1),W1,W2,tau1,tau2,taua,tau); %iteratively next state is determined 
    trap=trap+tr;
    on(i)=on1;
    t(i)=t(i-1)+tinc(i-1);
    
    F(i-1)= f;
    N(i-1) = num;
    i=i+1;
end
n2=fix(max(t)/bin_size);        %number of bins formed
binranges=0:bin_size:max(t);    %stores the various bins
[bincounts, ind]=histc(t,binranges);% bincounts stores the number of indices of t array in each bin
sr=1;
for y=1:n2 %binning method
   on2(y)= sum(on(sr:bincounts(y)+sr));
   st=bincounts(y)+1;
end
t1 = 0:bin_size:(n2-1)*bin_size;
c = [[0,0,0];[0.7,0.7,0.7];[1,0,0];[0,1,0];[0,0,1]];
line_style = {'-','--','-.','-'};
    plot(t1,on2,'Color', [c(3,:)],'LineStyle',line_style{1});
    xlim([0, max(t)]);

    %h_legend = legend('3 level','Location','NorthEast');
    title(['I=',num2str(I),' taua=',num2str(taua),' Noff=',num2str(trap)],'fontsize',16);
 %   set(h_legend,'fontsize',16, 'box', 'off');
    xlabel('time (s)','fontsize',24);
    ylabel('Intensity (a.u.)','fontsize',24);
    set(gca, 'Fontsize',24);

    figname_png = ['Intensity and time for 4 state model 6.png'];
    figname = ['Intensity and time for 4 state model 6'];
    width = 30;
    height = 10;
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperSize', [width height]);
    set(gcf, 'PaperPosition', [0 0 width height]);
    set(gca,'position',[0.1 0.19 .85 .7]);% specify these as the fraction of the total.. between 0 and 1

    print('-dpng','-r125',figname_png);
toc