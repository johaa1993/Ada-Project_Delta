@cls
@merge.exe class.csv f1.csv f2.csv -o db.csv
@normalize.exe db.csv db.csv
@info.exe db.csv
@distance.exe db.csv s.csv manhattan
@distance.exe db.csv s.csv manhattan d.csv
@ksort.exe d.csv 4
@ksort.exe d.csv 4 p.csv
@eval.exe p.csv s.csv