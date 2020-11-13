IDENTIFICATION DIVISION.
PROGRAM-ID. antiquity.

DATA DIVISION.
  WORKING-STORAGE SECTION.
        01 WORD PIC X(20).
        01 WORD-LINE X(60).
        01 LONG-LINE X(60).
        01 SHORT-LINE X(60).
        01 I-CHAR X(12).
        01 INPUT-CHAR X(1).
        
        character(:), allocatable :: string
        character(:), allocatable :: line
        character(:), allocatable :: longLine
        character(:), allocatable :: shortLine
        character(len=12) :: i_char
        character(len=1) :: input
        character(len=20), dimension(850000)::array
        integer::i
        character(:), allocatable::newWord, charAt


