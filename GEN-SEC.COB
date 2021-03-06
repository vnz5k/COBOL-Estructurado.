      *Archivo SECUENCIAL
      *condicionando departamentos.
      *codicionando sueldo.
      *condicionando fecha.
      *Condicionando cierre.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. GENSEC.
      *Se registra el nombre del archivo y fisico en la ED.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT EMPLEADO ASSIGN TO 'C:\Users\pc\Desktop\S\secu'.
      *Se declara el nombre del archivo junto con su segmento.
       DATA DIVISION.
       FILE SECTION.
       FD EMPLEADO.
       01 REG-EMPL.
           05 ID-EMPL PIC 9(02).
           05 NOM-EMPL PIC X(20).
           05 NOM-DEP  PIC X(10) VALUE SPACES.
           05 S-MEN    PIC 9(05) VALUE ZERO.
           05 F-ING    PIC 9(08) VALUE ZERO.

      *Se declaran Switches si es requerido segun el archivo.
       WORKING-STORAGE SECTION.
       01 WS-FLAG PIC 9.
       01 WS-FLAG1 PIC X VALUE 'Y'.
       01 WS-RES PIC X.
      *Se  declaran las actividades del programa.
       PROCEDURE DIVISION.
       001-IN.
           PERFORM 100-CREAR.
           PERFORM 200-PROCESO THRU 300-FECHA  UNTIL WS-FLAG = 1.
           PERFORM 100-CERRAR.

       STOP RUN.
      *Se asignan segmentos a asignar.
       100-CREAR.
           OPEN OUTPUT EMPLEADO.
           DISPLAY 'CREACION DE ARCHIVO'.
       100-CERRAR.
           CLOSE EMPLEADO
           DISPLAY  'ARCHIVO CERRADO'.

       200-PROCESO.
           DISPLAY 'ID'         ACCEPT ID-EMPL.
           DISPLAY 'NAME '      ACCEPT NOM-EMPL.
      *Codiciona opciones para asignar campo nom dep
      *Si este no es coherente a las ocpiones regresa.
       201-NOMDEP.
           DISPLAY '1 LIMPIEZA | 2 COBRANZA | 3 SISTEMAS'.
           DISPLAY 'SELECCIONA DEPARTAMENTO' ACCEPT NOM-DEP.
               EVALUATE TRUE
               WHEN NOM-DEP = 1 MOVE 'LIMPIEZA' TO NOM-DEP
               DISPLAY 'SELECCIONASTE ' NOM-DEP
               WHEN NOM-DEP = 2 MOVE 'COBRANZA' TO NOM-DEP
               DISPLAY 'SELECCIONASTE ' NOM-DEP
               WHEN NOM-DEP = 3 MOVE 'SISTEMAS' TO NOM-DEP
               DISPLAY 'SELECCIONASTE ' NOM-DEP
               WHEN OTHER  DISPLAY 'INVALID OPTION'
               PERFORM 201-NOMDEP.
      *Condiciona opciones para asignar salarios.
       203-SUELDO.
           DISPLAY '1 ( 20,000 ) | 2 ( 30,000 ) | 3 ( 40,0000 )'.
           DISPLAY 'S-MEN'      ACCEPT S-MEN.
               EVALUATE TRUE
               WHEN S-MEN = 1 MOVE 20000 TO S-MEN
               DISPLAY 'SELECCIONASTE ' S-MEN
               WHEN S-MEN = 2 MOVE 30000 TO S-MEN
               DISPLAY 'SELECCIONASTE ' S-MEN
               WHEN S-MEN = 3 MOVE 40000 TO S-MEN
               DISPLAY 'SELECCIONASTE ' S-MEN.
      *Condiciona fecha con  esquema mayor a 2019.
      *Si no es valido regresa, si es valido pregunta para sw.
       300-FECHA.
           DISPLAY 'F-ING'      ACCEPT F-ING.
               EVALUATE TRUE
               WHEN F-ING LESS 20190101 DISPLAY 'INVALID FECHA'
               PERFORM 300-FECHA
               WHEN F-ING GREATER 20190101 DISPLAY 'FECHA VALIDA!'
      *Escribe los datos y posteriormente pregunta por algun otro.
               WRITE REG-EMPL DISPLAY 'ARCHIVO ESCRITO'.

               DISPLAY 'INGRESAR OTRO REGISTRO? S/N '.
               ACCEPT WS-FLAG1.
               IF WS-FLAG1 = 'N'
                   MOVE 1 TO WS-FLAG.
