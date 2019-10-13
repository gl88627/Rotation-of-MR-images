function image_normalize = image_normalization(image)

image_normalize= (image - min(min(image))) .* (1 / (max(max(image)) - (min(min(image)))));

end

