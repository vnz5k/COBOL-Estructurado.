       IDENTIFICATION DIVISION.
       PROGRAM-ID. LEE-SEC.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EMPLEADO ASSIGN TO 'C:\Users\pc\Desktop\S\secu'.
       DATA DIVISION.
       FILE SECTION.
       FD EMPLEADO.
       01 REG-EMPL.
           05 ID-EMPL PIC 9(02).
           05 NOM-EMPL PIC X(20).
           05 NOM-DEP  PIC X(10) VALUE SPACES.
           05 S-MEN    PIC 9(05) VALUE ZERO.
           05 F-ING    PIC 9(08) VALUE ZERO.

       WORKING-STORAGE SECTION.
       01 WS-FLAG PIC 9 VALUE 0.

       PROCEDURE DIVISION.
       001-INI.
           PERFORM 100-OPEN
           PERFORM 100-LEER UNTIL WS-FLAG = 1.
           PERFORM 100-CERRAR
           STOP RUN.

       100-OPEN.
           OPEN INPUT EMPLEADO.

      *Lee el archivo empleado, al final de la lectura mueve 1 a WS.
      *Se va repetir la secuencia hasta que termine de leerlos.
       100-LEER.
           READ EMPLEADO
           AT END MOVE 1 TO WS-FLAG.
           DISPLAY REG-EMPL.

       100-CERRAR.
           CLOSE EMPLEADO.
