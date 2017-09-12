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
    if (timeInSec(n) >= 1)
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

[onset_seconds1, duration_seconds1, pitch_frequency1, quantized_frequency1] = textread('01-D_AMairena.f0.Corrected.txt','%f %f %f %f'); 
[y1, fs] = audioread('01-D_AMairena.wav');
estimation1 = myPitchTrackAcf(y1, 1024, 512, fs);
rms1 = myEvaluation(estimation1, pitch_frequency1);

[onset_seconds2, duration_seconds2, pitch_frequency2, quantized_frequency2] = textread('24-M1_AMairena-Martinete.f0.Corrected.txt','%f %f %f %f'); 
[y2, fs] = audioread('24-M1_AMairena-Martinete.wav');
estimation2 = myPitchTrackAcf(y2, 1024, 512, fs);
rms2 = myEvaluation(estimation2, pitch_frequency2);

[onset_seconds3, duration_seconds3, pitch_frequency3, quantized_frequency3] = textread('63-M2_AMairena.f0.Corrected.txt','%f %f %f %f'); 
[y3, fs] = audioread('63-M2_AMairena.wav');
estimation3 = myPitchTrackAcf(y3, 1024, 512, fs);
rms3 = myEvaluation(estimation3, pitch_frequency3);

rms1
rms2
rms3