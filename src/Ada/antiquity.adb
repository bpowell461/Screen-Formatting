with Ada.IO_Exceptions;
use Ada.IO_Exceptions;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;

procedure antiquity is

	In_File : Ada.Text_IO.File_Type;
	value : Unbounded_String;
	string_array : array (1..80) of Unbounded_String;
	pos : Integer;
	word : Unbounded_String;
	
begin

	Ada.Text_IO.Open (File => In_File, Mode => Ada.Text_IO.In_File, Name => "test.txt");

	pos := 0;
	word := Null_Unbounded_String;
	while not Ada.Text_IO.End_Of_File(In_File) loop
		value:=To_Unbounded_String(Ada.Text_IO.Get_Line (File => In_File));
			
		Ada.Text_IO.Put_Line(Item => To_String(value));
		
		--if not Is_Digit(value) then
		--end if;
		 pos := pos + 1;
		 string_array(pos) := value;
	end loop;
	exception
		when Ada.IO_Exceptions.END_ERROR => Ada.Text_IO.Close (File => In_File);
-- Now put the contents of the entire array on the screen
	for i in 1..pos loop
		Ada.Text_IO.Put_Line("Line: ");	
		Ada.Text_IO.Put_Line(Item => To_String(string_array(i)));
	end loop;

	Ada.Text_IO.New_Line;
end antiquity;
