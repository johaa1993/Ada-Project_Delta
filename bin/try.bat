@cls
@merge.exe -c class.csv -f f1.csv f2.csv -o db.csv
@normalize.exe -mm db.csv -o db.csv

@echo ==========Informaion==========
@echo:
@info.exe db.csv
@echo:

@echo ==========Distance==========
@echo:
@distance.exe -db db.csv -s s.csv -d manhattan -w 1.0 1.0 1.0
@distance.exe -db db.csv -s s.csv -d manhattan -w 1.0 1.0 1.0 -o d.csv

@echo ==========K-Sort==========
@echo:
@ksort.exe -d d.csv -k 4
@ksort.exe -d d.csv -k 4 -o p.csv
@echo:

@echo ==========Evaluation==========
@echo:
@eval.exe -p p.csv -s s.csv