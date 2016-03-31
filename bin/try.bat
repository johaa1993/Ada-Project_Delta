@cls
@normalize.exe -mm db.csv -o dbn.csv
@normalize.exe -mm db.csv -data s.csv -o sn.csv
@echo:
@echo Canberra
@knn.exe -db dbn.csv -s sn.csv -k 10 -d canberra -w 1.0 1.0 1.0 1.0 0.0 1.0 1.0 0.0
@echo:
@echo Manhattan
@knn.exe -db dbn.csv -s sn.csv -k 10 -d manhattan -w 1.0 1.0 1.0 1.0 0.0 1.0 1.0 0.0