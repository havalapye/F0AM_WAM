function [ts, cs] = F0AM_get_Conc(Cname,varargin)
%function k = UWCM_get_Conc(Cname,varargin)

%19-Jul-2014 16:34:00 J.A.T. UW

%Gets the time series of one or more species returned as variables to
%workspace;
%Can request all time points in a run, or just the end points, if, e.g.
%doing steady state chamber runs
%Must input a structure containing results for a run, and MCMnames of
%species desired. 
%Use 'ends', to select only last time point, or 'all', to return all values
%in each run.

%%Get names of variables already in workspace
for i=1:nargin
    varnames{i} = inputname(i);
end
Ss = []; unit = []; Sps = [];
%get unit specifier

for i=1:length(varargin)
    lkout = [isstruct(varargin{i}) ischar(varargin{i}) isnumeric(varargin{i})];
    if ~any(lkout)
        display(['Unrecognized input ',varargin(i),'. Aborting.'])
        return
    else        
        if isempty(varnames{i})
            
            if ischar(varargin{i}) && exist(varargin{i},'file')~=2
                j = [strfind(varargin{i}, 'molecpercc') strfind(varargin{i}, 'molec/cm3') strfind(varargin{i}, 'ppt') strfind(varargin{i}, 'ppb') strfind(varargin{i}, 'ppm')...
                    strfind(varargin{i}, 'ug/m3')];
                if ~isempty(j)
                    unit = [unit i];
                else
                    if strcmp(varargin{i},'ends')
                        doends = 1;
                    elseif strcmp(varargin{i},'all')
                        doends = 0;
                    end
                end
            end
            if isstruct(varargin{i})
                Ss = [Ss i];
            end
            if isnumeric(varargin{i})
                Sps = [Sps i];
            end
        else
            if isstruct(varargin{i})
                Ss = [Ss i];
            end
            if ischar(varargin{i})
                if exist(varargin{i},'file')==2
                    matfilepath = varargin{i};
                end
            end            
        end
    end
end

%% if you just supplied units at input, I wouldn't have to do this...
if ~isempty(unit)
    if length(unit)>length(Sps)
        display('More units provided than Species to plot, aborting')
    elseif length(unit)<length(Sps)
        display('Not enough unit designations for Species to plot, assuming ppbv for others')
        varargin(end+1:end+(length(Sps)-length(unit))) = 'ppb';
        unit = [unit (length(varargin)-(length(Sps)-length(unit))):length(varargin)];
    end
    
else
    display('No units provided, assuming ppb')
    unit = length(varargin) + 1;
    varargin{unit} = 'ppbv';
end

ugmflag = 0
for i = 1:length(unit)
    unitt{i} = varargin{unit(i)};
    unitx = varargin{unit(i)};
        switch unitx
        case {'ppbv','ppb'}
            units{i} = '.*1';
        case {'pptv','ppt'}
             units{i} = '.*1000';
        case {'ppmv','ppm'}
             units{i} = './1000';
        case {'molecpercc', 'molec/cm3'}
             units{i} = '.*1e-9.*S(kk).Met.M';
        case 'ug/m3'
             units{i} = 'ug/m3';
             ugmflag = 1;
        otherwise
            error('Invalid unit specifier.')
            return
        end
end

matfilepath = 'C:\MATLAB_Emma\Models\F0AM\F0AMv3.1_GP\Tools\SMILES\MCMv331SpeciesInfo.mat';

if ugmflag
    load(matfilepath)
end

cout = [];
tout = [];
for i = 1:length(Ss)
    S = varargin{Ss(i)};
    if length(S)==1 || length(Ss)==1
        for kk = 1:length(S)
            t = S(kk).Time;
            struct2var(S(kk).Conc);
            c = eval(Cname);
            if doends
                c = c(end);
                t = t(end);
            end
            if ~strcmp(units,'ug/m3')
               eval(['c = c',cell2string(units),';'])
               cout = [cout c];
            else
                tm = strcmp(Cname,MCMnames);
                if sum(tm)<1 && strcmp(Cname(end),'p');%when we make particle phase species we don't add them to MCMv331SpeciesInfo
                    tm = strcmp(Cname(1:end-1),MCMnames);
                end
                cugm3 = mr_to_ugm3(c.*1e-9,MolWeight(tm),S(kk).Met.P./1013,S(kk).Met.T);
                cout = [cout cugm3];
            end
            tout = [tout t'];
        end
    elseif length(S)>1 && length(Ss)>1
        display('Enter multiple 1x1 structure arrays, or 1 multidimensional structure, but not both.')
        return
    end
        
end
ts = tout;
cs = cout;
