create table hotissue(
	
	keyword varchar(20) 	not null,
	sdate date					 not null,
	id 			varchar(10) 	default 'logout'	
)

select * from HOTISSUE;

insert into hotissue(keyword,sdate,id) 
values('fds',sysdate,'logout');

select count(keyword) from HOTISSUE where keyword='jean' and trunc(sdate) between trunc(sysdate)-1 and trunc(sysdate);

select keyword, cnt, r
from(
select keyword, cnt,rownum r
from(
select keyword , count(*) cnt
from (select * from hotissue where trunc(sdate) between trunc(sysdate)-3 and trunc(sysdate))
group by keyword
order by count(*) desc
)
)
where r>=1 and r<=4
;

drop table hotissue
