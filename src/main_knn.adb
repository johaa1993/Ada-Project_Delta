with Ada.Text_IO;
with Ada.Assertions;
with CBR;
with CBR.Texts;
with CBR.Readings;
with CBR.Writings;
with Dev.Math;
with Dev.Args;
with Dev.Math.Distances;
with Ada.Containers;

procedure Main_KNN is

   use Dev.Math;
   use Dev.Args;
   use CBR;
   use CBR.Texts;
   use CBR.Readings;
   use CBR.Writings;
   use Ada.Text_IO;
   use Ada.Assertions;
   use Ada.Containers;

   X : Asset_Vector;
   S : Asset_Vector;
   D : Distance_Info_Vector;
   J : Natural;
   DT : Distances.Kinds.Kind;
   W : Float_Vector;
   W0 : Float;
   K : K_Class_Vector;
   P : Prominent_Vector;
   KN : Natural;

begin

   Put_Line ("K nearest neighbor (KNN)");
   New_Line;

   J := Find_Argument ("-db");
   Assert (J > 0, "Missing class file -c flag");
   Read_Class (X, Get_Argument_Value (J + 1));

   J := Find_Argument ("-d");
   Assert (J > 0, "Missing distance type -d flag");
   DT := Distances.Kinds.Value (Get_Argument_Value (J + 1));

   J := Find_Argument ("-s");
   Assert (J > 0, "Missing sample file -s flag");
   Read_Class (S, Get_Argument_Value (J + 1));

   J := Find_Argument ("-w") + 1;
   Assert (J > 0, "Missing weight -w flag");
   while Get (J, W0) loop
      W.Append (W0);
   end loop;

   Assert (Dim_Count_Min (X) = Natural (W.Length), "Number of weights is not equal number of dimension.");

   J := Find_Argument ("-k");
   Assert (J > 0, "Missing k count -k flag");
   KN := Natural'Value (Get_Argument_Value (J + 1));

   Initialize (P, Max_Class (X) + 1, KN);

   for E of S loop
      D.Set_Length (0);
      K.Set_Length (0);
      Calc_Distance (X, E, DT, W, D);
      Sort (D);
      Calc_Prominent (D, K);
      Summarize1 (K, P);
   end loop;

   Put (P);


   null;
end;
