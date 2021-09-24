function e = compute_error(y,y_)

q = 0;
for i = 1:length(y)
    if y(i) ~= y_(i)
        q = q + 1;
    end
end

e = q / length(y);

end