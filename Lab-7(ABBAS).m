w = 'ABBAS';
code = arithmetic_coding(w)

function code = arithmetic_coding(w)
alphabets = ['A', 'B', 'S'];
probability = [2/5, 2/5, 1/5];


left = 0;
right = 1;
cumulative_prob = [0, cumsum(probability)];


for i = 1:length(w)
    
    symbol_idx = find(alphabets == w(i));
    symbol_left = left + (right - left) * cumulative_prob(symbol_idx);
    symbol_right = left + (right - left) * cumulative_prob(symbol_idx+1);
    
    
    left = symbol_left;
    right = symbol_right;
end


code = (left + right) / 2;
end
