FLUSH TABLES;

--Student Number: UP785080--

/*
DBPRIN this year has been an interesting unit allowing me to fully expand upon my knowledge learnt last year and apply it in a more 
practical way with a real world like scenario. From the start of the year I was not sure how I would feel about DBPRIN but quickly 
found the lecturers were upbeat and very positive when talking in the lectures, making them engaging and interesting. The same can be
said about practicals and seminars with lecturers being helpful and always willing to support and help with anything I needed.

Being able to extend knowledge from last year and apply it to my database I designed along with working with large amounts of data made
the unit engaging and entertaining whilst also allowing for a learning curve allowing us to show off the knowledge we were learning in 
the lectures weekly. I particularly enjoyed the practical building of the database and filling it with data with the new queries we
had learnt to help with this such as being able to duplicate data and randomise data when required.

Running and creating practical business queries was also interesting as it allowed me to not only practice with optimisation and other
techniques on my queries to make them run as quickly as possible but also to think about how they would be useful within the Schlepp-
adoo company when running and organising there large scale events for clients.

Although the unit as a whole went well there were some sections where I had issues with and did struggle to understand. I feel like 
relational algebra was a subject that was glanced over although never explained very well and was never covered completely. I found it 
extremely confusing and had issues understanding it and still feel now that I don’t quite understand the way it works.

As well as this I also had a few problems with some of the first sections of the coursework and felt that some of the specification was
not clear. I feel like this due to the fact that the ERD and design for the database was based on our opinion and felt like it was not 
marked like that ending in a lower mark. I felt like this occurred due to some of the earlier sections in the unit not being covered 
extensively. If I was to take the unit again I would enjoy having more detail gone into the early sections and the first term in 
general with more detail.

Overall I found DBPRIN an extremely interesting and enjoyable unit which easily allowed me to expand on my knowledge from INDADD last 
year as well as being able to learn about new techniques and parts of database development. This unit is also going to be invaluable 
when going into placement next year with BAE Systems where I will be working with large scale databases and managing the data within
them.
*/


/*
* Query 1
*
* Get information about an event and the people participating that haven't yet paid.
* 
* Used for chasing up payments or just seeing how many people 
* still need to pay for event entry, allowing the company to send things
* such as race numbers/participent numbers if the participent has indeed paid.
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
* Used to check number of staff or volunteers working the event allowing for 
* someone to check if more staff are needed as well as their status (such as first aid training) for an event. 
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