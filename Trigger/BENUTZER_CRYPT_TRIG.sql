create or replace trigger ALEX.benutzer_crypt_trig
BEFORE INSERT OR UPDATE
ON benutzer FOR EACH ROW


DECLARE
   -- temporäre Variable
   tmpVar VARCHAR2(100);
   
BEGIN
   tmpVar := dbms_obfuscation_toolkit.md5( input_string => :NEW.US_PASSWORD); 
   :NEW.US_PASSWORD := tmpVar;
END benutzer_crypt_trig;