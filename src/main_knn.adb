with Ada.Text_IO;
with Ada.Assertions;
with CBR;
with CBR.Texts;
with CBR.Readings;
with Dev.Math;
with Dev.Args;
with Dev.Math.Distances;

procedure Main_KNN is

   use Dev.Args;
   use CBR;
   use CBR.Texts;
   use CBR.Readings;
   use Ada.Text_IO;
   use Ada.Assertions;

   X : Asset_Vector;
   S : Asset_Vector;
   D : Distance_Info_Vector;
   J : Natural;
   DT : Dev.Math.Distances.Kinds.Kind;
   W : Float_Vector;
   W0 : Float;
   K : K_Class_Vector;
   P : Prominent_Vector;
   KN : Natural;

begin

   Put_Line ("==========K nearest neighbor (KNN)==========");

   J := Find_Argument_Asserted ("-db", "Missing database -db flag");
   Read_Class (X, Get_Argument_Value (J + 1));

   J := Find_Argument_Asserted ("-d", "Missing distance type -d flag");
   DT := Dev.Math.Distances.Kinds.Value (Get_Argument_Value (J + 1));

   J := Find_Argument_Asserted ("-s", "Missing sample file -s flag");
   Read_Class (S, Get_Argument_Value (J + 1));

   J := Find_Argument_Asserted ("-w", "Missing weight -w flag") + 1;
   while Get (J, W0) loop
      W.Append (W0);
   end loop;

   Assert (Dim_Count_Min (X) = Natural (W.Length), "Number of weights is not equal number of dimension.");

   J := Find_Argument_Asserted ("-k", "Missing k count -k flag");
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
