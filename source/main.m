clc;clear;

%----------------------------%
% first guess
kp(1)= 2; ki(1) = 5;
kp(2)= 6; ki(2) = 3;
kp(3)= 1; ki(3) = 1;
%----------------------------%
hold on;
ylim([-1 15])
% [e(1),c(1,:)] = costfunction( kp(1), ki(1) );
% plot( [0,0.1], [0,c(1,1)],'m-','LineWidth', 2)
% plot( 0.1:0.1:9.1, c(1,:),'m-','LineWidth', 2)
% [e(2),c(2,:)] = costfunction( kp(2), ki(2) );
% plot( [0,0.1], [0,c(2,1)],'g-','LineWidth', 2)
% plot( 0.1:0.1:9.1, c(2,:),'g-','LineWidth', 2)
% [e(3),c(3,:)] = costfunction( kp(3), ki(3) );
% plot( [0,0.1], [0,c(3,1)],'r-','LineWidth', 2)
% plot( 0.1:0.1:9.10, c(3,:),'r-','LineWidth', 2)
for q=1:100
    kp
    ki
    hold on;
    [e(1),c(1,:)] = costfunction( kp(1), ki(1) );
    %plot( 1:0.1:10, c(1,:),'b-','LineWidth', 2)
    [e(2),c(2,:)] = costfunction( kp(2), ki(2) );
    %plot( 1:0.1:10, c(2,:),'g-','LineWidth', 2)
    [e(3),c(3,:)] = costfunction( kp(3), ki(3) );
    %plot( 1:0.1:10, c(3,:),'r-','LineWidth', 2)
    e1=e(1)
    e2=e(2)
    e3=e(3)

    % find the largest cost point
    if e(1)>e(2) && e(1)>e(3)
        H=1;
        if e(2)>e(3)
            M=2;
            L=3;
        else
            M=3;
            L=2;
        end
    elseif e(2)>e(1) && e(2)>e(3)
        H=2;
        if e(1)>e(3)
            M=1;
            L=3;
        else
            M=3;
            L=1;
        end
    elseif e(3)>e(1) && e(3)>e(2)
        H=3;
        if e(2)>e(1)
            M=2;
            L=1;
        else
            M=1;
            L=2;
        end
    end

    % calculate the mid point
    midx=0;midy=0;
    for i=1:3
        if i == H
            continue
        end
        midx=midx+kp(i);
        midy=midy+ki(i);
    end
    midx=midx/2;    midy=midy/2;

    testkp = kp(H) + 2*(midx-kp(H))
    testki = ki(H) + 2*(midy-ki(H))
    [et,ct] = costfunction( testkp, testki );
    et

    if et>e(H)
        kp(H) = testkp - 1.5*(midx-kp(H));
        ki(H) = testki - 1.5*(midy-ki(H));
    elseif et<e(H) && et>e(M)
        kp(H) = testkp - 0.5*(midx-kp(H));
        ki(H) = testki - 0.5*(midy-ki(H));
    elseif et<e(M) && et>e(L)
        kp(H) = testkp;
        ki(H) = testki;
    else
        kp(H) = testkp + 1*(midx-kp(H));
        ki(H) = testki + 1*(midy-ki(H));
    end
    q
    if rem(q,5)==0
        [e(1),c(L,:)] = costfunction( kp(L), ki(L) );
        plot( [0,0.1], [0,c(L,1)],'-','Color',[1-q*0.01 1-q*0.01 0],'LineWidth', 2)
        plot( 0.1:0.1:9.1, c(L,:),'-','Color',[1-q*0.01 1-q*0.01 0], 'LineWidth', 2)
    end
    '---------------------------------'
end
hold on;
plot( [0,0.1], [0,c(L,1)],'b-','LineWidth', 2)
plot( 0.1:0.1:9.1, c(L,:),'b-','LineWidth', 2)