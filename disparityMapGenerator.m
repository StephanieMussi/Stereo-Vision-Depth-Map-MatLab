classdef disparityMapGenerator
    methods
        function [ D ] = disparityMap(~, Pl, Pr, sizeR, sizeC )
            D=zeros(size(Pr), 'single');
            halfSizeR = (sizeR-1)/2;
            halfSizeC = (sizeC-1)/2;
            range = 10;
            [r, c] = size(Pl);
            for i=1:r
                minr = max(1, i - halfSizeR);
                maxr = min(r, i + halfSizeR);
                for j=1:c
                    minc = max(1, j - halfSizeC);
                    maxc = min(c, j + halfSizeC);
                    sampleL = Pl(minr:maxr, minc:maxc);
                    mind = max(-range, 1 - minc);
                    maxd = 0;
                    numOfPixels = maxd - mind + 1;
                    SSD = zeros(numOfPixels, 1);
                    for num=mind:maxd
                        sampleR = Pr(minr:maxr, (minc+num):(maxc+num));
                        pixelIndex = num-mind+1;
                        SSD(pixelIndex, 1) = sumsqr(sampleL-sampleR); %sum(real(ifft2(fft2(sampleR') * fft2(sampleR))), 'all') - 2 * sum(real(ifft2(fft2(sampleR') * fft2(sampleL))), 'all');
                    end
                    [temp, sorted] = sort(SSD);
                    bestMatchIndex = sorted(1, 1);
                    d = bestMatchIndex + mind - 1;
                    D(i, j) = d;
                end
            end
        end
    end
end





