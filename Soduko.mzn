include "alldifferent.mzn";

% Lectura de datos:
array[1..9, 1..9] of 0..9: grid;


% Variables:
array[1..9, 1..9] of var 1..9: solution_grid;


% RESTRICCIONES:

% Respetar valores iniciales
constraint forall (r in 1..9, c in 1..9) (
    (grid[r, c] > 0 -> solution_grid[r, c] = grid[r, c])
);

% Restricción de filas:
constraint forall (r in 1..9) (
    alldifferent([solution_grid[r, c] | c in 1..9])
);

% Restricción de columnas:
constraint forall (c in 1..9) (
    alldifferent([solution_grid[r, c] | r in 1..9])
);

% Restricción de subcuadrículas 3x3:
constraint forall (br in 0..2, bc in 0..2) (
    alldifferent([
        solution_grid[3 * br + r, 3 * bc + c] | r in 1..3, c in 1..3
    ])
);

solve satisfy;

output [show(solution_grid[r, c]) ++ if c == 9 then "\n" else " " endif | r in 1..9, c in 1..9];