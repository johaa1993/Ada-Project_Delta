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

procedure Main_Merge is

   use CBR;
   use Ada.Numerics.Real_Arrays;
   use Ada.Text_IO;
   use Ada.Float_Text_IO;
   use Ada.Command_Line;
   use Ada.Assertions;
   use Ada.Integer_Text_IO;
   use Ada.Containers;
   use Ada.Strings.Fixed;

   X : Asset_Vectors.Vector;

   Help_Text : constant String := "<Class_File> <Feature_Files ...> <Out_File>";

begin

   if Argument_Count <= 1 then
      Put_Line ("Argument_Count is not larger than 1.");
      Put_Line (" Usage: " & Help_Text);
      return;
   end if;

   Read_Class (X, "BR.csv");

   Put_Line ("Argument List");
   for I in 1 .. Argument_Count loop
      Put (I, 3);
      Put (" ");
      Put (Argument (I));
      New_Line;
   end loop;

   for I in 2 .. Argument_Count - 1 loop
      exit when Argument (I) (1) = '-';
      Read_Point (X, Argument (I));
   end loop;

   Write (X, Argument (Argument_Count));

   New_Line;
   Put (X);

end;
