package body CBR is

   function Calc_Distance (X : Float_Vectors.Vector; Y : Float_Vectors.Vector) return Float is
      S : Float := 0.0;
   begin
      for I in X.First_Index .. X.Last_Index loop
         S := S + abs (X (I) - Y (I));
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

   procedure Put (X : Float_Vectors.Vector; Fore : Field; Aft : Field) is
   begin
      for E : Float of X loop
         Put (E, Fore, Aft);
      end loop;
   end;

   procedure Put (F : File_Type; X : Float_Vectors.Vector) is
   begin
      for E : Float of X loop
         Put (F, E);
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

   procedure Calc_Distance (X : in out Asset_Vectors.Vector; Y : Asset) is
   begin
      for E : Asset of X loop
         Float_Vectors.Append (E.Dis, Calc_Distance (E.Point, Y.Point));
      end loop;
   end;

   procedure Calc_Distance (X : in out Asset_Vectors.Vector; Y : Asset_Vectors.Vector) is
   begin
      for E : Asset of Y loop
         Calc_Distance (X, E);
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

end;
