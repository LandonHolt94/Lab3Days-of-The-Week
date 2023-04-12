        .ORIG x3000

RESTART LEA R0, PROMPT   ; Load the address of the string "Please enter a number from 0-6:" into R0
        PUTS                    ; Output the string to the console
        GETC                    ; Read a single character from the keyboard and store it in R0
        ADD R3, R0, X0          ; Copy the value in R0 to R3
        ADD R3, R3, #-16        ; Subtract 16 from the value in R3
        ADD R3, R3, #-16        ; Subtract 16 from the value in R3 again
        ADD R3, R3, #-16        ; Subtract 16 from the value in R3 again
        ADD R4, R3, #-6         ; Copy the value in R3 to R4 and subtract 6 from it
        BRp ERROR               ; Branch to ERROR if the value in R4 is positive

        LEA R0, DAYS            ; Load the address of the string "Sunday" into R0
        ADD R3, R3, X0          ; Copy the value in R3 to R3 (this clears the upper 5 bits of R3)
                        ; R3 now contains the index of the day of the week (0-6)

LOOP    BRz DISPLAY        ; If the value in R3 is zero, branch to DISPLAY
        ADD R0, R0, #10         ; Add 10 to the value in R0 (which points to the current day of the week string)
        ADD R3, R3, #-1         ; Subtract 1 from the value in R3 (to move to the next day of the week)
        BR LOOP                 ; Branch back to LOOP to print the next day of the week string

DISPLAY PUTS            ; Output the current day of the week string to the console
        LEA R0, LF              ; Load the ASCII code for a line feed character into R0
        PUTS                    ; Output the line feed character to the console
        BR RESTART              ; Branch back to RESTART to start over

ERROR   LEA R0, ERMS    ; Load the address of the string "INVALID INPUT" into R0
        PUTS            ; Output the string to the console
        HALT            ; Stop execution of the program

PROMPT .STRINGZ "Please enter a number from 0-6: "
DAYS   .STRINGZ "Sunday   "
       .STRINGZ "Monday   "
       .STRINGZ "Tuesday  "
       .STRINGZ "Wendsday "
       .STRINGZ "Thursday "
       .STRINGZ "Friday   "
       .STRINGZ "Saturday "
ERMS   .STRINGZ "INVALID INPUT"
LF     .FILL X000A       ; The ASCII code for a line feed character
       .END
