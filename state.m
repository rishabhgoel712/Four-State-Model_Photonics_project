% state1 is with 0 e-h pair, state2 is with one e-h pair
% state3 is with 2 e-h pairs, state4 is the trap state
% here transition takes place from one state to another without having any
% probability for electron staying back in that same state.

function [next, tinc,tr,on1] =state(st, W1,W2,tau1,tau2,taua,tau)
tr=0;
on1=0;
if st==1
    tinc=1/(W1);
    num=rand();
    if(num<W1*tinc)
        next=2;
    end    
end
if st==2
    tinc=1/(W2+(1/tau1));
    num=rand();
    if(num<W2*tinc)
        next=3;
    else
        next=1;
        on1=1;
    end  
end
if st==3
    tinc=1/((1/tau2)+(1/taua));
    num=rand();
    if(num<(1/tau2)*tinc)
        next=2;
    else
        next=4;
        tr=1;
    end
end
if st==4
    tinc=1/(1/tau);
    num=rand();
    if(num<(1/tau)*tinc)
        next=2;
    end
end
end