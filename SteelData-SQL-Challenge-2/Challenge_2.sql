
--1. What are the names of the players whose salary is greater than 100,000?

  select player_name from Players
  where salary > 100000 ;
 

--2. What is the team name of the player with player_id = 3?
 
   select t.team_name from Teams t
   inner join
   Players p on t.team_id=p.team_id
   where player_id = 3 ;


--3. What is the total number of players in each team? 
 
   select t.team_name , count(p.player_name) as total_players from Teams t
   inner join
   Players p on t.team_id=p.team_id
   group by t.team_name ;
 

 --4. What is the team name and captain name of the team with team_id = 2?
 
   select t.team_name,p.player_name as captain_name from Teams t
   inner join
   Players p on t.team_id=p.team_id
   where t.team_id = 2  and t.captain_id=p.player_id ;
 
 
--5. What are the player names and their roles in the team with team_id = 1?
 
  select  p.player_name ,p.role  from Teams t
  inner join
  Players p on t.team_id=p.team_id
  where p.team_id=1;


--6. What are the team names and the number of matches they have won ?

 select team_name, count(*) total_matches_won
 from Teams t
 left join Matches m on t.team_id=m.winner_id
 group by team_name;


--7. What is the average salary of players in the teams with country 'USA'?

 select t.team_name , avg(p.salary) avg_salary from Teams t
 inner join 
 Players p on p.team_id=t.team_id
 where country = 'USA'
 group by t.team_name;


--8. Which team won the most matches?

 select top 1 team_name, count(winner_id) total_matches_won
 from teams
 inner join matches on teams.team_id=matches.winner_id
 group by team_name
 order by total_matches_won desc ;


--9. What are the team names and the number of players in each team whose salary is greater than 100,000?

 select t.team_name , count(*) as total_players from Teams t
 inner join
 Players p on p.team_id=t.team_id
 where salary > 100000
 group by t.team_name
 order by total_players desc ;


--10. What is the date and the score of the match with match_id = 3?

 select match_date,score_team1,score_team2 from Matches
 where match_id = 3