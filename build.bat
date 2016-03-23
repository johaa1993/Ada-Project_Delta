:loop
@cls
if exist bin\ksort.exe del /F bin\ksort.exe
@gprbuild main.gpr -p
@if exist bin\ksort.exe (
  cd bin
  ksort.exe D.csv P.csv 123
  cd ..
) else (
  echo "No main.exe try again?"
)

@pause
goto loop
