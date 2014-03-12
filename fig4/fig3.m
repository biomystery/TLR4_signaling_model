clear; clc; close all;
addpath('../mcode/')


figure('position',[30 30 1200 900]) % fig Endo TC for IKK
mutantName = {'wt','1','2','3','12','13','23','123'}; %shuttling

% subplot 221, time couses
colors={'b','g','r'};
ind=[3,4];
indf = [1 4];
for k=1:2
    km =ind(k);
    subplot(2,3,indf(k))
    for j = 1:3 % different genotypes     
        for i=1:100
            plot(shuttleData{km}{j,i}.simData{2},colors{j});
            hold on ;
        end
    end
    plot([0 240],[0.05 0.05],'--k','linewidth',2)
    xlim([0 240])
    set(gca,'fontsize',16,'xtick',0:60:240,'xticklabel','','yticklabel','')
% $$$     xlabel('Time (mins)')
% $$$     ylabel('NFkBn (uM)')
% $$$     title(strcat('NFkBn',mutantName{km}))
end

%% half-peak time or peak time
id.DT = 1; 
id.timespan = 0:240; 
nam = {'wt'};
ind = [3 4];
indf = [3 6];
nfkbPeakTime = zeros(3,100);
nfkbHalfPeakTime = zeros(3,100);
for km =1:2
    k = ind(km);
    for j = 1:3 % different genotypes     
        for i=1:100
            [pt,hpt]=findPeakHalf(shuttleData{k}{j,i}.simData{2},id);
            nfkbPeakTime(j,i) = pt; 
            nfkbHalfPeakTime(j,i) = hpt;
        end
    end
    subplot(2,3,indf(km))
    plot(alldose,nfkbPeakTime,'linewidth',1.5)
%     ylim([0 240])
    set(gca,'xscale','linear','fontsize',16,'xscale','log'...
        ,'xtick',[.1 1 10 100],'ytick',0:30:120,'xticklabel','','yticklabel','')    
    xlim([0.1 100])
    ylim([0 120])    
% $$$     xlabel('LPS dose (ng/ml)')
% $$$     ylabel('Peak-time (min)')
% $$$     title('NFkBn')
% $$$     legend('Both','TRIF pathway','MyD88 pathway','location','best') 
    
end

%% last time
nam = {'wt','h','l'};
ind = [3 4];
indf = [2 5];
nfkbPeakTime = zeros(3,100);
for km =1:2
    k = ind(km);
    for j = 1:3 % different genotypes     
        for i=1:100
            indIkk = find(shuttleData{k}{j,i}.simData{1}>=.002);
            indNfkb = find(shuttleData{k}{j,i}.simData{2}>=0.05);        
            ikklastTime(j,i) = length(indIkk);
            nfkblastTime(j,i) = length(indNfkb);
            [tmp b] = max(shuttleData{k}{j,i}.simData{2});
            nfkbPeakTime(j,i) = b; 
        end
    end
    subplot(2,3,indf(km))
    plot(alldose,nfkblastTime,'linewidth',1.5)
    ylim([0 240])
    set(gca,'xscale','linear','ytick',0:30:240,'fontsize',16,'xscale','log'...
        ,'xtick',[.1 1 10 100],'xticklabel','','yticklabel','')

    xlim([0.1 100])
% $$$     xlabel('LPS dose (ng/ml)')
% $$$     ylabel('Response duration (min)')
% $$$     title('NFkBn')
    
end


%
%saveas(gca,'./shuttle/fig3.fig')


%% plot the peak sensitivity 

% $$$ close all
% $$$ load ./shuttle/shuttleModule.mat
% $$$ figure('position',[30 30 900 900]) % fig Endo TC for IKK
% $$$ nam = {'wt'};
% $$$ ind = [1 3 4];
% $$$ nfkbPeakTime = zeros(3,100);
% $$$ nfkbPeak = zeros(3,100);
% $$$ for km =1:1
% $$$     k = ind(km);
% $$$     for j = 1:3 % different genotypes     
% $$$         for i=1:100
% $$$             indIkk = find(shuttleData{k}{j,i}.simData{1}>=.002);
% $$$             indNfkb = find(shuttleData{k}{j,i}.simData{2}>=0.05);        
% $$$             ikklastTime(j,i) = length(indIkk);
% $$$             nfkblastTime(j,i) = length(indNfkb);
% $$$             [tmp b] = max(shuttleData{k}{j,i}.simData{2});
% $$$             nfkbPeakTime(j,i) = b; 
% $$$             nfkbPeak(j,i) = tmp;
% $$$         end
% $$$     end
% $$$     plot(alldose,nfkbPeak,'linewidth',1.5)
% $$$ %     ylim([0 240])
% $$$     set(gca,'xscale','linear','fontsize',16,'xscale','log'...
% $$$         ,'xtick',[.1 1 10 100])
% $$$     
% $$$ 
% $$$     xlim([0.1 100])
% $$$     xlabel('LPS dose (ng/ml)')
% $$$     ylabel('Peak (uM)')
% $$$     title(strcat('NFkBn',nam{km}))
% $$$ end