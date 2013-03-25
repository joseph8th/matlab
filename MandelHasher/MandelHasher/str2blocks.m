function blocksOut = str2blocks(stringIn,numChars)
% Function to turn short u/c string into ASCII code blocks of length N.
% By JEdwards for MandelHasher, 2011

% Make stringIn div. by N
remBlocks = mod(length(stringIn),numChars);
if remBlocks>0
    for i = 1:(numChars-remBlocks)
        stringIn = strcat(stringIn,'|');
    end
end
strLength = length(stringIn);

% Convert to ASCII character array w/cell strings length 3
for i = 1:strLength
    charNum(i) = double(stringIn(i));
    charNum2Str(i) = cellstr(int2str(charNum(i)));
    if length(charNum2Str{i})<3
        charNum2Str{i} = strcat('0',charNum2Str{i});
    end
end

% Concat. to blocks of length numChar
numBlocks = strLength/numChars;
for i = 1:numBlocks
    k = (i-1)*numChars;
    blockTemp = charNum2Str(k+1);
    for j = (k + 2):(k + numChars)
        blockTemp = strcat(blockTemp,charNum2Str(j));
    end
    blocksOut{i} = blockTemp;
end

return;