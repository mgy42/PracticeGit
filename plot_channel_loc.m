% plot_channel_loc.m
% B. Zimmerman - 4/1/2020
% Tool based on OCP plotting function to visualize specific channels for optical data. It
% takes a montage file and a scalp_dig_fid file.

function plot_channel_loc(mtg, scalp_dig, channel)

[src,det,montage, mchans,wvl] = read_mtg(mtg);
load(scalp_dig,'-mat');

source_label = src{channel};
detector_label = det{channel};

source_index = find(strcmp(source_label,label));
detector_index = find(strcmp(detector_label,label));

hold on
scatter3(dig_scalp(:,1),dig_scalp(:,2),dig_scalp(:,3),'b','filled','LineWidth',0.2)
scatter3(dig_scalp(source_index,1),dig_scalp(source_index,2), dig_scalp(source_index,3),'r','filled','LineWidth',0.2)
scatter3(dig_scalp(detector_index,1),dig_scalp(detector_index,2), dig_scalp(detector_index,3),'r','filled','LineWidth',0.2)

% Here is my first edit
% And here is mine - Mate 
% eds note

end
