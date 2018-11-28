create table qna(
	qnano		number(7)		not null,
	wname		varchar(20)			not null,
	title			varchar(100)			not null,
	content		varchar(4000)		not null,
	passwd		varchar(15)			not null,
	viewcnt		number(5)				default 0,
	wdate		date						not null,
	grpno			number(7)				default 0, -- 부모글이랑 같은 그룹넘버
	indent		number(2)				default 0, -- 답변여부, 들여쓰기 깊이, 댓글에만 부여
	ansnum		number(5)				default 0, -- 새로운 답변들 순서번호
	primary key (qnano)
	
);

--부모글 삭제 금지용 컬럼
alter table qna
add(refnum number default 0);

alter table qna
add(filename varchar(30),
		filesize number default 0);

--create
insert into qna(qnano,wname,title,content,passwd,wdate,grpno)
values(
(select nvl(max(qnano),0)+1 as qnano from qna),
'왕눈이','ㅋㅋ','내용','123',sysdate,
(select nvl(max(grpno),0)+1 as grpno from qna)
);

insert into qna(qnano,wname,title,content,passwd,wdate,grpno)
values(
(select nvl(max(qnano),0)+1 as qnano from qna),
'왕눈이','ㅋㅋ','내용','123',sysdate-5,
(select nvl(max(grpno),0)+1 as grpno from qna)
);

--list
select qnano, wname, title, content, passwd, viewcnt, 
					wdate, grpno, indent, ansnum, r
from(
	select qnano, wname, title, content, passwd, viewcnt, 
					wdate, grpno, indent, ansnum, rownum as r
	from(
		select qnano, wname, title, content, passwd, viewcnt, 
					to_char(wdate,'yyyy-mm-dd') as wdate, grpno, indent, ansnum
		from qna
		order by qnano desc, ansnum
	)
)where wname like '%왕눈이%' or title like '%왕눈이%';
--조회수 증가
update qna
set viewcnt=viewcnt+1	
where qnano=1;

--update
update qna
set wname='왕눈이',title='비오는날', content='개구리연못'
where qnano =1;

--패스워드 검사
select count(qnano)as cnt
from qna
where qnano=1 and passwd='123';

--delete
delete from qna;

delete from qna where qnano = 1;

--select
insert into qna(qnano, wname, title, content, passwd, wdate,grpno)
values ((select nvl(max(qnano),0)as qnano from qna), 
			'왕눈이','부모글3','내용','123',sysdate,
			(select nvl(max(grpno),0)+1 as grpno from qna)
			
);
select qnano, title, grpno, indent, ansnum

select * from qna;

delete  from qna;
select count(*) form qna
select qnano, grpno , indent, ansnum,refnum
from qna
order by grpno desc, ansnum;