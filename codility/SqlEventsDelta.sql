select b.event_type, (a.value - b.value) as value
from
(
    select * from events e1, (
        select event_type, max(time) as time from events
        group by event_type
        having count(event_type) > 1
    ) e2
    where e1.event_type = e2.event_type
    and e1.time = e2.time
) a,
(
    select * from events e1, (
        select e1.event_type, max(e1.time) as time from events e1, 
        (
            select event_type, max(time) as time from events
            group by event_type
            having count(event_type) > 1
        ) e2
        where e1.event_type = e2.event_type
        and e1.time < e2.time
        group by e1.event_type
    ) e2
    where e1.event_type = e2.event_type
    and e1.time = e2.time
) b
where a.event_type = b.event_type;
