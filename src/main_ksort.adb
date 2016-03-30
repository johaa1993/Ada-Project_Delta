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
with CBR.Texts;
with CBR.Readings;
with Dev.Args;

procedure Main_Ksort is

   use CBR;
   use CBR.Texts;
   use CBR.Readings;
   use Dev.Args;
   use Ada.Numerics.Real_Arrays;
   use Ada.Text_IO;
   use Ada.Float_Text_IO;
   use Ada.Command_Line;
   use Ada.Assertions;
   use Ada.Integer_Text_IO;
   use Ada.Containers;
   use Ada.Strings.Fixed;

   procedure Calc (X : in out Asset_Vector; P : in out Prominent_Vector) is
   begin
      for I in X.First_Element.Dis.First_Index .. X.First_Element.Dis.Last_Index loop
         Sort_Distance (X, I);
         Calc_Prominent (X);
         Summarize (P, X);
      end loop;
   end;

   X : Asset_Vector;
   Y : Prominent_Vector;
   P : Natural;

   Help_Text_1 : constant String := "<Distance_File> <K_Count>";
   Help_Text_2 : constant String := "<Distance_File> <K_Count> <Out_Prominent_File>";

begin



   P := Find_Argument ("-d");
   Assert (P > 0, "Missing distance file -d flag");
   Read_Distance (X, Get_Argument_Value (P + 1));

   P := Find_Argument ("-k");
   Assert (P > 0, "Missing k count -k flag");
   Initialize (Y, Count_Type (Max_Class (X) + 1), Count_Type'Value (Get_Argument_Value (P + 1)));
   Calc (X, Y);

   P := Find_Argument ("-o");
   if P > 0 then
      Write_Prominent (Y, Get_Argument_Value (P + 1));
   end if;

   P := Find_Argument ("-csv");
   if P > 0 then
      Write_Prominent_CSV (Y, Get_Argument_Value (P + 1));
   end if;

   P := Find_Argument ("-put");
   if P > 0 then
      Put (Y);
   end if;



end;
