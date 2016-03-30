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

procedure Main_Merge is

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

   X : Asset_Vectors.Vector;
   P : Natural;

begin


   P := Find_Argument ("-c");
   Assert (P > 0, "Missing class file -c flag");
   Read_Class (X, Get_Argument_Value (P + 1));

   P := Find_Argument ("-f");

   loop
      exit when P = Argument_Count;
      P := P + 1;
      exit when Get_Argument_Value (P)'Length = 0;
      Read_Point (X, Argument (P));
   end loop;



   P := Find_Argument ("-o");
   if P > 0 then
      Write_Class (X, Get_Argument_Value (P + 1));
   else
      Put_Point (X);
   end if;


end;
