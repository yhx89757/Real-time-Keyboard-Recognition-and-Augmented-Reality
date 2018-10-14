function m_img = masker(index,L)
    dims = size(L);
    m_img = zeros(dims);
    for i = 1:dims(2)
        for j = 1:dims(1)
            if(L(j,i) == index)
                m_img(j,i) = 1;
            end
        end
    end

% m_img = logical(m_img_double);
% imshow(m_img);
end