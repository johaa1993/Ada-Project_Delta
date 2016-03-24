with Ada.Containers.Vectors;

package Dev.Math.Distances is

   package Kinds is
      type Kind is (Unknown, Canberra, Euclidean, Euclidean2, Manhattan);
      function Value (Name : String) return Kind;
   end;

   function Manhattan (A : Float_Vector; B : Float_Vector) return Distance;
   function Canberra (A : Float_Vector; B : Float_Vector) return Distance;
   function Euclidean (A : Float_Vector; B : Float_Vector) return Distance;
   function Euclidean2 (A : Float_Vector; B : Float_Vector) return Distance;

end;
