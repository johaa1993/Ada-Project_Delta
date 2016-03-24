package body Dev.Math is

   procedure Dummy is null;

   function Normalize (Value : Float; Min, Max : Float) return Float is
   begin
      return (Value - Min) / (Max - Min);
   end;

   procedure Normalize (X : in out Vector; Min : in out Vector; Max : in out Vector) is
   begin
      for I in X.First_Index .. X.Last_Index loop
         X (I) := Normalize (X (I), Min (I), Max (I));
      end loop;
   end;

   procedure Find_Min_Max (X : Vector; Min : in out Vector; Max : in out Vector) is
   begin
      for I in X.First_Index .. X.Last_Index loop
         Min (I) := Float'Min (X (I), Min (I));
         Max (I) := Float'Max (X (I), Max (I));
      end loop;
   end;



end;