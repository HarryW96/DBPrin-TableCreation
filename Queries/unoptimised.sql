--Unoptimised Query--
select 
event.eventID, 
event.eventName, 
event.eventDate, 
eventParticipent.participentID, 
eventParticipent.participationNum,
concat(participent.fName, " ", participent.lName) as participentName
from event use index()
straight_join eventParticipent use index() on event.eventID = eventParticipent.eventID
straight_join participent use index() on participent.participentID = eventParticipent.participentID
where eventParticipent.paid = 0
and event.eventName = "egestas metus aenean fermentum donec"
and event.eventID = 4238
order by eventParticipent.participentID desc;