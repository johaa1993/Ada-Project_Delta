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

package CBR is


   use Ada.Numerics.Real_Arrays;
   use Ada.Text_IO;
   use Ada.Float_Text_IO;
   use Ada.Command_Line;
   use Ada.Assertions;
   use Ada.Integer_Text_IO;
   use Ada.Containers;
   use Ada.Strings.Fixed;

   package Float_Vectors is new Vectors (Positive, Float);
   package Integer_Vectors is new Vectors (Natural, Integer);

   type Asset is record
      Time : Natural := 0;
      Class : Integer := 0;
      Prominent : Integer;
      Point : Float_Vectors.Vector;
      Dis : Float_Vectors.Vector;
   end record;

   type Prominent is record
      P : Integer_Vectors.Vector;
   end record;

   package Prominent_Vectors is new Vectors (Positive, Prominent);
   package Asset_Vectors is new Vectors (Positive, Asset);

   procedure Set_Point_Dim_Count (X : out Asset_Vectors.Vector; N : Count_Type);
   procedure Get (F : File_Type; X : out Float_Vectors.Vector);
   procedure Read_Point (X : out Asset_Vectors.Vector; Name : String);
   procedure Read_Class (X : out Asset_Vectors.Vector; Name : String);
   function Put_Width (Fore : Field; Aft : Field) return Natural is (Fore + Aft + 5);
   procedure Put (X : Float_Vectors.Vector; Fore : Field; Aft : Field);
   procedure Put (F : File_Type; X : Float_Vectors.Vector);
   procedure Put (X : Asset_Vectors.Vector);
   procedure Write (X : Asset_Vectors.Vector; Name : String);
   procedure Calc_Distance (X : in out Asset_Vectors.Vector; Y : Asset_Vectors.Vector);
   procedure Write_Distance (X : Asset_Vectors.Vector; Name : String);
   procedure Read_Distance (X : out Asset_Vectors.Vector; Name : String);
   procedure Put_Dis (X : Asset_Vectors.Vector);
   procedure Sort_Distance (X : in out Asset_Vectors.Vector; I : Positive);
   procedure Calc_Prominent (X : in out Asset_Vectors.Vector);
   procedure Summarize_Prominent (X : Asset_Vectors.Vector; Y : in out Prominent_Vectors.Vector);
   procedure Init_Prominent (X : in out Prominent_Vectors.Vector; Class_Count : Count_Type; K_Count : Count_Type);
   procedure Put (X : Prominent_Vectors.Vector);
   procedure Write_Prominent (X : Prominent_Vectors.Vector; Name : String);

end;
