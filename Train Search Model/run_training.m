function run_training(nitems,order,first_run,max_time)


epsilon=0.05;
ntrials=2e6;

switch order
    case 1
        ranking_type='Descending';
    case 2
        ranking_type='Noisy';
    case 3
        ranking_type='Random';
end

if first_run == 1
%     load([ranking_type '/Relevance_Distribution_' ranking_type '.mat']);
%     load([ranking_type '/Query_Word_Distribution_Visit_' ranking_type '.mat']);
%     load([ranking_type '/Query_Word_Distribution_Read_' ranking_type '.mat']);
%     load('Random_Title_Length.mat');
    load(['Relevance_Distribution_' ranking_type '.mat']);
    load(['Query_Word_Distribution_Visit_' ranking_type '.mat']);
    load(['Query_Word_Distribution_Read_' ranking_type '.mat']);
    load('Random_Title_Length.mat');
else
   ntrials=1e4;
   epsilon=0;
   
   load(strcat('Data_1min_v4_Memory_',ranking_type,'_1000000.mat')); 
%    load([ranking_type '/Relevance_Distribution_' ranking_type '_Test.mat']);
%    load([ranking_type '/Query_Word_Distribution_Visit_' ranking_type '_Test.mat']);
%    load([ranking_type '/Query_Word_Distribution_Read_' ranking_type '_Test.mat']);
   load(['Relevance_Distribution_' ranking_type '_Test.mat']);
   load(['Query_Word_Distribution_Visit_' ranking_type '_Test.mat']);
   load(['Query_Word_Distribution_Read_' ranking_type '_Test.mat']);
   load('Random_Title_Length_Test.mat');
end




if strcmp(ranking_type,'Descending')
    ResultLibrary = relevance_distribution_descending;
    QueryWordVisit = query_word_distribution_visit_descending_relevance;
    QueryWordRead = query_word_distribution_read_descending_relevance;
    clear relevance_distribution_descending
    clear query_word_distribution_visit_descending_relevance
    clear query_word_distribution_read_descending_relevance
    
elseif strcmp(ranking_type,'Noisy')
    ResultLibrary = relevance_distribution_noisy;
    QueryWordVisit = query_word_distribution_visit_noisy_relevance;
    QueryWordRead = query_word_distribution_read_noisy_relevance;
    clear relevance_distribution_noisy
    clear query_word_distribution_visit_noisy_relevance
    clear query_word_distribution_read_noisy_relevance

elseif strcmp(ranking_type,'Random')
    %ecology not yet created
    ResultLibrary = relevance_distribution_random;
    QueryWordVisit = query_word_distribution_visit_random_relevance;
    QueryWordRead = query_word_distribution_read_random_relevance;
    clear relevance_distribution_random
    clear query_word_distribution_visit_random_relevance
    clear query_word_distribution_read_random_relevance
else
    disp('no such result list ordering type')
end



training_model_v4

end