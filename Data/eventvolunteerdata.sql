insert into eventVolunteer(eventID, volunteerID)
  values (1, 1);

insert into  eventVolunteer (eventID, volunteerID)
  select eventID, volunteerID from eventVolunteer;
  select count(*) from eventVolunteer;

update eventVolunteer set eventID = floor(rand()*256000)+1;
update eventVolunteer set volunteerID = floor(rand()*512000)+1;

create table eventVolunteer2 like eventVolunteer;
  insert into eventVolunteer2 (eventID, volunteerID) select eventID, volunteerID from eventVolunteer;
  delete from eventVolunteer;
  insert into eventVolunteer select * from eventVolunteer2;
  drop table eventVolunteer2;
