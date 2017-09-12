figure(1);
testWave = vertcat( mySine( 441, 44100, 1  ), mySine( 882, 44100, 1  ));
[f0, timeInSec] = myPitchTrackAcf(testWave, 1024, 512, 44100);
plot(timeInSec, f0);
title('f0 of test wave');
xlabel('time in s')
ylabel('freq in hz')


diff = zeros(length(f0), 1);
n = 1;
while(n <= length(diff))
    val = 441;
    if (timeInSec(n) > 1)
        val = 882;
    end
    diff(n) = abs(val - f0(n));
    n = n + 1;
end
figure(2);
plot(timeInSec, diff);
title('absolute error of test wave');
xlabel('time in s')
ylabel('abs err in hz')