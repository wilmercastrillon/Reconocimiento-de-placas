mf = [-1, 0, 1, 0];
mc = [0, 1, 0, -1];

function valido=val(tam, fila, columna)
    valido = fila>0&&columna>0&&fila<=tam(1)&&columna<=tam(2);
endfunction

function mask=dfs(img_bin, fila, columna)
    tam = size(img_bin);
    mask = zeros(tam(1),tam(2)) == 1;
    cola = zeros(2, (tam(1)*tam(2))/5);
    cola(1,1)=fila;
    cola(2,1)=columna;
    index = 1;
    len = 0;
    col = [tam(2),0];
    
    while index > 0
        x = cola(1, index);
        y = cola(2, index);
        index = index - 1;
        mask(x, y) = %t;
        len = len + 1;
        
        for i = 1:4 
            auxx = x+mf(i);
            auxy = y+mc(i);
            
            if val(tam,auxx,auxy) && mask(auxx,auxy) == %f && img_bin(auxx,auxy)==%f then
                index = index + 1;
                cola(1,index) = auxx;
                cola(2, index) = auxy;
                col(1) = min(col(1),auxy);
                col(2) = max(col(2),auxy);
            end
        end
    end
    save("longitud.dat",'len');
    save("col.dat",'col');
    //disp(col);
endfunction

function res=caracteres(imagen)
    tam = size(imagen);
    img_bin = im2bw(imagen,0.3);
    bloque = int32(tam(2)/6);
    letras = zeros(1,6);
    mitad_fil = int32(tam(1)/2);
    mitad_col = int32(tam(2)/2);
    res = zeros(tam(1),tam(2)) == 1;
    imshow(res);
    con = 0;
    
    i=mitad_col;
    while i>0
        if img_bin(mitad_fil,i)==%f && res(mitad_fil,i)==%f then
            printf('\nVamos a probar %d,%d\n',mitad_fil,i);
            aux = dfs(img_bin, mitad_fil,i);
            load("longitud.dat",'len');
            load("col.dat",'col');
            i = col(1)-1;
            porcentaje = (len/(tam(1)*tam(2)))*100.0;
            printf('1|lon = %d | porcentaje = %.5f\n', len, porcentaje);
            if 2.6 < porcentaje && porcentaje < 8.4 then
                res = res | aux;
                con = con+1;
                imshow(res);
                if con==3 then
                    break;
                end
            end
        end
        i=i-1;
    end
    
    i = mitad_col;
    while i<=tam(2)
        if img_bin(mitad_fil,i)==%f && res(mitad_fil,i)==%f then
            printf('\nVamos a probar %d,%d\n',mitad_fil,i);
            aux = dfs(img_bin, mitad_fil,i);
            load("longitud.dat",'len');
            load("col.dat",'col');
            i = col(2)+1;
            porcentaje = (len/(tam(1)*tam(2)))*100.0;
            printf('2|lon = %d | porcentaje = %.5f\n', len, porcentaje);
            if 2.6 < porcentaje && porcentaje < 8.5 then
                res = res | aux;
                con = con+1;
                imshow(res);
                if con==6 then
                    break;
                end
            end
        end
        i=i+1;
    end
    //imshow(res);
endfunction




