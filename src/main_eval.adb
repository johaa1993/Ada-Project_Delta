with Ada.Text_IO;
with Ada.Command_Line;
with Ada.Float_Text_IO;
with Ada.Integer_Text_IO;
with Ada.Numerics.Real_Arrays;
with Ada.Containers.Formal_Vectors;
with Ada.Containers.Vectors;
with Ada.Containers.Indefinite_Vectors;
with Ada.Assertions;
with Ada.Strings.Fixed;
with CBR;

procedure Main_Eval is

   use CBR;
   use Ada.Numerics.Real_Arrays;
   use Ada.Text_IO;
   use Ada.Float_Text_IO;
   use Ada.Command_Line;
   use Ada.Assertions;
   use Ada.Integer_Text_IO;
   use Ada.Containers;
   use Ada.Strings.Fixed;

   P : Prominent_Vectors.Vector;
   S : Asset_Vectors.Vector;
   N : Natural_Vectors.Vector;

   Help_Text_1 : constant String := "<Prominent_File> <Sample_File>";

begin

   if Argument_Count = 2 then
      Read_Prominent (P, Argument (1));
      Read_Class (S, Argument (2));
      Eval_Prominent (P, S, N);
      Put (Tail ("K", 3));
      Put (Tail ("Correct", 10));
      New_Line;
      for I in N.First_Index .. N.Last_Index loop
         Put (I, 3);
         Put (N (I), 10);
         New_Line;
      end loop;
   else
      Put_Line ("Argument_Count must be 2.");
      Put_Line ("Usage: " & Help_Text_1);
   end if;

end;
