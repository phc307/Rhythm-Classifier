function [op] =  onset_pattern2(filename,win_size,hop_size,nbands,NBINS)
%% initialization

% clc;
nfft = win_size;
overlap = win_size - hop_size;
[x_t_origin, fs] = audioread(filename);
x_t = x_t_origin;
length(x_t);

%% First STFT + define WINL
[s,f,t] = spectrogram(x_t, hann(win_size), overlap, nfft, fs,'yaxis');
time = length(x_t)/fs;
framepersec = fs/hop_size; % 43.0664frames
WINL = round(3*framepersec);
second_hop = round(0.25*framepersec);

[row,col] = size(s);



%% apply mel filterbank

f_mel = 1127.01028 * log(1 + f / 700);
min_mel_freq = 1127.01028 * log(1 + min(f) / 700);
max_mel_freq = 1127.01028 * log(1 + max(f) / 700);
p = length(f);
mel = linspace(min_mel_freq, max_mel_freq, nbands);

%% find the reference points

near = find_nearest(f_mel,mel);

%% windowing with mel filter bank 
% the first mel bank

for i = 1:p
    if f(i) < f(near(2)) && f(i) >= f(near(1))
        h(i,1) = (f(near(2)) - f(i)) / (f(near(2)) - f(near(1)));
    else
        h(i,1) = 0;
    end
end

    
% the other mel bank
for k = 2:(nbands - 1)
    for i = 1:p
        if f(i) < f(near(k-1))
            h(i,k) = 0;
        elseif f(near(k-1)) <= f(i) && f(i) <= f(near(k))
            h(i,k) = (f(i) - f(near(k-1))) / (f(near(k)) - f(near(k-1)));
            
        elseif f(near(k)) <= f(i) && f(i)<= f(near(k+1))
            h(i,k) = (f(near(k+1)) - f(i)) / (f(near(k+1)) - f(near(k)));
            
        elseif f(i) > f(near(k+1))
            h(i,k) = 0;
        end
    end
end


% the last mel bank

for i = 1:p
    if f(i) > f(near(nbands-1)) && f(i) <= f(near(nbands))
        h(i,nbands) = (f(i) - f(near(nbands-1))) / ...
            (f(near(nbands)) - f(near(nbands-1)));
    else
        h(i,nbands) = 0;
    end
end



mel_power = s.' * h;  
mel_power = mel_power';
[mel_row mel_col] = size(mel_power);

%% Spectral Flux
zero_padd = zeros(mel_row,1); 
size(zero_padd);
s_filter = [zero_padd mel_power];
for c = 2:mel_col %m
    for r = 1:mel_row %k
        Hin(r,c) = abs(s_filter(r,c))-abs(s_filter(r,c-1)) ;        
    end        
end

[r_Hin, c_Hin] = size(Hin);
%% 5-point moving average filter

maf_a = 1;
maf_b = [1/5 1/5 1/5 1/5 1/5];
for c = 1:c_Hin
    Mov_Avg(:,c) = filter(maf_b, maf_a, Hin(:,c));
end

size_Mov_Avg = size(Mov_Avg);

Mov_Avg;

%% Half-wave recitification

HWR = (Mov_Avg + abs(Mov_Avg))/2;
size(HWR);

[r_HWR, c_HWR] = size(HWR);
size_HWR = size(HWR); %38,1367

%% Second STFT - WINL

WINL;%129

for r = 1:r_HWR
    [s2(:,:,r),f2(:,:,r),t2(:,:,r)] = spectrogram(Mov_Avg(r,:), hann(WINL), WINL-second_hop);
end
[r_s2 c_s2 z_s2] = size(s2);% 129   113    38
size(f2);%   129     1    38
size(t2);%     1   113    38


%% second_log_frequency create mel filterbank

p2 = length(f2);%129
log_filtbank2 = logspace(log10(0.5), log10(16), 2*NBINS); % Nbin*2?

f2_sq = squeeze(f2);% 129    38
f2 = f2_sq(:,1);


t2_sq = squeeze(t2); % 113    38
t2 = t2_sq(:,1);

size(f2); %129     1
size(t2); %113     1
size(log_filtbank2);%1,25

near = find_nearest(f2,log_filtbank2);



for i = 1:p2
    if f2(i) < f2(near(2)) && f2(i) >= f2(near(1))
        h2(i,1) = (f2(near(2)) - f2(i)) / (f2(near(2)) - f2(near(1)));
    else
        h2(i,1) = 0;
    end
end

    

for k = 2:(NBINS - 1)
    for i = 1:p2
        if f2(i) < f2(near(k-1))
            h2(i,k) = 0;
        elseif f2(near(k-1)) <= f2(i) && f2(i) <= f2(near(k))
            h2(i,k) = (f2(i) - f2(near(k-1))) / (f2(near(k)) - f2(near(k-1)));
            
        elseif f2(near(k)) <= f2(i) && f2(i)<= f2(near(k+1))
            h2(i,k) = (f2(near(k+1)) - f2(i)) / (f2(near(k+1)) - f2(near(k)));
            
        elseif f2(i) > f2(near(k+1))
            h2(i,k) = 0;
        end
    end
end



for i = 1:p2
    if f2(i) > f2(near(NBINS-1)) && f2(i) <= f2(near(NBINS))
        h2(i,NBINS) = (f2(i) - f2(near(NBINS-1))) / ...
            (f2(near(NBINS)) - f2(near(NBINS-1)));
    else
        h2(i,NBINS) = 0;
    end
end


size(h2); %   129    25
size(s2); %   129   113    38
h2_repeat = repmat(h2,1,1,z_s2);
size(h2_repeat);%  129    25    38
size(s2(:,:,1));%   129   113
size(s2(:,:,1)).'; %   129   
                   %   113
size(h2_repeat(:,:,1));%    129    25

for z = 1 : z_s2
    
    mel_power2(:,:,z) = permute(s2(:,:,z), [2 1 3]) * h2_repeat(:,:,z); 

end
size(mel_power2); % 113    25    38

%% Median matrix (3-D -> 2-D)

mel_power2 = permute(mel_power2,[2 1 3]); % transport matrix
mel_power2_median = median(mel_power2,3); % find median
size(mel_power2_median); %   25   113

%% Normalization (2-D)

[mel_row2 mel_col2] = size(mel_power2_median);

max_mel_power2_median = (max(abs(mel_power2_median))); % 1 113
min_mel_power2_median = (min(abs(mel_power2_median))); % 1 113


for co = 1:mel_col2
    mel_power2_norm(:,co) = (abs(mel_power2_median(:,co))-min_mel_power2_median(1,co))/...
        (max_mel_power2_median(1,co)-min_mel_power2_median(1,co));
end

%% Onset Pattern (size : 25,time in frames)

op = mel_power2_norm;
% op = median(mel_power2_norm,2);
size_op = size(op); % 25   133


%% plot
% figure(1);
% subplot(4,1,1);
% plot(x_t);
% title('Original signal');
% 
% 
% subplot(4,1,2);
% 
% s = spectrogram(x_t);
% plot(s);
% title('First STFT');
% xlabel('frames');
% ylabel('win_size');
% colorbar('off');
% 
% 
% 
% subplot(4,1,3);
% plot(h);
% title('Mel-filter bank');
% 
% 
% 
% subplot(4,1,4);
% imagesc(abs(mel_power));
% title('After Mel-filter bank');
% 
% 
% figure(2);
% 
% subplot(4,1,1);
% imagesc(HWR);
% title('Unsharp mask');
% 
% 
% subplot(4,1,2);
% plot(h2);
% title('Second Log Filter Bank');
% 
% 
% subplot(4,1,3);
% imagesc(mel_power2_norm);
% title('Normalization');
% 
% 
% subplot(4,1,4);
% imagesc(abs(mel_power2_median));
% title('Median of Second STFT');

% figure()
% 
% xscale = [0 t];
% yscale = [0 5 10 15 20 25];
% 
% imagesc(xscale, yscale, op);
% set(gca, 'YTick', [0 5 10 15 20 25]);
% set(gca,'YTickLabel',{'30';'60';'120';'240';'480';'960'})
% 
% colorbar;
% title('Onset Pattern of novelty');
% xlabel('sec');
% ylabel('bpm');





% figure(4)
% 
% subplot(4,1,1);
% imagesc(abs(s2(:,:,1)));
% title('Second STFT-1');
% 
% subplot(4,1,2);
% imagesc(abs(s2(:,:,2)));
% title('Second STFT-2');
% 
% subplot(4,1,3);
% imagesc(abs(s2(:,:,3)));
% title('Second STFT-3');
% 
% subplot(4,1,4);
% imagesc(abs(s2(:,:,38)));
% title('Second STFT-38');

%% plot 2
% figure();
% subplot(3,1,1);
% plot(HWR);
% title('Half-wave recitification');
% 
% subplot(3,1,2);
% plot(Mov_Avg);
% title('5-point moving average');
% 
% 
% subplot(3,1,3);
% xscale = [0 t];
% yscale = [0 5 10 15 20 25];
% 
% imagesc(xscale, yscale, op);
% set(gca, 'YTick', [0 5 10 15 20 25]);
% set(gca,'YTickLabel',{'30';'60';'120';'240';'480';'960'})
% 
% colorbar;
% title('Onset Pattern');
% xlabel('sec');
% ylabel('bpm');

end