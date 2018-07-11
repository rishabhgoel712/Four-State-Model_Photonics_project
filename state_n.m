% state1 is with 0 e-h pair, state2 is with one e-h pair
% state3 is with 2 e-h pairs, state4 is the trap state

function [next, tinc,tr,on1] =state_n(st, W1,W2,tau1,tau2,taua,tau)
tr=0;
on1=0;
f=rand();
if st==1
    tinc=f/(W1);
    num=rand();
    if(num<W1*tinc)
        next=2;
    else
        next=1;
    end    
end
if st==2
    tinc=f/(W2+(1/tau1));
    num=rand();
    if(num<W2*tinc)
        next=3;
    elseif (W2*tinc<=num && num<(W2+(1/tau1))*tinc)
        next=1;
        on1=1;
    else
        next=2;
    end  
end
if st==3
    tinc=f/((1/tau2)+(1/taua));
    num=rand();
    if(num<(1/tau2)*tinc)
        next=2;
    elseif((1/tau2)*tinc<=num && num<((1/tau2)+(1/taua))*tinc)
        next=4;
        tr=1;
    else
        next=3;
    end
end
if st==4
    tinc=f/(1/tau);
    num=rand();
    if(num<(1/tau)*tinc)
        next=2;
    else
        next=4;
    end
end
end