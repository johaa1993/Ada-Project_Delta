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

   Help_Text_1 : constant String := "<Class_File> <Feature_Files ...>";
   Help_Text_2 : constant String := "<Class_File> <Feature_Files ...> -o <Out_File>";

begin


   if Argument_Count <= 1 then
      Put_Line ("Argument List");
      for I in 1 .. Argument_Count loop
         Put (I, 3);
         Put (" ");
         Put (Argument (I));
         New_Line;
      end loop;
      Put_Line ("Argument_Count is not larger than 1.");
      Put_Line ("Usage: " & Help_Text_1);
      Put_Line ("Usage: " & Help_Text_2);
      return;
   end if;

   Read_Class (X, Argument (1));

   for I in 2 .. Argument_Count loop
      if Argument (I) (1 .. 2) = "-o" then
         Assert (Argument_Count = I + 1, "Missing Out_File");
         Write (X, Argument (I + 1));
      end if;
      Read_Point (X, Argument (I));
      if I = Argument_Count then
         Put_Point (X);
      end if;
   end loop;





   New_Line;
   Put_Point (X);

end;
