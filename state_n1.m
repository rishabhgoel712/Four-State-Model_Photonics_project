% state1 is with 0 e-h pair, state2 is with one e-h pair
% state3 is with 2 e-h pairs, state4 is the trap state

function [next, tinc,tr,on1,f,num] =state_n1(st, W1,W2,tau1,tau2,taua,tau)
tr=0;
on1=0;
f=rand();
if st==1
    tinc=-log(f)/(W1);
    norm=1/W1;
    num=rand();
    if(num<W1*norm)
        next=2;
    else
        next=1;
    end    
end
if st==2
    tinc=-log(f)/(W2+(1/tau1));
    norm=1/(W2+(1/tau1));
    num=rand();
    if(num<W2*norm)
        next=3;
    elseif (W2*norm<=num && num<(W2+(1/tau1))*norm)
        next=1;
        on1=1;
    else
        next=2;
    end  
end
if st==3
    tinc=-log(f)/((1/tau2)+(1/taua));
    norm=1/((1/tau2)+(1/taua));
    num=rand();
    if(num<(1/tau2)*norm)
        next=2;
    elseif((1/tau2)*norm<=num && num<((1/tau2)+(1/taua))*norm)
        next=4;
        tr=1;
    else
        next=3;
    end
end
if st==4
    tinc=-log(f)/(1/tau);
    norm=1/(1/tau);
    num=rand();
    if(num<(1/tau)*norm)
        next=2;
    else
        next=4;
    end
end
end