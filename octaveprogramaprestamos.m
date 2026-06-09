% =================================================================
% SIMULADOR DE PRESTAMOS 
% MIGUEL ANGEL MANUBES DE LOS SANTOS 211D23045
% INVESTIGACION DE OPERACIONES
% Cuando la gente pide un préstamo (para un auto o una casa), los bancos muestran mensualidades, pero las personas no entienden cuánto dinero se va realmente a pagar la deuda y cuánto se desperdicia en intereses
% =================================================================
clear; clc;

disp('--- BIENVENIDO AL SIMULADOR FINANCIERO ---');

% 1. CAPTURA DE DATOS
P = input('Introduce el monto del prestamo (ej. 50000): ');
tasa_anual = input('Introduce la tasa de interes anual en % (ej. 12.5): ');
plazo_meses = input('Introduce el plazo en meses (ej. 12): ');

% Asegurar que las variables sean tratadas como escalares individuales
P = P(1);
tasa_anual = tasa_anual(1);
plazo_meses = plazo_meses(1);

% 2. CALCULOS INICIALES
r = (tasa_anual / 100) / 12; 
n = plazo_meses;

% Formula corregida usando .^ para evitar el error de matrices
base = 1 + r;
mensualidad = P * (r * base.^n) / (base.^n - 1);

printf('\n=========================================\n');
printf('Tu mensualidad fija sera de: $%.2f\n', mensualidad);
printf('=========================================\n\n');

% 3. CREACION DE LA TABLA DE AMORTIZACION
balance_pendiente = P;
total_interes_pagado = 0;

historial_saldo = zeros(1, n);
historial_interes_acum = zeros(1, n);
historial_capital_acum = zeros(1, n);

capital_acumulado = 0;

% Encabezado de la tabla
printf('%-5s %-12s %-10s %-12s %-12s\n', 'Mes', 'Mensualidad', 'Interes', 'Abono Cap.', 'Saldo Pend.');
printf('-------------------------------------------------------------\n');

for mes = 1:n
    interes_mes = balance_pendiente * r;
    abono_capital = mensualidad - interes_mes;
    balance_pendiente = balance_pendiente - abono_capital;
    
    total_interes_pagado = total_interes_pagado + interes_mes;
    capital_acumulado = capital_acumulado + abono_capital;
    
    if balance_pendiente < 0
        balance_pendiente = 0;
    end
    
    historial_saldo(mes) = balance_pendiente;
    historial_interes_acum(mes) = total_interes_pagado;
    historial_capital_acum(mes) = capital_acumulado;
    
    printf('%-5d $%-11.2f $%-9.2f $%-11.2f $%-11.2f\n', ...
            mes, mensualidad, interes_mes, abono_capital, balance_pendiente);
end

% 4. RESUMEN FINAL
total_pagado = mensualidad * n;
printf('\n-------------------------------------------------------------\n');
printf('RESUMEN DEL PRESTAMO:\n');
printf('Monto solicitado: $%.2f\n', P);
printf('Total de intereses pagados: $%.2f\n', total_interes_pagado);
printf('Total pagado al final del plazo: $%.2f\n', total_pagado);
printf('-------------------------------------------------------------\n');

% 5. GENERACION DE GRAFICA
meses = 1:n;
plot(meses, historial_saldo, '-b', 'linewidth', 2); 
hold on;
plot(meses, historial_interes_acum, '-r', 'linewidth', 2);
plot(meses, historial_capital_acum, '-g', 'linewidth', 2);

title('Evolucion Economica del Prestamo');
xlabel('Meses');
ylabel('Dinero ($)');
legend('Deuda Pendiente', 'Intereses Pagados', 'Capital Pagado');
grid on;
hold off;