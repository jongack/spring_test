create table subscriber(
	id				varchar(10)		not 	null,
	passwd		varchar(20)		not 	null,
	mname		varchar(20)		not 	null,
	tel				varchar(14)				null,
	email			varchar(50)		not 	null unique,
	zipcode		varchar(7)					null,
	address1	varchar(150)				null,
	address2	varchar(50)				null,
	mdate		date					not 	null,
	fname		varchar(50)		default	'member.jpg',
	grade			char(1)				default	'h',
	primary	key (id)

)

--alter
alter table subscriber 
add(gender	varchar(10) default null);
alter table subscriber 
add(age 	varchar(10) default null);


--update
update subscriber set address2='남동구' where id='admin'

--list
 select id,mname,tel,email,zipcode,address1,address2,mdate,fname,r 
	from( 
	 		select id,mname,tel,email,zipcode,address1,address2,mdate,fname,rownum r 
			from( 
				select id,mname,tel,email,zipcode,address1,address2,mdate,fname 
	 				from subscriber 
		
					 where mname like '%자%' 
	
	 				order by mdate 
						) 
				) 
		 where r>=1 and r<=5
		 
		 where mname like '%자%' 

select * from SUBSCRIBER;
select count(*) cnt from subscriber where id='admin'
select count(*) cnt from subscriber where email='admi@email.com'

insert into subscriber(id,passwd,mname,tel,email,zipcode,address1
								,address2,mdate,fname)
values('ad3','1234','자장면','010-111-1111','aamin3@email.com','11111','서울시','관철동'
			,sysdate,'member.jpg');
--list
select id,mname,tel,email,zipcode,address1,address2,mdate,fname,r
from(
		select id,mname,tel,email,zipcode,address1,address2,mdate,fname,rownum r
		from(
				select id,mname,tel,email,zipcode,address1,address2,mdate,fname
				from subscriber
				where mname like '자%'
				order by mdate
				)
		)
where r>=1 and r<=1
--read
select * 
from subscriber 
where id='ad';
		

update SUBSCRIBER
set passwd='', tel='010-222-2222',zipcode='12345', address1='인천시',
		address2='부평구',fname='d.jpg'
where id='admin';

delete subscriber where id='ad';
