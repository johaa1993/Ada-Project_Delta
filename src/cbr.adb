package body CBR is

   function Calc_Manhattan_Distance (X : Float_Vectors.Vector; Y : Float_Vectors.Vector) return Float is
      S : Float := 0.0;
   begin
      for I in X.First_Index .. X.Last_Index loop
         S := S + abs (X (I) - Y (I));
      end loop;
      return S;
   end;

   function Calc_Canberra_Distance (X : Float_Vectors.Vector; Y : Float_Vectors.Vector) return Float is
      S : Float := 0.0;
   begin
      for I in X.First_Index .. X.Last_Index loop
         S := S + (if X (I) - Y (I) = 0.0 then 0.0 else abs (X (I) - Y (I)) / (abs X (I) + abs Y (I)));
      end loop;
      return S;
   end;

   function Calc_Euclidean_Distance (X : Float_Vectors.Vector; Y : Float_Vectors.Vector) return Float is
      S : Float := 0.0;
   begin
      for I in X.First_Index .. X.Last_Index loop
         S := S + Sqrt ((X (I) - Y (I)) ** 2);
      end loop;
      return S;
   end;

   function Calc_Euclidean2_Distance (X : Float_Vectors.Vector; Y : Float_Vectors.Vector) return Float is
      S : Float := 0.0;
   begin
      for I in X.First_Index .. X.Last_Index loop
         S := S + (X (I) - Y (I)) ** 2;
      end loop;
      return S;
   end;

   procedure Set_Point_Dim_Count (X : out Asset_Vectors.Vector; N : Count_Type) is
   begin
      for E : Asset of X loop
         Float_Vectors.Set_Length (E.Point, N);
      end loop;
   end;

   procedure Get (F : File_Type; X : out Float_Vectors.Vector) is
      V : Float;
   begin
      while not End_Of_Line (F) loop
         Get (F, V);
         Float_Vectors.Append (X, V);
      end loop;
   end;

   procedure Read_Point (X : out Asset_Vectors.Vector; Name : String) is
      F : File_Type;
   begin
      Open (F, In_File, Name);
      for E : Asset of X loop
         Assert (not End_Of_Page (F), "The file " & Name & " has less rows than the class file.");
         Get (F, E.Point);
         Skip_Line (F);
      end loop;
      Close (F);
   end;

   procedure Read_Class (X : out Asset_Vectors.Vector; Name : String) is
      F : File_Type;
   begin
      Open (F, In_File, Name);
      while not End_Of_Page (F) loop
         declare
            A : Asset;
         begin
            Get (F, A.Class);
            Get (F, A.Point);
            Asset_Vectors.Append (X, A);
         end;
      end loop;
      Close (F);
   end;

   procedure Read_Distance (X : out Asset_Vectors.Vector; Name : String) is
      F : File_Type;
   begin
      Open (F, In_File, Name);
      while not End_Of_Page (F) loop
         declare
            A : Asset;
         begin
            Get (F, A.Class);
            Get (F, A.Dis);
            A.Time := Natural (Line (F));
            Asset_Vectors.Append (X, A);
         end;
      end loop;
      Close (F);
   end;

   procedure Put (X : Float_Vectors.Vector; Fore : Field; Aft : Field) is
   begin
      for E : Float of X loop
         Put (E, Fore, Aft);
      end loop;
   end;

   procedure Put (F : File_Type; X : Float_Vectors.Vector) is
   begin
      for E : Float of X loop
         Put (F, E, 3, 5);
      end loop;
   end;

   procedure Put (X : Class_Vectors.Vector; Width : Field) is
   begin
      for E : Natural of X loop
         Put (E, Width);
      end loop;
   end;

   procedure Put (F : File_Type; X : Class_Vectors.Vector) is
   begin
      for E : Natural of X loop
         Put (F, E, 3);
      end loop;
   end;

   procedure Put (X : Prominent_Vectors.Vector) is
   begin
      Put (Tail ("K", 3));
      Put ("|");
      Put (Tail ("Prominent", 10));
      New_Line;
      for I in X.First_Index .. X.Last_Index loop
         Put (I, 3);
         Put ("|");
         Put (X (I).P, 3);
         New_Line;
      end loop;
   end;

   procedure Put (X : Asset_Vectors.Vector) is
      Fore : Field := 2;
      Aft : Field := 3;
   begin
      Put (Tail ("Time", 6));
      Put (Tail ("Class", 6));
      Put (Tail ("Point", Put_Width (Fore, Aft)));
      New_Line;
      for E : Asset of X loop
         Put (E.Time, 6);
         Put (E.Class, 6);
         Put (E.Point, Fore, Aft);
         Put (E.Dis, Fore, Aft);
         New_Line;
      end loop;
   end;

   procedure Put_Dis (X : Asset_Vectors.Vector) is
      Fore : Field := 2;
      Aft : Field := 3;
   begin
      Put (Tail ("Time", 6));
      Put (Tail ("Class", 6));
      Put (Tail ("Prominent", 10));
      Put (Tail ("Distance", Put_Width (Fore, Aft)));
      New_Line;
      for E : Asset of X loop
         Put (E.Time, 6);
         Put (E.Class, 6);
         Put (E.Prominent, 10);
         Put (E.Dis, Fore, Aft);
         New_Line;
      end loop;
   end;

   procedure Write (X : Asset_Vectors.Vector; Name : String) is
      F : File_Type;
   begin
      Create (F, Out_File, Name);
      for E : Asset of X loop
         Put (F, E.Class);
         Put (F, E.Point);
         New_Line (F);
      end loop;
      Close (F);
   end;

   function Calc_Distance (X : Float_Vectors.Vector; Y : Float_Vectors.Vector; Dis_Type : Distance_Type) return Float is
   begin
      case Dis_Type is
         when Manhattan_Type =>
           return Calc_Manhattan_Distance (X, Y);
         when Euclidean_Type =>
           return Calc_Euclidean_Distance (X, Y);
         when Euclidean2_Type =>
           return Calc_Euclidean2_Distance (X, Y);
         when Canberra_Type =>
            return Calc_Canberra_Distance (X, Y);
         when others =>
            Assert (False, "Unsupported distance");
            return 0.0;
      end case;
   end;

   procedure Calc_Distance (X : in out Asset_Vectors.Vector; Y : Asset; Dis_Type : Distance_Type) is
   begin
      for E : Asset of X loop
         Float_Vectors.Append (E.Dis, Calc_Distance (E.Point, Y.Point, Dis_Type));
      end loop;
   end;

   procedure Calc_Distance (X : in out Asset_Vectors.Vector; Y : Asset_Vectors.Vector; Dis_Type : Distance_Type) is
   begin
      for E : Asset of Y loop
         Calc_Distance (X, E, Dis_Type);
      end loop;
   end;

   procedure Write_Distance (X : Asset_Vectors.Vector; Name : String) is
      F : File_Type;
   begin
      Create (F, Out_File, Name);
      for E : Asset of X loop
         Put (F, E.Class);
         Put (F, E.Dis);
         New_Line (F);
      end loop;
      Close (F);
   end;

   procedure Write_Prominent (X : Prominent_Vectors.Vector; Name : String) is
      F : File_Type;
   begin
      Create (F, Out_File, Name);
      for E : Prominent of X loop
         Put (F, E.P);
         New_Line (F);
      end loop;
      Close (F);
   end;

   procedure Sort_Distance (X : in out Asset_Vectors.Vector; I : Positive) is
      function "<" (A, B : Asset) return Boolean is (A.Dis (I) < B.Dis (I));
      package Sorting is new Asset_Vectors.Generic_Sorting ("<");
   begin
      Sorting.Sort (X);
   end;

   procedure Calc_Prominent (X : in out Asset_Vectors.Vector) is
      S : Class_Vectors.Vector;
      M : Integer := -1;
      T : Integer := 0;
   begin
      S.Set_Length (10);
      for E : Natural of S loop
         E := 0;
      end loop;
      for E : Asset of X loop
         S (E.Class) := S (E.Class) + 1;
         if M = S (E.Class) then
            T := 0;
         elsif M < S (E.Class) then
            M := S (E.Class);
            T := E.Class;
         end if;
         E.Prominent := T;
      end loop;
   end;

   procedure Summarize_Prominent (X : Asset_Vectors.Vector; Y : in out Prominent_Vectors.Vector) is
   begin
      for I in Y.First_Index .. Y.Last_Index loop
         Y (I).P (X (I).Prominent) := Y (I).P (X (I).Prominent) + 1;
      end loop;
   end;

   procedure Init_Prominent (X : in out Prominent_Vectors.Vector; Class_Count : Count_Type; K_Count : Count_Type) is
   begin
      X.Set_Length (K_Count);
      for E : Prominent of X loop
         E.P.Set_Length (Class_Count);
         for E1 : Natural of E.P loop
            E1 := 0;
         end loop;
      end loop;
   end;

   function Max_Class (X : Asset_Vectors.Vector) return Natural is
      S : Natural := 0;
   begin
      for E : Asset of X loop
         S := Natural'Max (S, E.Class);
      end loop;
      return S;
   end;

   function Dim_Count_Max (X : Asset_Vectors.Vector) return Natural is
      S : Natural := 0;
   begin
      for E : Asset of X loop
         S := Natural'Max (S, Natural (E.Point.Length));
      end loop;
      return S;
   end;

   function Dim_Count_Min (X : Asset_Vectors.Vector) return Natural is
      S : Natural := Natural'Last;
   begin
      for E : Asset of X loop
         S := Natural'Min (S, Natural (E.Point.Length));
      end loop;
      return S;
   end;

end;
