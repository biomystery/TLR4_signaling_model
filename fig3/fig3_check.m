addpath('../mcode/')

id.output = {...
    'IkBa','IkBan','IkBaNFkB','IkBaNFkBn','IkBat', ... % 1-5
    'IkBb','IkBbn','IkBbNFkB','IkBbNFkBn','IkBbt', ... % 6-10
    'IkBe','IkBen','IkBeNFkB','IkBeNFkBn','IkBet', ... % 11-15
    'NFkB','NFkBn',                                ... % 16-17
    'LPSo','LPS','LPSen','TLR4','TLR4en',          ... % 18-22
    'TLR4LPS','TLR4LPSen','MyD88','MyD88s','TRIF', ... % 23-27,MyD88s means M6
    'TRIFs','TRAF6','TRAF6s','IKKK_off','IKKK',    ... % 28-32
    'IKK_off','IKK','IKK_i','TBK1','TBK1s'         ... % 33-37
    'IRF3','IRF3s','IRF3n','IRF3ns'              ... % 38-41
             };

id.genotype = 'wt';
id.dose = 100; 
[np,ip] = getRateParams();
id.DT = .1; 
id.sim_time = 240;



id.inputvPid = [4:6 10]; % np
id.inputvP = np(id.inputvPid); 


sim = getSimData(id); 

%id.inputP = 1; 
id.inputvP = [np(4:6)'*10 5]; 
sim2 = getSimData(id); 

time_seq = 0:id.DT:240; 
h = figure('units','normalized','outerposition',[0 0 1 1])

for i = 1:41
    subplot(6,7,i) 
    plot(time_seq,sim(i,:))
    hold on 
    plot(time_seq,sim2(i,:),'r')
    title(id.output{i})
end

subplot(6,7,42)

plot(time_seq,sum(sim([4,9,13,17],:)))
hold on 
plot(time_seq,sum(sim2([4,9,13,17],:)),'r')
title('Total NFkBn')

legend('norm','3_fold_txn+8m_delay')

%saveas(gca,'fig3_check_tl_delay.fig')

%set(h,'Units','Inches');
%pos = get(h,'Position');
%set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
%print(h,'fig3_check_tl_delay.pdf','-dpdf','-r0')