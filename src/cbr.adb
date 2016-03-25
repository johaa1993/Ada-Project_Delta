package body CBR is

   procedure Set_Point_Dim_Count (X : out Asset_Vector; N : Count_Type) is
      use Dev.Math.Float_Vectors;
   begin
      for E : Asset of X loop
         Set_Length (E.Point, N);
      end loop;
   end;

   procedure Read_Prominent (X : out Prominent_Vector; Name : String) is
      use Prominent_Vectors;
      F : File_Type;
   begin
      Open (F, In_File, Name);
      while not End_Of_Page (F) loop
         declare
            P : Prominent;
         begin
            Get_Append_Vector (F, P.P);
            Append (X, P);
            Skip_Line (F);
         end;
      end loop;
      Close (F);
   end;

   procedure Read_Point (X : out Asset_Vector; Name : String) is
      F : File_Type;
   begin
      Open (F, In_File, Name);
      for E : Asset of X loop
         Assert (not End_Of_Page (F), "The file " & Name & " has less rows than the class file.");
         Get_Append_Vector (F, E.Point);
         Skip_Line (F);
      end loop;
      Close (F);
   end;

   procedure Read_Class (X : out Asset_Vector; Name : String) is
      F : File_Type;
   begin
      Open (F, In_File, Name);
      while not End_Of_Page (F) loop
         declare
            A : Asset;
         begin
            Get (F, A.Class);
            Get_Append_Vector (F, A.Point);
            A.Time := Natural (Line (F));
            Asset_Vectors.Append (X, A);
            Skip_Line (F);
         end;
      end loop;
      Close (F);
   end;

   procedure Read_Distance (X : out Asset_Vector; Name : String) is
      F : File_Type;
   begin
      Open (F, In_File, Name);
      while not End_Of_Page (F) loop
         declare
            A : Asset;
         begin
            Get (F, A.Class);
            Get_Append_Vector (F, A.Dis);
            A.Time := Natural (Line (F));
            Asset_Vectors.Append (X, A);
            Skip_Line (F);
         end;
      end loop;
      Close (F);
   end;

   procedure Write (X : Asset_Vector; Name : String) is
      F : File_Type;
   begin
      Create (F, Out_File, Name);
      for E : Asset of X loop
         Put (F, E.Class);
         Put_Vector (F, E.Point, " ");
         New_Line (F);
      end loop;
      Close (F);
   end;

   procedure Write_Distance (X : Asset_Vector; Name : String) is
      F : File_Type;
   begin
      Create (F, Out_File, Name);
      for E : Asset of X loop
         Put (F, E.Class);
         Put_Vector (F, E.Dis, " ");
         New_Line (F);
      end loop;
      Close (F);
   end;

   procedure Write_Correctness (X : Natural_Vector; Name : String) is
      F : File_Type;
   begin
      Create (F, Out_File, Name);
      for E : Natural of X loop
         Put (F, E, 4);
         New_Line (F);
      end loop;
      Close (F);
   end;

   procedure Write_Prominent (X : Prominent_Vector; Name : String) is
      F : File_Type;
   begin
      Create (F, Out_File, Name);
      for E : Prominent of X loop
         Put_Vector (F, E.P, "");
         New_Line (F);
      end loop;
      Close (F);
   end;

   procedure Put (X : Prominent_Vector) is
   begin
      Put (Tail ("K", 3));
      Put ("|");
      Put (Tail ("Prominent", 10));
      New_Line;
      for I in X.First_Index .. X.Last_Index loop
         Put (I, 3);
         Put ("|");
         Put_Vector (X (I).P, "", 3);
         New_Line;
      end loop;
   end;

   procedure Put_Point (X : Asset_Vector) is
      Fore : Field := 2;
      Aft : Field := 3;
   begin
      Put (Tail ("Time", 6));
      Put (Tail ("Class", 6));
      Put (Tail ("Point", Get_Put_Float_Width (Fore, Aft)));
      New_Line;
      for E : Asset of X loop
         Put (E.Time, 6);
         Put (E.Class, 6);
         Put_Vector (E.Point, "", Fore, Aft);
         Put_Vector (E.Dis, "", Fore, Aft);
         New_Line;
      end loop;
   end;

   procedure Put_Distance (X : Asset_Vector) is
      Fore : Field := 2;
      Aft : Field := 3;
   begin
      Put (Tail ("Time", 6));
      Put (Tail ("Class", 6));
      Put (Tail ("Prominent", 10));
      Put (Tail ("Distance", Get_Put_Float_Width (Fore, Aft)));
      New_Line;
      for E : Asset of X loop
         Put (E.Time, 6);
         Put (E.Class, 6);
         Put (E.Prominent, 10);
         Put_Vector (E.Dis, "", Fore, Aft);
         New_Line;
      end loop;
   end;

   function Calc_Distance (X : Float_Vector; Y : Float_Vector; Kind : Distances.Kinds.Kind) return Distance is
   begin
      case Kind is
         when Distances.Kinds.Manhattan =>
           return Distances.Manhattan (X, Y);
         when Distances.Kinds.Canberra =>
           return Distances.Manhattan (X, Y);
         when Distances.Kinds.Euclidean =>
           return Distances.Manhattan (X, Y);
         when Distances.Kinds.Euclidean2 =>
            return Distances.Manhattan (X, Y);
         when others =>
            Assert (False, "Unsupported distance");
            return 0.0;
      end case;
   end;

   procedure Calc_Distance (X : in out Asset_Vector; Y : Asset; Kind : Distances.Kinds.Kind) is
      use Distance_Vectors;
   begin
      for E : Asset of X loop
         Append (E.Dis, Calc_Distance (E.Point, Y.Point, Kind));
      end loop;
   end;

   procedure Calc_Distance (X : in out Asset_Vector; Y : Asset_Vector; Kind : Distances.Kinds.Kind) is
   begin
      for E : Asset of Y loop
         Calc_Distance (X, E, Kind);
      end loop;
   end;

   procedure Calc_Prominent (X : in out Asset_Vector) is
      S : Class_Vector;
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

   procedure Sort_Distance (X : in out Asset_Vector; I : Natural) is
      function "<" (A, B : Asset) return Boolean is (A.Dis (I) < B.Dis (I));
      package Sorting is new Asset_Vectors.Generic_Sorting ("<");
   begin
      Sorting.Sort (X);
   end;

   procedure Summarize (Item : in out Prominent_Vector; X : Asset_Vector) is
   begin
      Assert (X.First_Index = Item.First_Index, "Index unequal.");
      for I in Item.First_Index .. Natural'Min (Item.Last_Index, X.Last_Index) loop
         Item (I).P (X (I).Prominent) := Item (I).P (X (I).Prominent) + 1;
      end loop;
   end;

   procedure Initialize (Item : in out Prominent_Vector; Class_Count : Count_Type; K_Count : Count_Type) is
      use Prominent_Vectors;
      use Class_Vectors;
   begin
      Set_Length (Item, K_Count);
      for P : Prominent of Item loop
         Set_Length (P.P, Class_Count);
         for C : Natural of P.P loop
            C := 0;
         end loop;
      end loop;
   end;

   function Max_Class (X : Asset_Vector) return Natural is
      S : Natural := 0;
   begin
      for E : Asset of X loop
         S := Natural'Max (S, E.Class);
      end loop;
      return S;
   end;

   function Dim_Count_Max (X : Asset_Vector) return Natural is
      S : Natural := 0;
   begin
      for E : Asset of X loop
         S := Natural'Max (S, Natural (E.Point.Length));
      end loop;
      return S;
   end;

   function Dim_Count_Min (X : Asset_Vector) return Natural is
      S : Natural := Natural'Last;
   begin
      for E : Asset of X loop
         S := Natural'Min (S, Natural (E.Point.Length));
      end loop;
      return S;
   end;

   function Evaluate (Item : Prominent; X : Asset_Vector) return Natural is
      S : Natural := 0;
   begin
      for E : Asset of X loop
         if Item.P (E.Class) > 0 then
            S := S + 1;
         end if;
      end loop;
      return S;
   end;

   procedure Evaluate (Item : Prominent_Vector; X : Asset_Vector; Y : out Natural_Vector) is
      use Natural_Vectors;
   begin
      for E : Prominent of Item loop
         Append (Y, Evaluate (E, X));
      end loop;
   end;

end;
