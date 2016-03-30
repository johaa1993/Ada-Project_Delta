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
with Dev.Math;
with Dev.Args;

procedure Main_Normalize is

   use Dev.Math;
   use Dev.Args;
   use CBR;
   use CBR.Texts;
   use CBR.Readings;
   use Ada.Numerics.Real_Arrays;
   use Ada.Text_IO;
   use Ada.Float_Text_IO;
   use Ada.Command_Line;
   use Ada.Assertions;
   use Ada.Integer_Text_IO;
   use Ada.Containers;
   use Ada.Strings.Fixed;

   procedure Find_Min_Max (X : Asset_Vector; Min : in out Float_Vector; Max : in out Float_Vector) is
   begin
      for E : Asset of X loop
         Find_Min_Max (E.Point, Min, Max);
      end loop;
   end;

   procedure Set_Min_Max (X : Asset_Vector; Min : in out Float_Vector; Max : in out Float_Vector) is
      use Dev.Math.Float_Vectors;
   begin
      for E : Float of X (1).Point loop
         Append (Min, Float'Last);
         Append (Max, Float'First);
      end loop;
   end;

   procedure Normalize (X : in out Asset_Vector; Min : in out Float_Vector; Max : in out Float_Vector) is
   begin
      for E : Asset of X loop
         Normalize (E.Point, Min, Max);
      end loop;
   end;

   X : Asset_Vector;
   Min : Float_Vector;
   Max : Float_Vector;
   P : Natural;

   Help_Text_1 : constant String := "<Asset_File>";
   Help_Text_2 : constant String := "<Asset_File> <Out_Asset_File_Normalized>";
   Help_Text_3 : constant String := "<Asset_Min_Max_File> <Asset_File> <Out_Asset_File_Normalized>";

begin

   if Find_Argument ("-help") > 0 then
      Put_Line ("Help text");
      return;
   end if;



   P := Find_Argument ("-mm");
   Assert (P > 0, "Missing database file -mm flag");
   Read_Class (X, Get_Argument_Value (P + 1));
   Set_Min_Max (X, Min, Max);
   Find_Min_Max (X, Min, Max);

   P := Find_Argument ("-data");
   if P > 0 then
      X.Set_Length (0);
      Read_Class (X, Get_Argument_Value (P + 1));
   end if;

   Normalize (X, Min, Max);

   P := Find_Argument ("-o");
   if P > 0 then
      Write_Class (X, Get_Argument_Value (P + 1));
   else
      Put_Point (X);
   end if;

end;
