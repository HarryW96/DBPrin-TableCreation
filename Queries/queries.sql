--Useful things--

FLUSH TABLES;

select eventID, count(distinct participentID) count
from eventParticipent
where paid = 0
group by eventID
order by count desc
limit 1;


update *table* set *row* = floor(rand()**number*)+1;

/*
* Query 1
*
* Get information about an event and the people participating that haven't yet paid.
* 
* Used for chasing up payments or just seeing how many people 
* still need to pay for event entry
*/

select 
event.eventID, 
event.eventName, 
event.eventDate, 
eventParticipent.participentID, 
eventParticipent.participationNum,
concat(participent.fName, " ", participent.lName) as participentName
from event use index(primary)
straight_join eventParticipent use index() on event.eventID = eventParticipent.eventID
straight_join participent use index() on eventParticipent.participentID = participent.participentID
where eventParticipent.paid = 0
and event.eventID = 4238
order by eventParticipent.participentID desc;

/*
* Query 2
*
* Get information about an event and the staff and volunteers 
* that will be working including total number of volunteers and staff combined. 
* 
* Used to check if more staff or volunteers are needed as well as 
* their status (such as first aid training) for an event.
*/

select
event.eventID,
event.eventName,
event.eventDate,
count(eventVolunteer.volunteerID) as NoOfVolunteers,
count(eventStaff.staffID) as NoOfStaff,
concat(count(eventVolunteer.volunteerID) + count(eventStaff.staffID)) as totalWorkers,
count(volunteer.firstAid) as VolunteersWithFirstAid
from event
join eventVolunteer on event.eventID = eventVolunteer.eventID
join eventStaff on event.eventID = eventStaff.eventID
join volunteer on volunteer.volunteerID = eventVolunteer.volunteerID
where event.eventID = 17987;

/*
* Query 3
*
* List information about event route and the stations on route of event including type.
*
* Used to consider whether a race has enough types of stations for the event
* and whether they may have to introduce more of certain types depending on 
* data received back.
*/

select 
event.eventID,
event.eventName,
event.eventDate,
event.eventLength_Km,
station.type,
station.location_Km
from event
join station on event.eventID = station.eventID
where event.eventID = 675;

/*
* 
* Query 4
*
* Find client information including any events they may have and whether
* any money is still owed for those events.
*
* Used to chase up payments from a company for an event if they still
* owe money for the service provided.
*
*	## Kind of works, issues with data in database and not enough time
* ## rebuild from scratch including all data.
*/

select distinct
client.companyName,
concat(client.liaisonFName, " ", client.liaisonLName) as LiaisonName,
client.email as LiaisonEmail,
client.phoneNum as LiaisonPhoneNum,
event.eventID,
event.eventName,
event.eventDate,
invoice.moneyOwed,
invoice.dateDue
from client
join event on client.eventID = event.eventID
join invoice on client.clientID = invoice.clientID
where client.clientID = 1
order by invoice.dateDue desc;


/*
* 
* Query 5
*
* Find the total money taken by an event per year of events from a particular location.
*
* Useful for comparing data for the company and thinking of locations
* that are better to hold events at in the future to make the most profit.
*
* 
*/

select 
event.eventLocation,
count(event.eventID) as "numberOfEvents",
sum(event.eventCost) as "totalMoneyTaken(£)"
from event
where event.eventLocation = "Detroit"
and event.eventDate > 2016-01-01;

/*
* 
* Query 6
*
* Get an runners details and emergency contacts.
*
* In case of an emergency Schlepp-adoo staff as well as volunteers may need
* to quickly get information about a participent such as their emergency
*	contacts phone number.  
*
*
* Returns only the vital information based on eventID and ParticipentNum.
*
* Examples: 
* 
* 145 + 331769
* 28456 + 957448
* 42876 + 1414238
*/

select * from eventParticipent where eventID = 42876;

select
concat(participent.fName, " ", participent.lName) as participentName,
participent.age,
participent.emergencyContactNum as emergencyContact,
eventParticipent.participationNum as participentNumber
from participent
join eventParticipent on eventParticipent.participentID = participent.participentID
where eventParticipent.eventID = 42876
and eventParticipent.participationNum = 1414238;

/*
* 
* Query 7
*
* An idea.
*
* 
*/