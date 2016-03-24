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
with Ada.Numerics.Elementary_Functions;

with Dev.Math;
with Dev.Math.Distances;
with Dev.Texts;

package CBR is

   use Ada.Numerics.Elementary_Functions;
   use Ada.Numerics.Real_Arrays;
   use Ada.Text_IO;
   use Ada.Float_Text_IO;
   use Ada.Command_Line;
   use Ada.Assertions;
   use Ada.Integer_Text_IO;
   use Ada.Containers;
   use Ada.Strings.Fixed;

   use Dev.Math;
   use Dev.Texts;

   package Class_Vectors is new Ada.Containers.Vectors (Natural, Natural);
   package Natural_Vectors is new Ada.Containers.Vectors (Positive, Natural);
   package Distance_Vectors is new Ada.Containers.Vectors (Natural, Distance);

   subtype Class_Vector is Class_Vectors.Vector;
   subtype Natural_Vector is Natural_Vectors.Vector;
   subtype Distance_Vector is Distance_Vectors.Vector;

   package Class_IO is new Ada.Text_IO.Integer_IO (Natural);
   package Natural_IO is new Ada.Text_IO.Integer_IO (Natural);
   package Distance_IO is new Ada.Text_IO.Float_IO (Distance);

   procedure Put_Vector is new Generic_Vectors_Put_Integer_File (Natural, Natural, Class_Vectors, Class_IO);
   procedure Put_Vector is new Generic_Vectors_Put_Float_File (Natural, Distance, Distance_Vectors, Distance_IO);
   procedure Put_Vector is new Generic_Vectors_Put_Float_File (Natural, Float, Float_Vectors, Ada.Float_Text_IO);

   procedure Put_Vector is new Generic_Vectors_Put_Integer (Natural, Natural, Class_Vectors, Class_IO);
   procedure Put_Vector is new Generic_Vectors_Put_Float (Natural, Distance, Distance_Vectors, Distance_IO);
   procedure Put_Vector is new Generic_Vectors_Put_Float (Natural, Float, Float_Vectors, Ada.Float_Text_IO);

   procedure Get_Append_Vector is new Generic_Get_Integer_File_Append_Vector (Natural, Natural, Class_Vectors, Class_IO);
   procedure Get_Append_Vector is new Generic_Get_Float_File_Append_Vector (Natural, Distance, Distance_Vectors, Distance_IO);
   procedure Get_Append_Vector is new Generic_Get_Float_File_Append_Vector (Natural, Float, Float_Vectors, Ada.Float_Text_IO);

   type Asset is record
      Time : Natural := 0;
      Class : Natural := 0;
      Prominent : Integer := 0;
      Point : Float_Vector;
      Dis : Distance_Vector;
   end record;

   type Prominent is record
      P : Class_Vector;
   end record;

   package Prominent_Vectors is new Ada.Containers.Vectors (Positive, Prominent);
   package Asset_Vectors is new Ada.Containers.Vectors (Positive, Asset);

   subtype Asset_Vector is Asset_Vectors.Vector;
   subtype Prominent_Vector is Prominent_Vectors.Vector;



   procedure Read_Point (X : out Asset_Vector; Name : String);
   procedure Read_Class (X : out Asset_Vector; Name : String);
   procedure Read_Distance (X : out Asset_Vector; Name : String);
   procedure Read_Prominent (X : out Prominent_Vector; Name : String);

   procedure Put (X : Asset_Vector);
   procedure Put_Dis (X : Asset_Vector);
   procedure Put (X : Prominent_Vector);

   procedure Write (X : Asset_Vector; Name : String);
   procedure Write_Distance (X : Asset_Vector; Name : String);
   procedure Write_Correctness (X : Natural_Vector; Name : String);
   procedure Write_Prominent (X : Prominent_Vector; Name : String);

   procedure Calc_Distance (X : in out Asset_Vector; Y : Asset_Vector; Kind : Distances.Kinds.Kind);
   procedure Calc_Prominent (X : in out Asset_Vector);

   function Dim_Count_Min (X : Asset_Vector) return Natural;
   function Dim_Count_Max (X : Asset_Vector) return Natural;

   procedure Summarize_Prominent (X : Asset_Vector; Y : in out Prominent_Vector);
   procedure Init_Prominent (X : in out Prominent_Vector; Class_Count : Count_Type; K_Count : Count_Type);
   procedure Set_Point_Dim_Count (X : out Asset_Vector; N : Count_Type);
   procedure Sort_Distance (X : in out Asset_Vector; I : Natural);
   procedure Eval_Prominent (P : Prominent_Vector; X : Asset_Vector; Y : out Natural_Vector);
   function Max_Class (X : Asset_Vector) return Natural;



end;
