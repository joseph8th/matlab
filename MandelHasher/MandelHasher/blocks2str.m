function strOut = blocks2str(blocksIn)
% Function to turn short u/c string into ASCII code blocks of length N.
% By JEdwards for MandelHasher, 2011

numChars = length(char(blocksIn{1}))/3;   % since ASCII codes 3 digits
numBlocks = length(blocksIn);
strLength = numChars*numBlocks;

for i = 1:numBlocks
    k = (i - 1)*numChars;
    blockTemp = char(blocksIn{i});
    for j = 1:numChars
        q = (j - 1)*3;
        charTemp = blockTemp((q + 1):(q + 3));
        charStr(i,j) = cellstr(charTemp);
    end
end
charStr = reshape(transpose(charStr),1,strLength);

for i = 1:strLength
    numTemp = str2double(char(charStr(i)));
    strTemp(i) = char(numTemp);
end

strOut = strTemp(strTemp~='|');

return;