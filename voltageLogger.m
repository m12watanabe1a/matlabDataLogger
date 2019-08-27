a = arduino;

figure
h = animatedline('Color', 'blue');
ax = gca;
ax.YGrid = 'on';
ax.YLim = [0,5];

stop = false;
startTime = datetime('now');
while ~stop
    v = readVoltage(a,'A0');
    t =  datetime('now') - startTime;
    addpoints(h,datenum(t),v);
    ax.XLim = datenum([t-seconds(15) t]);
    datetick('x','keeplimits')
    drawnow;
    stop = readDigitalPin(a,'D12');
end

[timeLogs,vLogs] = getpoints(h);
timeSecs = (timeLogs-timeLogs(1))*24*3600;

T = table(timeSecs',vLogs','VariableNames',{'Time_sec','Voltage_V'});
filename = 'VoltageData.csv';
writetable(T,filename)

close all
clear;