create table product(
	pdnum number(10) not null,
	pdname 		varchar(20) not null,
	pdcategory varchar(20) not null,
	pdurl			varchar(50) null,
	pdimg		varchar(30) default 'pdimg.jpg',
	pdprice		number(10)		not null,
	pdbrand		varchar(10)	not null,
	pdcolor		varchar(10)	not null,
	primary key(pdnum)

) 
select * from PRODUCT;


insert into product(pdnum,pdname, pdcategory, pdurl, pdimg, pdprice, pdbrand,pdcolor)
values(
(select nvl(max(pdnum),0)+1 as pdnum from product),
'washed jean',
'jean',
'http://naver.com',
'pdimg.jpg',
'50',
'levis',
'blue'

);
select pdnum,pdname, pdcategory, pdurl, pdimg, pdprice, pdbrand,pdcolor, r 
from( 
	select pdnum,pdname, pdcategory, pdurl, pdimg, pdprice, pdbrand,pdcolor, rownum r 
from( 
	select pdnum,pdname, pdcategory, pdurl, pdimg, pdprice, pdbrand,pdcolor from product 
	where pdname like 'jean' or pdcategory  like 'jean' 
	order by pdprice desc 
 		) 
 	)where r>=1 and r<=6 
select * from PRODUCT

drop table product;