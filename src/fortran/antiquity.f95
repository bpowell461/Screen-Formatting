module myFuncs
implicit none

contains

subroutine buildLines(filesize)

    integer::wordCount, lineIndex, counter, filesize, wordIndex, charCount,longLineIndex, shortLineIndex, longCount, shortCount

        character(len=50)::cla
        character(:), allocatable :: string
        character(:), allocatable :: line
        character(:), allocatable :: longLine
        character(:), allocatable :: shortLine
        character(len=12) :: i_char
        character(len=1) :: input
        character(len=20), dimension(850000)::array
        integer::i
        counter = 1
        lineIndex= 1
        wordIndex = 1
        charCount = 60
        wordCount = 0
        longLineIndex=1
        shortLineIndex=1
        call get_command_argument(1, cla)

        open(unit=5, status="old",access="direct",form="unformatted",recl=1,file=cla)

        100 read (5, rec=counter, err=200) input
                 if(input==' ' .or. input == char(10)) then
                        array(wordIndex)=string       !reading in characters and appending to string to put into array
                        wordIndex=wordIndex+1
                        string=""
                 else

                        string = string//input   !appending to string
                 end if

                 counter = counter + 1

                 goto 100

         200 continue

        counter=counter-1

        close(5)  
        longLine="xxx"
        shortLine="xxx" !example strings
        longCount=0
        shortCount=100
        do i=1, wordIndex

                string = array(i)
                string = adjustl(trim(string))
                call checkWord(string)  !removing numbers from words

              if (isWord(string)) then
                wordCount=wordCount + 1
                if(LEN(string) > charCount) then

                  if(wordCount >= longCount) then
                        longLine = line
                        longLineIndex = lineIndex
                        longCount = wordCount
                  end if



                  if(wordCount <= shortCount) then
                        shortLine = line
                        shortLineIndex = lineIndex
                        shortCount = wordCount
                  end if

                        101 format(i8)
                        write(*,101, advance='no') lineIndex
                        print *, "  ",line
                        line =""

                        line = string
                        line = line // " "
                        
                        charCount = 60 - (LEN(line))  !60 Characters per Line

                        lineIndex = lineIndex +1
                        wordCount=0
                else
                        line = line//string
                        line = line//" "

                        charCount = 60 - (LEN(line))

                end if
            end if
        end do

                 if(wordCount <= shortCount) then
                        shortLine = line
                        shortLineIndex = lineIndex
                        shortCount = wordCount
                  end if


        write(*, 101, advance='no') lineIndex
        print*, "  ", line

        102 format(a7)
        103 format(i12) !Fortran format statements
        104 format(a12)

        
        write(i_char, 103) longLineIndex


        print*,"" 
        write(*, 102, advance='no') "LONG   "
        write(*, 104,  advance='no') adjustl(i_char)
        print *,longLine



        write(i_char, 103) shortLineIndex

        write(*, 102, advance='no') "SHORT  "
        write(*, 104, advance='no') adjustl(i_char)
        print*,shortLine

end subroutine buildLines



subroutine checkWord(word)
        character(:), allocatable::word, newWord, chara
        integer::i, n

        n = len(word)
        newWord=""
        do i=1, n
        chara = word(i:i)
         if(.not. isDigit(chara)) then
           newWord = newWord//chara
         end if
        end do
        
        word=newWord
end subroutine checkWord

logical function isDigit(char) result(bool)
  character(len=1):: char
  character(LEN=10):: digits
  integer::pos
  bool = .false.
  digits = "0123456789"
  pos = (scan(digits, char))
  if(pos/=0)then
    bool=.true.
  end if
  !return

end function isDigit


logical function isWord(word) result(bool)
  character(:), allocatable :: word
  integer:: pos
  bool = .false.
  if(isalpha(word)) then
      bool = .true.
      !return
    end if
  !return
end function isWord

logical function isalpha(char)result(bool)
character(:), allocatable::char
character(LEN=52)::alpha
integer::pos
bool = .false.
alpha = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" !Taken
pos = (scan(alpha,char))
!https://web.ics.purdue.edu/~aai/fortref/examples/f77/isalpha.txt
if(pos/=0)then
  bool=.true.
end if
!return
end function isalpha

end module myFuncs

program antiquity

use myFuncs
implicit none

integer::filesize

call buildLines(filesize)
end program antiquity