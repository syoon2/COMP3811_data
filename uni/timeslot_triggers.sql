/* Abort INSERT on section table if time_slot_id
   does not exist in the time_slot table */


/* 1. function that returns a trigger */
create or replace function timeslot_check1() returns trigger as
$sep$
begin
  if NEW.time_slot_id not in (select time_slot_id from time_slot) then
    /* Can either return null or raise an exception */
    /* raise exception 'invalid time slot'; */
    return null;
  end if;
  return NEW;
end;
$sep$
language plpgsql;

/* 2. Specify trigger event and action */
drop trigger if exists timeslot_check1 on section;
create trigger timeslot_check1 before insert on section
  for each row execute function timeslot_check1();


/* Handle DELETE on timeslot table */

/* 1. function that returns a trigger */
create or replace function timeslot_check2() returns trigger as
$sep$
begin
  /* If we are trying to delete a time_slot_id and 
     it is referenced in a row in section */
  if OLD.time_slot_id not in (select time_slot_id from time_slot) and
       OLD.time_slot_id in (select time_slot_id from section) then
    raise exception 'timeslot_id still in use';
  end if;
end;
$sep$
language plpgsql;

/* 2. Specify trigger event and action */
drop trigger if exists timeslot_check2 on time_slot;
create trigger timeslot_check2 after delete on time_slot
  for each row execute function timeslot_check2();
