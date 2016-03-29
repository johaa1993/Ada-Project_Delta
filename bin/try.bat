@cls
@merge.exe class.csv f1.csv f2.csv -o db.csv
@normalize.exe db.csv db.csv

@echo ==========Informaion==========
@echo:
@info.exe db.csv
@echo:

@echo ==========Distance==========
@echo:
@distance.exe db.csv s.csv manhattan
@distance.exe db.csv s.csv manhattan d.csv

@echo ==========K-Sort==========
@echo:
@ksort.exe d.csv 4
@ksort.exe d.csv 4 p.csv
@echo:

@echo ==========Evaluation==========
@echo:
@eval.exe p.csv s.csv