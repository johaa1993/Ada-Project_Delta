:loop
@cls
if exist bin\normalize.exe del /F bin\normalize.exe
@gprbuild main.gpr -p
@if exist bin\normalize.exe (
  cd bin
  normalize.exe B.csv S.csv S1.csv as
  cd ..
) else (
  echo "No main.exe try again?"
)

@pause
goto loop
