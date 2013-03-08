CREATE OR REPLACE
TRIGGER ALEX.endungen_nr_trig
BEFORE INSERT
ON dateiendung FOR EACH ROW
DECLARE
   -- temporäre Variable
   tmpVar NUMBER;
BEGIN
   -- Wir selektieren aus der Sequenz und und addieren durch nextval +1
   -- Das Ganze wird in der Temporären Variable gespeichert.
   SELECT DOC_SEQ.NEXTVAL INTO tmpVar FROM dual;
   -- Schlussendlich sorgt der Trigger für jedes NEUE PID dafür, dass die
   -- Variable eingesetzt wird.
   :NEW.END_PK_NR := tmpVar;
END endungen_nr_trig;
