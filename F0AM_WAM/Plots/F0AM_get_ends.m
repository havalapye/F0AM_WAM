function k = F0AM_get_ends(Sin, varargin)
Snew = Sin;
lt = length(Snew.Time);
Snew.Time = Snew.Time(end);
cnames = fieldnames(Snew.Conc);
c1 = eval(['Snew.Conc.' cnames{1}]);
szconc = size(c1,1);

if lt ~= szconc
    display('Expecting Conc vectors to have number of rows equal to time point. Aborting...')
    return
end



for i = 1:length(cnames)
    eval(['Snew.Conc.',cnames{i},'=Snew.Conc.',cnames{i},'(end);'])
end

snames = fieldnames(Snew)
for i = 1:length(snames)
    if ~strcmp('Conc',snames{i})
        if isstruct(eval(['Snew.',snames{i}]))
            ssnames = fieldnames(eval(['Snew.',snames{i}]));
            for j = 1:length(ssnames)
                if isstruct(eval(['Snew.',snames{i},'.',ssnames{j}]))
                    sssnames = fieldnames(eval(['Snew.',snames{i},'.',ssnames{j}]));
                    for kk = 1:length(sssnames)
                        tmp = eval(['Snew.',snames{i},'.',ssnames{j},'.',sssnames{kk}]);
                        if size(tmp,1)==szconc
                            eval(['Snew.',snames{i},'.',ssnames{j},'.',sssnames{kk},' = tmp(end);']);
                        end
                    end
                else
                    tmp = eval(['Snew.',snames{i},'.',ssnames{j}]);
                    if size(tmp,1)==szconc
                        eval(['Snew.',snames{i},'.',ssnames{j},' = tmp(end);']);
                    end
                end
            end
        else
            tmp = eval(['Snew.',snames{i}]);
            if size(tmp,1)==szconc
                eval(['Snew.',snames{i},' = tmp(end);']);
            end
        end
    end
end

k = Snew;