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

procedure Main_Distance is

   use CBR;
   use Ada.Numerics.Real_Arrays;
   use Ada.Text_IO;
   use Ada.Float_Text_IO;
   use Ada.Command_Line;
   use Ada.Assertions;
   use Ada.Integer_Text_IO;
   use Ada.Containers;
   use Ada.Strings.Fixed;

   function Get_Distance_Type (Name : String) return Distance_Type is
   begin
      if Name = "euclidean" then
         return Euclidean_Type;
      elsif Name = "euclidean2" then
         return Euclidean2_Type;
      elsif Name = "canberra" then
         return Canberra_Type;
      elsif Name = "manhattan" then
         return Manhattan_Type;
      else
         Assert (False, "Distance type unknown");
         return Unknown_Distance_Type;
      end if;
   end;

   X : Asset_Vectors.Vector;
   Y : Asset_Vectors.Vector;

   Help_Text_1 : constant String := "<Asset_File> <Sample_File> <Distance_Type>";
   Help_Text_2 : constant String := "<Asset_File> <Sample_File> <Distance_Type> <Out_Distance_File>";



begin

   if Argument_Count = 3 then
      Read_Class (X, Argument (1));
      Read_Class (Y, Argument (2));
      Calc_Distance (X, Y, Get_Distance_Type (Argument (3)));
      Put_Dis (X);
   elsif Argument_Count = 4 then
      Read_Class (X, Argument (1));
      Read_Class (Y, Argument (2));
      Calc_Distance (X, Y, Get_Distance_Type (Argument (3)));
      Write_Distance (X, Argument (4));
   else
      Put_Line ("Argument_Count must be 3 or 4.");
      Put_Line ("Usage: " & Help_Text_1);
      Put_Line ("Usage: " & Help_Text_2);
   end if;

end;

