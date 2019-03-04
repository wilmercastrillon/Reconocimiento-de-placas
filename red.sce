Data = [a b]
disp(Data)

sigma=0.33//suavidad de ajuste
nbpart=10;//neuronas
maximp = 0.05;//Error
nbcut = 2;//divisiones de nose que
Log =%t;
vec=%t;

//aprendizaje;
[RNA2, stat]=lolimot_learn(Data,sigma,nbpart,maximp,nbcut,Log,vec);

//guardar
err=lolimot_write('salida.txt', RNA2);
//cargar
//[err, RNA2] = lolimot_read('salida.txt')
//Usar red, donde x es un vector
//f = lolimot_estim_vec(x,RNA2)
