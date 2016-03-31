package body CBR is

   procedure Normalize (X : in out Asset_Vector; Min : in out Float_Vector; Max : in out Float_Vector) is
      use Dev.Math;
   begin
      for E : Asset of X loop
         Normalize (E.Point, Min, Max);
      end loop;
   end;

   procedure Find_Min_Max (X : Asset_Vector; Min : in out Float_Vector; Max : in out Float_Vector) is
   begin
      for E : Asset of X loop
         Dev.Math.Find_Min_Max (E.Point, Min, Max);
      end loop;
   end;

   procedure Initialize_Min_Max (X : Asset_Vector; Min : in out Float_Vector; Max : in out Float_Vector) is
      use Dev.Math.Float_Vectors;
   begin
      Min := To_Vector (Float'Last, X (1).Point.Length);
      Max := To_Vector (Float'First, X (1).Point.Length);
   end;

   procedure Initialize (Item : in out Prominent_Vector; Class_Count : Natural; K_Count : Natural) is
      use Prominent_Vectors;
      use Class_Vectors;
      use Ada.Containers;
      P : Prominent;
   begin
      P.P := To_Vector (0, Count_Type (Class_Count));
      Item := To_Vector (P, Count_Type (K_Count));
   end;

   function Max_Class (Item : Asset_Vector) return Natural is
      S : Natural := 0;
   begin
      for E : Asset of Item loop
         S := Natural'Max (S, E.Class);
      end loop;
      return S;
   end;

   function Dim_Count_Max (Item : Asset_Vector) return Natural is
      S : Natural := 0;
   begin
      for E : Asset of Item loop
         S := Natural'Max (S, Natural (E.Point.Length));
      end loop;
      return S;
   end;

   function Dim_Count_Min (Item : Asset_Vector) return Natural is
      S : Natural := Natural'Last;
   begin
      for E : Asset of Item loop
         S := Natural'Min (S, Natural (E.Point.Length));
      end loop;
      return S;
   end;

--     function Evaluate (Item : in out Prominent; X : Asset_Vector) return Natural is
--        S : Natural := 0;
--     begin
--        for E : Asset of X loop
--           if Item.P (E.Class) > 0 then
--              Item.P (E.Class) := Item.P (E.Class) - 1;
--              S := S + 1;
--           end if;
--        end loop;
--        return S;
--     end;

--     procedure Evaluate (Item : in out Prominent_Vector; Sample : Asset_Vector; Correctness : out Natural_Vector) is
--        use Natural_Vectors;
--     begin
--        for E : Prominent of Item loop
--           Append (Correctness, Evaluate (E, Sample));
--        end loop;
--     end;

   function Unique_Class_Count (Item : Asset_Vector) return Natural is
      use Ada.Containers;
      use Class_Counter_Vectors;
      N : Class_Counter_Vector := To_Vector (0, Count_Type (Max_Class (Item)));
      R : Natural := 0;
   begin
      for E : Asset of Item loop
         N (E.Class) := N (E.Class) + 1;
      end loop;
      for E : Natural of N loop
         if E > 0 then
            R := R + 1;
         end if;
      end loop;
      return R;
   end;

















   procedure Calc_Distance (DB : Asset_Vector; Sample : Asset; Kind : Dev.Math.Distances.Kinds.Kind; W : Float_Vector; D : in out Distance_Info_Vector) is
      use Dev.Math;
      X : Distance_Info;
   begin
      for E : Asset of DB loop
         X.Time := E.Time;
         X.Class := E.Class;
         X.Dis := Distances.Selective (E.Point, Sample.Point, W, Kind);
         D.Append (X);
      end loop;
   end;

   procedure Calc_Prominent (D : Distance_Info_Vector; To : in out K_Class_Vector) is
      use Ada.Containers;
      use Class_Vectors;
      S : Class_Vector;
      M : Integer := -1;
      T : Natural := 0;
      N : constant Count_Type := 10;
   begin
      S := To_Vector (0, N);
      for E : Distance_Info of D loop
         S (E.Class) := S (E.Class) + 1;
         if M = S (E.Class) then
            T := 0;
         elsif M < S (E.Class) then
            M := S (E.Class);
            T := E.Class;
         end if;
         To.Append (T);
      end loop;
   end;


   function "<" (A, B : Distance_Info) return Boolean is (A.Dis < B.Dis);
   package Distance_Info_Vectors_Sorting is new Distance_Info_Vectors.Generic_Sorting ("<");

   procedure Sort (Container : in out Distance_Info_Vector) is
   begin
      Distance_Info_Vectors_Sorting.Sort (Container);
   end;

   procedure Summarize1 (Estimations : K_Class_Vector; To : in out Prominent_Vector) is
      procedure Add (C : in out Natural) is
      begin
         C := C + 1;
      end;
      procedure Add (P : in out Class_Vector; C : Natural) is
      begin
         Add (P (C));
      end;
      procedure Add (P : in out Prominent; C : Natural) is
      begin
         Add (P.P, C);
      end;
   begin
      for I in To.First_Index .. Natural'Min (To.Last_Index, Estimations.Last_Index) loop
         Add (To (I), Estimations (I));
      end loop;
   end;

--     procedure Summarize (Item : K_Class_Vector; To : in out Prominent_Vector) is
--     begin
--        for I in To.First_Index .. Natural'Min (Item.Last_Index, To.Last_Index) loop
--           To (I).P (Item (I)) := To (I).P (Item (I)) + 1;
--        end loop;
--     end;




end;
