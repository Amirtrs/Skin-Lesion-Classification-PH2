clc
clear all
close all
warning off

load label.mat

image_dir = 'C:\Users\Amir\Desktop\img';
label_dir = 'C:\Users\Amir\Desktop\label';

bmp_files = dir(fullfile(image_dir, '*.bmp'));
num_images = length(bmp_files);

X = [];
T = [];

for i = 1:num_images
    image_file = fullfile(image_dir, bmp_files(i).name);
    [~, imageName, ~] = fileparts(image_file);
    
    label_file = fullfile(label_dir, [imageName '_lesion.bmp']);
    
    
    [image, map] = imread(image_file);
    if size(image, 3) == 1
        image_gray = image;
    elseif ~isempty(map)
        rgb_image = ind2rgb(image, map);
        image_gray = rgb2gray(rgb_image);
    else
        image_gray = rgb2gray(image);
    end
    
    
    binary_image = imread(label_file);
    
    
    transformations = {'original', 'flip', 'rotate'};
    
    for transform = transformations
        
        switch transform{1}
            case 'flip'
                image_gray = fliplr(image_gray);
                binary_image = fliplr(binary_image);
            case 'rotate'
                image_gray = imrotate(image_gray, 90);
                binary_image = imrotate(binary_image, 90);
        end
        
        
        masked_image = image_gray .* uint8(binary_image);
        
        
        [C,S] = wavedec2(masked_image,3,'db1');
        
        H = wrcoef2('h',C,S,'db1',1);
        V = wrcoef2('v',C,S,'db1',1);
        D = wrcoef2('d',C,S,'db1',1);
        
        
        H_mean = mean(H(:));
        H_std = std(double(H(:)));
        
        V_mean = mean(V(:));
        V_std = std(double(V(:)));
        
        D_mean = mean(D(:));
        D_std = std(double(D(:)));
       c=1; 
        if i == 81
            c=c+1
        end
            
            if i == 161
                c=c+1
            end
        glcm = graycomatrix(masked_image);
        stats = graycoprops(glcm, {'Contrast', 'Correlation', 'Energy', 'Homogeneity'});
        
        asymmetry = sum(abs(masked_image(:,1:end/2) - masked_image(:,end/2+1:end)), 'all');
        border = sum(bwperim(edge(masked_image)), 'all');
        color = std(double(masked_image(:)), 0);
        diameter = max(bwdist(edge(masked_image)), [], 'all');
        
        
        color_mean = mean(double(masked_image(:)));
        color_std = std(double(masked_image(:)));
        
        props = regionprops(binary_image, 'Area', 'Perimeter', 'Eccentricity');
        circularity = 4*pi*props.Area/props.Perimeter^2;
        
        
        
        feature_vector = [H_mean,H_std,V_mean,V_std,D_mean,D_std,...
            stats.Contrast, stats.Correlation, stats.Energy, stats.Homogeneity, ...
            asymmetry, border, color, diameter, ...
            props.Area, props.Perimeter, props.Eccentricity, circularity, ...
            color_mean, color_std];
        X = [X; feature_vector];
        
        
        label_index = strcmp(labels.Name, imageName);
        T = [T; labels.ClinicalDiagnosis(label_index)];
    end
end

save('features.mat', 'X');
save('labels.mat', 'T');

net = fitnet([20]);

net.divideParam.trainRatio = 0.8;
net.divideParam.valRatio = 0.1;
net.divideParam.testRatio = 0.1;

[net, tr] = train(net, X', T');


predictions = net(X');
perf = perform(net, T', predictions);

% Define class labels and unique classes
unique_classes = unique(T);
num_classes = length(unique_classes);
class_mean_table = zeros(num_classes, numel(X(1, :)));

% Compute mean values for each class and feature unit
for i = 1:num_classes
    class_indices = find(strcmp(T, unique_classes{i}));
    class_mean = mean(X(class_indices, :), 1);
    class_mean_table(i, :) = class_mean;
end

% Display the class means in a table
fprintf('Class Mean Table:\n');
fprintf('| Class |');
for j = 1:numel(X(1, :))
    fprintf(' Unit%d |', j);
end
fprintf('\n');
for i = 1:num_classes
    fprintf('| %s |', unique_classes{i});
    for j = 1:numel(X(1, :))
        fprintf(' %.4f |', class_mean_table(i, j));
    end
    fprintf('\n');
end
