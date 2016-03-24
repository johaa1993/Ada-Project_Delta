with Ada.Containers.Vectors;

package Dev.Math.Distances is

   package Kinds is
      type Kind is (Unknown, Canberra, Euclidean, Euclidean2, Manhattan);
      function Value (Name : String) return Kind;
   end;

   function Manhattan (A : Vector; B : Vector) return Distance;
   function Canberra (A : Vector; B : Vector) return Distance;
   function Euclidean (A : Vector; B : Vector) return Distance;
   function Euclidean2 (A : Vector; B : Vector) return Distance;

end;
