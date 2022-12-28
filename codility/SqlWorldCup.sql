
with
host_win as (
    select host_team as team_id,
    sum(
        case
            when host_goals > guest_goals then 3
            when host_goals = guest_goals then 1
            else 0
        end
    ) as num_points
    from matches
    group by host_team
),
guest_win as (
    select guest_team as team_id,
    sum(
        case
            when host_goals < guest_goals then 3
            when host_goals = guest_goals then 1
            else 0
        end
    ) as num_points
    from matches
    group by guest_team
),
both as (
    select * from host_win
    UNION all
    select * from guest_win
)
select t.team_id, t.team_name, COALESCE(sum(num_points), 0) as num_points
from teams t left join both a
on t.team_id = a.team_id
group by t.team_id, t.team_name
order by num_points desc;