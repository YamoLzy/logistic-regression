function y = log_transform(x)

y = x;

for i = 1:length(y)
    for j = 1:57
        y(i,j) = log(y(i,j)+0.1);
    end
end

end

