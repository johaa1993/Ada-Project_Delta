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

procedure Main_Ksort is

   use CBR;
   use Ada.Numerics.Real_Arrays;
   use Ada.Text_IO;
   use Ada.Float_Text_IO;
   use Ada.Command_Line;
   use Ada.Assertions;
   use Ada.Integer_Text_IO;
   use Ada.Containers;
   use Ada.Strings.Fixed;

   procedure Calc_Put (X : in out Asset_Vectors.Vector; P : in out Prominent_Vectors.Vector) is
   begin
      for I in X.First_Element.Dis.First_Index .. X.First_Element.Dis.Last_Index loop
         Sort_Distance (X, I);
         Calc_Prominent (X);
         Summarize_Prominent (X, P);
         Put_Dis (X);
      end loop;
   end;

   procedure Calc (X : in out Asset_Vectors.Vector; P : in out Prominent_Vectors.Vector) is
   begin
      for I in X.First_Element.Dis.First_Index .. X.First_Element.Dis.Last_Index loop
         Sort_Distance (X, I);
         Calc_Prominent (X);
         Summarize_Prominent (X, P);
      end loop;
   end;

   X : Asset_Vectors.Vector;
   P : Prominent_Vectors.Vector;

   Help_Text_1 : constant String := "<Distance_File>";
   Help_Text_2 : constant String := "<Distance_File> <Out_Prominent_File>";

begin

   if Argument_Count = 1 then
      Read_Distance (X, Argument (1));
      Init_Prominent (P, 10, 3);
      Put_Dis (X);
      Calc_Put (X, P);
      New_Line (3);
      Put (P);
   elsif Argument_Count = 2 then
      Read_Distance (X, Argument (1));
      Init_Prominent (P, 10, 3);
      Calc (X, P);
      Write_Prominent (P, Argument (2));
   else
      Put_Line ("Argument_Count must be 1 or 2.");
      Put_Line ("Usage: " & Help_Text_1);
      Put_Line ("Usage: " & Help_Text_2);
   end if;


end;
