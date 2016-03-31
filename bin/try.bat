@cls
@normalize.exe -mm db.csv -o dbn.csv
@normalize.exe -mm db.csv -data s.csv -o sn.csv

@echo:
@echo euclidean
@knn.exe -db dbn.csv -s sn.csv -k 100 -d canberra -w 0.0 1.0 1.0 0.0 0.0 0.0 0.0 0.0

