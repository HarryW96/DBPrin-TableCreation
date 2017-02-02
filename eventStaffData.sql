insert into eventStaff(eventID, staffID)
  values (1, 1);

  insert into  eventStaff (eventID, staffID)
    select eventID, staffID from eventStaff;
    select count(*) from eventStaff;

update eventStaff set eventID = floor(rand()*32000)+1;
update eventStaff set staffID = floor(rand()*128000)+1;

create table eventStaff2 like eventStaff;
  insert into eventStaff2 (eventID, StaffID) select eventID, StaffID from eventStaff;
  delete from eventStaff;
  insert into eventStaff select * from eventStaff2;
  drop table eventStaff2;
