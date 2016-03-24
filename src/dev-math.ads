with Ada.Containers.Vectors;

package Dev.Math is

   procedure Dummy;

   subtype Distance is Float;
   package Vectors is new Ada.Containers.Vectors (Natural, Float);
   use Vectors;

   procedure Find_Min_Max (X : Vector; Min : in out Vector; Max : in out Vector);
   procedure Normalize (X : in out Vector; Min : in out Vector; Max : in out Vector);

end;
