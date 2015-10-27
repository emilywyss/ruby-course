a = ['white snow', 'winter wonderland', 'melting ice','slippery sidewalk', 'salted roads', 'white trees']

new_array = a.map! {|string| string.split(" ")}

new_new_array = new_array.flatten

p new_new_array
