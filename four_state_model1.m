clear;
clc;
close all;
tic
tau1=4e-9;  %for transition from state 2 to 1
tau2=1e-9;  %for transition from state 3 to 2
tau=0.8;    %for transition from state 4 to 1
taua=100e-9; %for transition from state 3 to 4
s1=1e-15;   %cross section of NC
s2=1e-15;   %cross section of NC
h=2.5*1.6e-19;
I=0.08e3;   %intensity 
W1=s1*I/h;  %rate of transition from state 1 to 2
W2=s2*I/h;  %rate of transition from state 2 to 3
bin_size=10e-3; 
trap=0; %count total number of trap states(3 to 4)
on=0;   %count total number of on states(2 to 1)
i=3;    %index for array
n=800000;%total number of iterations
t(1)=0;  %time array
next(1)=1;%stores the sequence of states with initial state as 1
on(1)=0;
[next(2), tinc(1),tr,on1]=state(next(1), W1,W2,tau1,tau2,taua,tau); %next state is determined
on(2)=on1;
t(2)=t(1)+tinc(1);
while i<=n
    [next(i), tinc(i-1),tr,on1]=state(next(i-1),W1,W2,tau1,tau2,taua,tau); %iteratively next state is determined 
    trap=trap+tr;
    on(i)=on1;
    t(i)=t(i-1)+tinc(i-1);
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

    figname_png = ['Intensity and time for 4 state model 1.png'];
    figname = ['Intensity and time for 4 state model 4'];
    width = 30;
    height = 10;
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperSize', [width height]);
    set(gcf, 'PaperPosition', [0 0 width height]);
    set(gca,'position',[0.1 0.19 .85 .7]);% specify these as the fraction of the total.. between 0 and 1

    print('-dpng','-r125',figname_png);
j=1;
for k=1:length(on2)
    if(on2(k)>mean(on2))
        on22(k)=1;
    else
        on22(k)=0;
    end
end
for i=1:length(t1)-1
  if(on22(i)-on22(i+1)>0)
      flag(j)=0;
      cr(j)=t1(i);
      j=j+1;
  end
   if(on22(i)-on22(i+1)<0)
      flag(j)=1;
      cr(j)=t1(i);
      j=j+1;
  end
end
b=1;
c=2;
ton(1)=cr(1);
for a=1:length(cr)-1
    if(flag(a)==0 && flag(a+1)==1)
        toff(b)=cr(a+1)-cr(a);
        b=b+1;
    end
    if(flag(a)==1 && flag(a+1)==0)
        ton(c)=cr(a+1)-cr(a);
        c=c+1;
    end
end
binranges=0.1:0.2:max(ton);    %stores the various bins
figure();
hist(ton,binranges)% bincounts stores the number of indices of t array in each bin
title('Ton','fontsize',16);
%   set(h_legend,'fontsize',16, 'box', 'off');
xlabel('duration of interval','fontsize',24);
ylabel('Probabilty density','fontsize',24);
set(gca, 'Fontsize',24);
figname_png1 = ['on histogram.png'];
figname1 = ['on histogram'];
width = 20;
height = 10;
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperSize', [width height]);
set(gcf, 'PaperPosition', [0 0 width height]);
set(gca,'position',[0.1 0.19 .85 .7]);% specify these as the fraction of the total.. between 0 and 1
print('-dpng','-r125',figname_png1);
binranges=0.1:0.2:max(toff);    %stores the various bins
figure();
hist(toff,binranges)% bincounts stores the number of indices of t array in each bin
title('Toff','fontsize',16);
%   set(h_legend,'fontsize',16, 'box', 'off');
xlabel('duration of interval','fontsize',24);
ylabel('Probabilty density','fontsize',24);
set(gca, 'Fontsize',24);
figname_png2 = ['off histogram.png'];
figname2 = ['off histogram'];
width = 20;
height = 10;
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperSize', [width height]);
set(gcf, 'PaperPosition', [0 0 width height]);
set(gca,'position',[0.1 0.19 .85 .7]);% specify these as the fraction of the total.. between 0 and 1
print('-dpng','-r125',figname_png2);
toc