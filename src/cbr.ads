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

   package Class_IO is new Ada.Text_IO.Integer_IO (Natural);
   package Natural_IO is new Ada.Text_IO.Integer_IO (Natural);
   package Distance_IO is new Ada.Text_IO.Float_IO (Distance);

   procedure Put_Vector is new Generic_Vectors_Put_Integer_File (Natural, Natural, Class_Vectors, Class_IO);
   procedure Put_Vector is new Generic_Vectors_Put_Float_File (Natural, Distance, Distance_Vectors, Distance_IO);
   procedure Put_Vector is new Generic_Vectors_Put_Float_File (Natural, Float, Dev.Math.Vectors, Ada.Float_Text_IO);

   procedure Put_Vector is new Generic_Vectors_Put_Integer (Natural, Natural, Class_Vectors, Class_IO);
   procedure Put_Vector is new Generic_Vectors_Put_Float (Natural, Distance, Distance_Vectors, Distance_IO);
   procedure Put_Vector is new Generic_Vectors_Put_Float (Natural, Float, Dev.Math.Vectors, Ada.Float_Text_IO);

   procedure Get_Append_Vector is new Generic_Get_Integer_File_Append_Vector (Natural, Natural, Class_Vectors, Class_IO);
   procedure Get_Append_Vector is new Generic_Get_Float_File_Append_Vector (Natural, Distance, Distance_Vectors, Distance_IO);
   procedure Get_Append_Vector is new Generic_Get_Float_File_Append_Vector (Natural, Float, Dev.Math.Vectors, Ada.Float_Text_IO);

   type Asset is record
      Time : Natural := 0;
      Class : Natural := 0;
      Prominent : Integer := 0;
      Point : Dev.Math.Vectors.Vector;
      Dis : Distance_Vectors.Vector;
   end record;

   type Prominent is record
      P : Class_Vectors.Vector;
   end record;

   package Prominent_Vectors is new Ada.Containers.Vectors (Positive, Prominent);
   package Asset_Vectors is new Ada.Containers.Vectors (Positive, Asset);

   procedure Set_Point_Dim_Count (X : out Asset_Vectors.Vector; N : Count_Type);
   procedure Read_Point (X : out Asset_Vectors.Vector; Name : String);
   procedure Read_Class (X : out Asset_Vectors.Vector; Name : String);
   procedure Put (X : Asset_Vectors.Vector);
   procedure Write (X : Asset_Vectors.Vector; Name : String);
   procedure Calc_Distance (X : in out Asset_Vectors.Vector; Y : Asset_Vectors.Vector; Kind : Distances.Kinds.Kind);
   procedure Write_Distance (X : Asset_Vectors.Vector; Name : String);
   procedure Read_Distance (X : out Asset_Vectors.Vector; Name : String);
   procedure Put_Dis (X : Asset_Vectors.Vector);
   procedure Sort_Distance (X : in out Asset_Vectors.Vector; I : Natural);

   procedure Calc_Prominent (X : in out Asset_Vectors.Vector);
   procedure Summarize_Prominent (X : Asset_Vectors.Vector; Y : in out Prominent_Vectors.Vector);
   procedure Init_Prominent (X : in out Prominent_Vectors.Vector; Class_Count : Count_Type; K_Count : Count_Type);
   procedure Put (X : Prominent_Vectors.Vector);
   procedure Write_Prominent (X : Prominent_Vectors.Vector; Name : String);
   procedure Read_Prominent (X : out Prominent_Vectors.Vector; Name : String);
   procedure Eval_Prominent (P : Prominent_Vectors.Vector; X : Asset_Vectors.Vector; Y : out Natural_Vectors.Vector);

   function Max_Class (X : Asset_Vectors.Vector) return Natural;
   function Dim_Count_Min (X : Asset_Vectors.Vector) return Natural;
   function Dim_Count_Max (X : Asset_Vectors.Vector) return Natural;
   procedure Write_Correctness (X : Natural_Vectors.Vector; Name : String);

end;
