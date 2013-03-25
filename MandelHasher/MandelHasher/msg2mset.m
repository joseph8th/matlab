function hashesOut = msg2mset(blocksIn,N)
% Function to map message blocks onto points in the Mandelbrot Set.
% By JEdwards for MandelHasher, 2011.
% N a parameter to adjust closeness of hashes to zero

if nargin<2
    N = 1;
end

numBlocks = length(blocksIn);
numHashes = ceil(numBlocks/2);

% Make sure there's an even number of blocks to hash with
numChar = length(blocksIn')/3;
if numHashes > (numBlocks/2)
    newBlock = '124';           % Extra char is '|'
    for i = 2:numChar
        tempBlock = newBlock;
        newBlock = strcat(newBlock,tempBlock);
    end
    blocksIn{numBlocks + 1} = newBlock;
end

% Pair blocks. Extra (if exists) is x paired with 0*i
for i = 0:2:((numHashes*2)-2)
    k = i/2 + 1;
    X = N/str2num(char(blocksIn{i+1}));
    Y = N/str2num(char(blocksIn{i+2}));
    Z(k) = complex(X,Y);
end
    
hashesOut = Z;

return;