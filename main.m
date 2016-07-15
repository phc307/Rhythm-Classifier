% main_execute

clc;

%% novelty----(change songs here!!)-----------------------------------------

% filename_novel = ('tango_Albums-Chrisanne3-04.wav');              
% filename_novel = ('tango_Albums-Ballroom_Classics4-06.wav');        
% filename_novel = ('tango_Albums-Ballroom_Magic-06.wav');               
% filename_novel = ('tango_Albums-Step_By_Step-06.wav');
% filename_novel = ('tango_Albums-StrictlyDancing_Tango-11.wav'); 
% filename_novel = ('tango_Albums-StrictlyDancing_Tango-14.wav');
% filename_novel = ('tango_Media-100606.wav'); 
% filename_novel = ('tango_Media-103304.wav');
% filename_novel = ('tango_Media-104305.wav');
% filename_novel = ('tango_Media-104707.wav');

% filename_novel = ('chachacha_Albums-Macumba-01.wav');
% filename_novel = ('chachacha_Albums-Fire-08.wav');
% filename_novel = ('chachacha_Albums-Latin_Jam2-04.wav');
% filename_novel = ('chachacha_Albums-Latin_Jam4-06.wav');
% filename_novel = ('chachacha_Albums-Latino_Latino-06.wav'); 
% filename_novel = ('chachacha_Media-103804.wav');
% filename_novel = ('chachacha_Media-104109.wav');
% filename_novel = ('chachacha_Media-105603.wav');
% filename_novel = ('chachacha_Media-106006.wav');
% filename_novel = ('chachacha_Albums-Fire-08.wav');

% filename_novel = ('rumba_Albums-Cafe_Paradiso-12.wav');
% filename_novel = ('rumba_Albums-AnaBelen_Veneo-01.wav');
% filename_novel = ('rumba_Albums-Fire-03.wav');
% filename_novel = ('rumba_Albums-GloriaEstefan_MiTierra-11.wav');waltz
% filename_novel = ('rumba_Albums-Latin_Jam-05.wav');
% filename_novel = ('rumba_Albums-Latin_Jam3-09.wav');
% filename_novel = ('rumba_Albums-Macumba-11.wav');
% filename_novel = ('rumba_Albums-Pais_Tropical-09.wav');
% filename_novel = ('rumba_Media-105613.wav');
% filename_novel = ('rumba_Media-106111.wav');

% filename_novel = ('waltz_Albums-Ballroom_Classics4-01.wav');
% filename_novel = ('waltz_Albums-Ballroom_Magic-18.wav');
% filename_novel = ('waltz_Albums-Chrisanne1-03.wav');
% filename_novel = ('waltz_Albums-Chrisanne3-03.wav');
% filename_novel = ('waltz_Albums-Secret_Garden-01.wav');
% filename_novel = ('waltz_Albums-Step_By_Step-04.wav');
% filename_novel = ('waltz_Media-100601.wav');
% filename_novel = ('waltz_Media-103303.wav');
% filename_novel = ('waltz_Media-105105.wav');
% filename_novel = ('waltz_Media-105503.wav');%




% novelty----(change songs here!!)-----------------------------------------


[y,Fs] = audioread(filename_novel);
t = length(y)/Fs;
% soundsc(y,Fs);

%% input files for database (t:tango, c:chachacha, r:rumba, w:waltz)

filename_t1 = ('tango_Albums-Step_By_Step-08.wav');
filename_t2 = ('tango_Albums-Ballroom_Classics4-09.wav');
filename_t3 = ('tango_Albums-Chrisanne2-05.wav');
filename_t4 = ('tango_Albums-StrictlyDancing_Tango-02.wav');
filename_t5 = ('tango_Media-105705.wav');
filename_t6 = ('tango_Media-105707.wav');
filename_t7 = ('tango_Albums-Ballroom_Magic-08.wav');
filename_t8 = ('tango_Media-105903.wav');
filename_t9 = ('tango_Media-105806.wav');
filename_t10 = ('tango_Media-105906.wav');

filename_c1 = ('chachacha_Albums-Fire-14.wav');
filename_c2 = ('chachacha_Albums-I_Like_It2-01.wav');
filename_c3 = ('chachacha_Albums-Latin_Jam-04.wav');
filename_c4 = ('chachacha_Albums-Cafe_Paradiso-07.wav');
filename_c5 = ('chachacha_Media-103803.wav');
filename_c6 = ('chachacha_Media-103510.wav');
filename_c7 = ('chachacha_Albums-Pais_Tropical-07.wav');
filename_c8 = ('chachacha_Albums-Cafe_Paradiso-08.wav');
filename_c9 = ('chachacha_Albums-Mambo_Kings-12.wav');
filename_c10 = ('chachacha_Albums-I_Like_It2-02.wav');

filename_r1 = ('rumba_Media-106010.wav');
filename_r2 = ('rumba_Albums-Cafe_Paradiso-09.wav');
filename_r3 = ('rumba_Albums-Fire-10.wav');
filename_r4 = ('rumba_Albums-GloriaEstefan_MiTierra-08.wav');
filename_r5 = ('rumba_Albums-Latin_Jam-08.wav');
filename_r6 = ('rumba_Albums-Latin_Jam2-07.wav');
filename_r7 = ('rumba_Albums-Macumba-10.wav');
filename_r8 = ('rumba_Albums-Pais_Tropical-10.wav');
filename_r9 = ('rumba_Albums-AnaBelen_Veneo-15.wav');
filename_r10 = ('rumba_Media-105615.wav');

filename_w1 = ('waltz_Albums-Ballroom_Classics4-03.wav');
filename_w2 = ('waltz_Albums-Ballroom_Magic-02.wav');
filename_w3 = ('waltz_Albums-Chrisanne1-01.wav');
filename_w4 = ('waltz_Albums-Commitments-11.wav');
filename_w5 = ('waltz_Albums-Fire-13.wav');
filename_w6 = ('waltz_Albums-Secret_Garden-06.wav');
filename_w7 = ('waltz_Albums-Step_By_Step-02.wav');
filename_w8 = ('waltz_Media-104203.wav');
filename_w9 = ('waltz_Media-104601.wav');
filename_w10 = ('waltz_Media-105803.wav');

win_size = 4096;
hop_size = 2048;


nbands = 38; % number of filter bank
NBINS = 25; % 5 per octave, five octaves, +1 for the end.


%% database of OP (t:tango, c:chachacha, w: waltz)
op_t1 = onset_pattern2(filename_t1,win_size,hop_size,nbands,NBINS);
op_t2 = onset_pattern2(filename_t2,win_size,hop_size,nbands,NBINS);
op_t3 = onset_pattern2(filename_t3,win_size,hop_size,nbands,NBINS);
op_t4 = onset_pattern2(filename_t4,win_size,hop_size,nbands,NBINS);
op_t5 = onset_pattern2(filename_t5,win_size,hop_size,nbands,NBINS);
op_t6 = onset_pattern2(filename_t6,win_size,hop_size,nbands,NBINS);
op_t7 = onset_pattern2(filename_t7,win_size,hop_size,nbands,NBINS);
op_t8 = onset_pattern2(filename_t8,win_size,hop_size,nbands,NBINS);
op_t9 = onset_pattern2(filename_t9,win_size,hop_size,nbands,NBINS);
op_t10 = onset_pattern2(filename_t10,win_size,hop_size,nbands,NBINS);

op_c1 = onset_pattern2(filename_c1,win_size,hop_size,nbands,NBINS);
op_c2 = onset_pattern2(filename_c2,win_size,hop_size,nbands,NBINS);
op_c3 = onset_pattern2(filename_c3,win_size,hop_size,nbands,NBINS);
op_c4 = onset_pattern2(filename_c4,win_size,hop_size,nbands,NBINS);
op_c5 = onset_pattern2(filename_c5,win_size,hop_size,nbands,NBINS);
op_c6 = onset_pattern2(filename_c6,win_size,hop_size,nbands,NBINS);
op_c7 = onset_pattern2(filename_c7,win_size,hop_size,nbands,NBINS);
op_c8 = onset_pattern2(filename_c8,win_size,hop_size,nbands,NBINS);
op_c9 = onset_pattern2(filename_c9,win_size,hop_size,nbands,NBINS);
op_c10 = onset_pattern2(filename_c10,win_size,hop_size,nbands,NBINS);

op_r1 = onset_pattern2(filename_r1,win_size,hop_size,nbands,NBINS);
op_r2 = onset_pattern2(filename_r2,win_size,hop_size,nbands,NBINS);
op_r3 = onset_pattern2(filename_r3,win_size,hop_size,nbands,NBINS);
op_r4 = onset_pattern2(filename_r4,win_size,hop_size,nbands,NBINS);
op_r5 = onset_pattern2(filename_r5,win_size,hop_size,nbands,NBINS);
op_r6 = onset_pattern2(filename_r6,win_size,hop_size,nbands,NBINS);
op_r7 = onset_pattern2(filename_r7,win_size,hop_size,nbands,NBINS);
op_r8 = onset_pattern2(filename_r8,win_size,hop_size,nbands,NBINS);
op_r9 = onset_pattern2(filename_r9,win_size,hop_size,nbands,NBINS);
op_r10 = onset_pattern2(filename_r10,win_size,hop_size,nbands,NBINS);

op_w1 = onset_pattern2(filename_w1,win_size,hop_size,nbands,NBINS);
op_w2 = onset_pattern2(filename_w2,win_size,hop_size,nbands,NBINS);
op_w3 = onset_pattern2(filename_w3,win_size,hop_size,nbands,NBINS);
op_w4 = onset_pattern2(filename_w4,win_size,hop_size,nbands,NBINS);
op_w5 = onset_pattern2(filename_w5,win_size,hop_size,nbands,NBINS);
op_w6 = onset_pattern2(filename_w6,win_size,hop_size,nbands,NBINS);
op_w7 = onset_pattern2(filename_w7,win_size,hop_size,nbands,NBINS);
op_w8 = onset_pattern2(filename_w8,win_size,hop_size,nbands,NBINS);
op_w9 = onset_pattern2(filename_w9,win_size,hop_size,nbands,NBINS);
op_w10 = onset_pattern2(filename_w10,win_size,hop_size,nbands,NBINS);


%% op of novel signal
op_novel = onset_pattern2(filename_novel,win_size,hop_size,nbands,NBINS);

%% make same rhythm in one training feature  (t:tango, c:chachacha, w: waltz)

training_feature_t = cat(2,op_t1,op_t2,op_t3,op_t4,op_t5...
    ,op_t6,op_t7,op_t8,op_t9,op_t10);

training_feature_c = cat(2,op_c1,op_c2,op_c3,op_c4,op_c5...
    ,op_c6,op_c7,op_c8,op_c9,op_c10);

training_feature_r = cat(2,op_r1,op_r2,op_r3,op_r4,op_r5...
    ,op_r6,op_r7,op_r8,op_r9,op_r10);

training_feature_w = cat(2,op_w1,op_w2,op_w3,op_w4,op_w5...
    ,op_w6,op_w7,op_w8,op_w9,op_w10);

novel_feature = op_novel; 


rhythm_type = classification(training_feature_t,training_feature_c,...
    training_feature_r, training_feature_w, novel_feature);


%% plot onset pattern of novel signal

% figure(1);
% xscale = [0 t];
% yscale = [0 5 10 15 20 25];
% 
% imagesc(xscale, yscale, op_novel);
% set(gca, 'YTick', [0 5 10 15 20 25]);
% set(gca,'YTickLabel',{'30';'60';'120';'240';'480';'960'})
% 
% colorbar;
% 
% title('Novel signal Onset Pattern');
% xlabel('sec');
% ylabel('bpm');




rhythm_type;



