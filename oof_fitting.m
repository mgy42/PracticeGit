freqs = 1:20; oof = 1./freqs;

%% Same slope flatness (exponent), different starting points
linmod.pwr1 = 6.*oof; %6
linmod.pwr2 = 9.*oof; %9 
linmod.pwr3 = 12.*oof; %12
linmod.pwr4 = 15.*oof; %15
linmod.pwr5 = 18.*oof; %18

%Plotting just to check what these slopes look like
fnames = fieldnames(linmod);

for p = 1:numel(fieldnames(linmod))
   plot(linmod.(fnames{p}))
   hold on
end
hold off

% log(f) ~ log(pwr)
log_log = []; resid1 = [];
for m = 1:numel(fieldnames(linmod))
    fitind = polyfit(log(freqs),log(linmod.(fnames{m})),1);
    log_log(m,1) = fitind(1);
    log_log(m,2) = fitind(2);
    fitval = polyval(fitind,log(freqs));
    resid1(m, :) = linmod.(fnames{m}) - exp(fitval);
end
%slopes are the same (-1), intercepts are different, residuals are ~0

% 1/f ~ pwr
raw_raw = []; resid2 = [];
for m = 1:numel(fieldnames(linmod))
    fitind = polyfit(oof,linmod.(fnames{m}),1);
    raw_raw(m,1) = fitind(1);
    raw_raw(m,2) = fitind(2);
    fitval = polyval(fitind,oof);
    resid2(m, :) = linmod.(fnames{m}) - fitval;
end
%slopes are different (pwr at 1 Hz), intercepts are the same, residuals are ~0

% 1/f ~ log(pwr)
raw_log = []; resid3 = [];
for m = 1:numel(fieldnames(linmod))
    fitind = polyfit(oof,log(linmod.(fnames{m})),1);
    raw_log(m,1) = fitind(1);
    raw_log(m,2) = fitind(2);
    fitval = polyval(fitind,oof);
    resid3(m, :) = linmod.(fnames{m}) - fitval; %or maybe exp(fitval)?
end
plot(resid3')

%slopes are the same, intercepts are different, residuals are huge, this is
%because the relationship between 1/f and log(pwr) is not linear
plot(oof, log(linmod.pwr1))

%Voytek et al.
fprime = [freqs' ones(length(freqs),1)];

semi_log = []; resid4 = [];
for m = 1:numel(fieldnames(linmod))
    fitind = polyfit(fprime,log(linmod.(fnames{m})),1);
    semi_log(m,1) = fitind(1);
    semi_log(m,2) = fitind(2);
    fitval = polyval(fitind,oof);
    resid4(m, :) = linmod.(fnames{m}) - fitval; %or maybe exp(fitval)?
end
plot(resid4')

%% Different slope flatness, same starting point

%% Same slope flatness (exponent), different starting points
logmod.pwr1 = 6*oof.^1; %same as the first slope in linmod
logmod.pwr2 = 6*oof.^1.5;
logmod.pwr3 = 6*oof.^2;
logmod.pwr4 = 6*oof.^2.5;
logmod.pwr5 = 6*oof.^3;

%Plotting just to check what these slopes look like
fnames = fieldnames(logmod);

for p = 1:numel(fieldnames(logmod))
   plot(logmod.(fnames{p}))
   hold on
end
hold off

% log(f) ~ log(pwr)
log_log = []; resid1 = []; 
for m = 1:numel(fieldnames(logmod))
    fitind = polyfit(log(freqs),log(logmod.(fnames{m})),1);
    log_log(m,1) = fitind(1);
    log_log(m,2) = fitind(2);
    fitval = polyval(fitind,log(freqs));
    resid1(m, :) = logmod.(fnames{m}) - exp(fitval);
end
%slopes are different, intercepts are the same, residuals are ~0

% 1/f ~ pwr
raw_raw = []; resid2 = []; preds = []; exps = [1, 1.5, 2., 2.5, 3];
for m = 1:numel(fieldnames(logmod))
    fitind = polyfit(oof.^exps(m),logmod.(fnames{m}),1);
    raw_raw(m,1) = fitind(1);
    raw_raw(m,2) = fitind(2);
    fitval = polyval(fitind,oof.^exps(m));
    resid2(m, :) = logmod.(fnames{m}) - fitval;
    preds(m, :) = fitval;
end
%slopes are different, intercepts are different too, residuals can get
%quite big
plot(resid2')

plot(oof,logmod.pwr1) %this is linear
hold on
plot(oof, logmod.pwr2) %not linear anymore

% 1/f ~ log(pwr)
raw_log = []; resid3 = [];
for m = 1:numel(fieldnames(logmod))
    fitind = polyfit(oof,log(logmod.(fnames{m})),1);
    raw_log(m,1) = fitind(1);
    raw_log(m,2) = fitind(2);
    fitval = polyval(fitind,oof);
    resid3(m, :) = logmod.(fnames{m}) - fitval; %or maybe exp(fitval)?
end
plot(resid3')

%slopes are different, intercepts are different, residuals are huge, this is
%because the relationship between 1/f and log(pwr) is not linear
plot(oof, log(logmod.pwr1))

%% Different slope flatness (exponent), different starting points
cmod.pwr1 = 6*oof.^1; %same as the first slope in linmod
cmod.pwr2 = 9*oof.^1.5;
cmod.pwr3 = 12*oof.^2;
cmod.pwr4 = 15*oof.^2.5;
cmod.pwr5 = 18*oof.^3;

%Plotting just to check what these slopes look like
fnames = fieldnames(cmod);

for p = 1:numel(fieldnames(cmod))
   plot(cmod.(fnames{p}))
   hold on
end
hold off

% log(f) ~ log(pwr)
log_log = []; resid1 = [];
for m = 1:numel(fieldnames(cmod))
    fitind = polyfit(log(freqs),log(cmod.(fnames{m})),1);
    log_log(m,1) = fitind(1);
    log_log(m,2) = fitind(2);
    fitval = polyval(fitind,log(freqs));
    resid1(m, :) = cmod.(fnames{m}) - exp(fitval);
end
%slopes and intercepts are different, residuals are ~0
%use exp(intercepts) to get the "intercept" values (which is the slope in a
%1/f ~ pwr model

% 1/f ~ pwr
raw_raw = []; resid2 = [];
for m = 1:numel(fieldnames(cmod))
    fitind = polyfit(oof,cmod.(fnames{m}),1);
    raw_raw(m,1) = fitind(1);
    raw_raw(m,2) = fitind(2);
    fitval = polyval(fitind,oof);
    resid2(m, :) = cmod.(fnames{m}) - fitval;
end
%slopes are different (not exactly the specified slope values though),
%intercepts are different too; residuals can get quite big
plot(resid2')

plot(oof,cmod.pwr1) %this is linear
hold on
plot(oof, cmod.pwr2) %not linear anymore

% 1/f ~ log(pwr)
raw_log = []; resid3 = [];
for m = 1:numel(fieldnames(cmod))
    fitind = polyfit(oof,log(cmod.(fnames{m})),1);
    raw_log(m,1) = fitind(1);
    raw_log(m,2) = fitind(2);
    fitval = polyval(fitind,oof);
    resid3(m, :) = cmod.(fnames{m}) - fitval; %or maybe exp(fitval)?
end
plot(resid3')

%slopes are different, intercepts are different, residuals are huge, this is
%because the relationship between 1/f and log(pwr) is not linear
plot(oof, log(cmod.pwr1))