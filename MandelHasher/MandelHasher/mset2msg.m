function blocksOut = mset2msg(hashesIn,N)
% Function returns msg blocks. By JEdwards for MandelHasher, 2011.

if nargin<2
    N = 1;
end

numHashes = length(hashesIn)
numBlocks = numHashes*2

for i = 1:numHashes
    blockTemp(1,i) = N/real(hashesIn(i))
    blockTemp(2,i) = N/imag(hashesIn(i))
end

blockShort = transpose(reshape(blockTemp,1,numBlocks))
numChars = ceil(length(blockShort)/3)
blocksOut = cellstr(int2str(blockShort))
for i = 1:numBlocks
    if any(isspace(blocksOut{i}))
        blocksOut{i}(isspace(blocksOut{i})) = '0';
    end
end 

return;
