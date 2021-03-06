% function to compare the results generated by bootstrapping and running
% the experiment 10 times
clear all; clc; close all;
% experiments={'07_11.34.10','07_22.41.51','08_07.48.47','08_17.07.02',...
%     '09_02.32.07','09_11.30.40','09_20.25.55','10_05.14.45','10_14.12.43',...
%     '10_23.04.10'};
% experiments=cellfun(@(x) sprintf('~/codes/jcas/results/Train_2014_05_07_05.06.26/test_1/2014_05_%s/stats.mat',x),...
%     experiments,'uniformoutput',false);
% for i=1:length(experiments)
%     cmd=sprintf('scp foo:%s stats_%d.mat',experiments{i},i);
%     disp(cmd);
% end
N=10;
stats_files=arrayfun(@(x) sprintf('results/jcas_results/stats_%d.mat',x),...
    1:N,'uniformoutput',false);
r_int=cell(1,N);
for i=1:N
    tmp=load(stats_files{i});
    cmatrix=tmp.cmatrixP;
    c = sum(cmatrix,3); 
    r_int{i} = (diag(c)./(sum(c,2)+sum(c)'-diag(c)));
end
r_int=cat(2,r_int{:});
for i=1:size(r_int,1)
    fprintf('class: %d mean: %f std: %f \n',i,mean(r_int(i,:)),std(r_int(i,:),1)*sqrt(N));
end
