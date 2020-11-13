with Ada.IO_Exceptions;
use Ada.IO_Exceptions;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Ada.Integer_Text_IO;           
use Ada.Integer_Text_IO;
procedure antiquity is

	In_File : Ada.Text_IO.File_Type;
	value : Character;
	string_array : array (1..5000000) of Character;
	pos : Integer;
	word : Unbounded_String;
	line : Unbounded_String;
	lineIndex : Integer;
	charCount : Integer;
	wordLength: Integer;
	lineCount : Integer;
	longLine : Unbounded_String;
	shortLine : Unbounded_String;
	longLineIndex : Integer;
	shortLineIndex : Integer;
        longLineCount : Integer;
	shortLineCount: Integer;

	index : Integer;
begin
	lineIndex:=1;
	word := To_Unbounded_String("");
	line := To_Unbounded_String("");
	charCount := 60;
	wordLength := 0;
	lineCount := 0;
	longLineCount := 0;
	shortLineCount := 100;
	index:= 0;
	Ada.Text_IO.Open (File => In_File, Mode => Ada.Text_IO.In_File, Name => "/pub/pounds/CSC330/translations/KJV.txt");

	pos := 0;
	while not Ada.Text_IO.End_Of_File(In_File) loop
		Ada.Text_IO.Get (File => In_File, Item => value);

	if not (value = '0' or value = '1' or value = '2' or value = '3' or value = '4' or value = '5' or value = '6' or value = '7' or value = '8' or value='9') then
		 pos := pos + 1;
		 --Ada.Text_IO.Put (Item => value);
		 string_array(pos) := value;
	end if;
	end loop;
	exception
		when Ada.IO_Exceptions.END_ERROR => Ada.Text_IO.Close (File => In_File);
-- Now put the contents of the entire array on the screen

	for i in 1..pos loop

	value:=string_array(i);

	if not (value = ' ') then
        	Append(word, value);
		wordLength:=wordLength+1;
         else
		Append(word, " ");
		wordLength:=wordLength+1;
		if(wordLength > charCount) then
		   if (lineCount >= longLineCount) then
			longLine := line;
			longLineIndex := lineIndex;
			longLineCount := lineCount;
		   end if;

		   if (lineCount <= shortLineCount) then
			shortLine := line;
                        shortLineIndex := lineIndex;
                        shortLineCount := lineCount;
		   end if;	



		   Ada.Text_IO.New_Line;
	           Ada.Text_IO.Set_Col(3); 
		   Ada.Text_IO.Put(Item => Integer'Image(lineIndex));
	           Ada.Text_IO.Put("  ");
		   Ada.Text_IO.Put_Line(Item => To_String(line));




		   charCount := 60;
		   line := To_Unbounded_String("");
		   Append(line, word);
		   charCount := charCount - wordLength;
		   lineIndex := lineIndex+1;
		   word := To_Unbounded_String("");
		   lineCount := 0;
	           wordLength:=0;
		else	
		Append(line, word);
		lineCount := lineCount + 1 ;
		charCount := charCount - wordLength;
       	 	word := To_Unbounded_String("");
		wordLength := 0;
		end if;
        end if;
     end loop;

		   Ada.Text_IO.New_Line;
		   Ada.Text_IO.Set_Col(3);
                   Ada.Text_IO.Put(Item => Integer'Image(lineIndex));
                   Ada.Text_IO.Put("  ");
                   Ada.Text_IO.Put_Line(Item => To_String(line));

		Ada.Text_IO.New_Line;
		Ada.Text_IO.Put("LONG  ");
		Ada.Text_IO.Put(Integer'Image(longLineIndex));
                Ada.Text_IO.Put("          ");
                Ada.Text_IO.Put_Line(Item => To_String(longLine));
		
		Ada.Text_IO.Put("SHORT ");
                Ada.Text_IO.Put(Item => Integer'Image(shortLineIndex));
                Ada.Text_IO.Put("          ");
                Ada.Text_IO.Put_Line(Item => To_String(shortLine));





end antiquity;

