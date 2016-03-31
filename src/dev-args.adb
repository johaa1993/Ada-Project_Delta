with Ada.Command_Line;

package body Dev.Args is

   function Find_Argument (F : String) return Natural is
      use Ada.Command_Line;
      P : Natural := 0;
   begin
      loop
         if P = Argument_Count then
            return 0;
         end if;
         P := P + 1;
         if Argument (P)'Length = F'Length and then Argument (P) (1 .. F'Length) = F then
            return P;
         end if;
      end loop;
   end;


   function Get (P : in out Positive; To : out Float) return Boolean is
      use Ada.Command_Line;
   begin
      To := Float'Value (Argument (P));
      P := P + 1;
      return True;
   exception
      when others => return False;
   end;


   function Get_Argument_Value (P : Positive) return String is
      use Ada.Command_Line;
   begin
      if Argument (P) (1) = '-' then
         return "";
      else
         return Argument (P);
      end if;
   end;
end;
