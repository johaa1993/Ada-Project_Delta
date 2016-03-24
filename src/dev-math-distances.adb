with Ada.Assertions;
with Ada.Numerics.Elementary_Functions;

package body Dev.Math.Distances is

   package body Kinds is
      function Value (Name : String) return Kind is
         use Ada.Assertions;
      begin
         if Name = "euclidean" then
            return Euclidean;
         elsif Name = "euclidean2" then
            return Euclidean2;
         elsif Name = "canberra" then
            return Canberra;
         elsif Name = "manhattan" then
            return Manhattan;
         else
            Assert (False, "Distance type unknown");
            return Unknown;
         end if;
      end;
   end;

   function Manhattan (A : Float_Vector; B : Float_Vector) return Distance is
      S : Float := 0.0;
   begin
      for I in A.First_Index .. A.Last_Index loop
         S := S + abs (A (I) - B (I));
      end loop;
      return Distance (S);
   end;

   function Canberra (A : Float_Vector; B : Float_Vector) return Distance is
      S : Float := 0.0;
   begin
      for I in A.First_Index .. A.Last_Index loop
         S := S + (if A (I) - B (I) = 0.0 then 0.0 else abs (A (I) - B (I)) / (abs A (I) + abs B (I)));
      end loop;
      return Distance (S);
   end;

   function Euclidean (A : Float_Vector; B : Float_Vector) return Distance is
      use Ada.Numerics.Elementary_Functions;
      S : Float := 0.0;
   begin
      for I in A.First_Index .. A.Last_Index loop
         S := S + Sqrt ((A (I) - B (I)) ** 2);
      end loop;
      return Distance (S);
   end;

   function Euclidean2 (A : Float_Vector; B : Float_Vector) return Distance is
      S : Float := 0.0;
   begin
      for I in A.First_Index .. A.Last_Index loop
         S := S + (A (I) - B (I)) ** 2;
      end loop;
      return Distance (S);
   end;


end;
