:loop
@cls
if exist bin\distance.exe del /F bin\distance.exe
@gprbuild main.gpr -p
@if exist bin\distance.exe (
  cd bin
  distance.exe B.csv S.csv D.csv
  cd ..
) else (
  echo "No main.exe try again?"
)

@pause
goto loop
