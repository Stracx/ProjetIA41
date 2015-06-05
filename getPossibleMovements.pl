%getPossibleMovement(+From, +B, +N, -ListPossibleMovements, P ) 
getPossibleMovement(X, B, N, [X2|R], 1):- d(B, N, X, X2, 1), getPossibleMovement(X, B, N, R, 1).

getPossibleMovement(X, B, N, [X2|R], 1):- not(d(B, N, X, X2, 1)), getPossibleMovement(X, B, N, [X2|R], 1).

getPossibleMovement(X, B, N, [X2|R], 0):- d(N, B, X, X2, 0), getPossibleMovement(X, N, B, R, 0).getPossibleMovement(X, B, N, [X2|R], 0):- not(d(N, B, X, X2, 0)), getPossibleMovement(X, B, N, [X2|R], 0).