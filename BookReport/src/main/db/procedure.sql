--게시물 등록
CREATE OR ALTER PROCEDURE BOOKWRITE(
@bookName varchar(30),
@author   varchar(30),
@publisher varchar(20),
@bookDate  date,
@bookSort  varchar(20),
@bookImage varchar(30),
@title     varchar(50),
@mem_num    int,
@bookGrade int,
@cont      varchar(4000)
)
AS
DECLARE @bookCnt  INT;
DECLARE @bookNum  INT;
--조건에 일치하는 도서가 있는지 검색
select @bookCnt = count(*) 
from book
WHERE book_title = @bookName
AND book_author = @author;



IF(@bookCnt = 1 ) --등록 도서와 기존 도서가 일치할 경우
BEGIN 
SELECT @bookNum = book_num from book 
WHERE book_title = @bookName
AND book_author = @author;

--출판사, 출간일, 분류가 비어있지 않다면 수정
IF(@publisher != '')
BEGIN
UPDATE BOOK
SET publisher = @publisher
WHERE book_num = @bookNum;
END

IF(@bookDate != '')
BEGIN
UPDATE BOOK
SET book_date = @bookDate
WHERE book_num = @bookNum;
END


IF(@bookSort != '')
BEGIN
UPDATE BOOK
SET book_sort = @bookSort
WHERE book_num = @bookNum;
END

IF(@bookImage !='')
BEGIN
UPDATE BOOK
SET book_image = @bookImage
WHERE book_num = @bookNum;
END

END
ELSE   --등록 도서와 일치하는 기존 도서가 없을 경우
BEGIN
INSERT INTO BOOK(book_title,book_author,book_sort,book_date,publisher,book_image)
VALUES (@bookName, @author, @bookSort, @bookDate, @publisher, @bookImage   );


SELECT @bookNum = book_num from book
WHERE book_title = @bookName
AND book_author = @author;

END


--게시글 저장
INSERT INTO board(board_title, board_writer_num, board_cont, book_num, book_grade)
VALUES ( @title, @mem_num, @cont, @bookNum, @bookGrade  ); 


GO


------------------------------------------------------------
--게시물 열람
create or alter procedure boardView(
  @IN_BNO int,
  @CHECK int
)
AS
  
  IF(@CHECK = 1 )
  BEGIN
  UPDATE board
  SET readcount = readcount +1
  WHERE board_num = @IN_BNO;
  END

  SELECT board_num, board_title, nickname board_writer, board_cont, book_grade, regdate, readcount,
            book_title, book_author, book_sort, book_date, publisher, book_image
	,(select count(*) from like_board where board_num = board.board_num) likecount, (select count(*) from reply where reply.board_num=board.board_num) replycount
  FROM board JOIN book ON board.book_num = book.book_num
  JOIN member ON board.board_writer_num = member.mem_num
  WHERE board_num = @IN_BNO;

  
GO

----------------------------------------------------------------
--좋아요 증감
CREATE OR ALTER PROCEDURE BOARDLIKE(
@board_num int,
@mem_num  int,
@cnt int out
)
AS
declare @like int;
 select @like = count(*) from like_board
 where board_num = @board_num
 and   like_mem_num = @mem_num;
 
 if(@like = 0)
 begin
 insert into like_board(like_mem_num, board_num) values (@mem_num, @board_num);
 
 end
 else
 begin
 delete from like_board
 where board_num = @board_num
 and like_mem_num = @mem_num;
 end

 select @cnt = count(*) from like_board
 where board_num = @board_num;

GO
-------------------------------------------------------------------------------
--게시물 수정
CREATE OR ALTER PROCEDURE BOOKUPDATE(
@board_num int,
@bookName varchar(30),
@author   varchar(30),
@publisher varchar(20),
@bookDate  date,
@bookSort  varchar(20),
@bookImage varchar(30),
@title     varchar(50),
@bookGrade int,
@cont      varchar(4000)
)
AS
DECLARE @bookCnt  INT;
DECLARE @bookNum  INT;
--조건에 일치하는 도서가 있는지 검색
select @bookCnt = count(*) 
from book
WHERE book_title = @bookName
AND book_author = @author;



IF(@bookCnt = 1 ) --등록 도서와 기존 도서가 일치할 경우
BEGIN 
SELECT @bookNum = book_num from book 
WHERE book_title = @bookName
AND book_author = @author;

--출판사, 출간일, 분류가 비어있지 않다면 수정
IF(@publisher != '')
BEGIN
UPDATE BOOK
SET publisher = @publisher
WHERE book_num = @bookNum;
END

IF(@bookDate != '')
BEGIN
UPDATE BOOK
SET book_date = @bookDate
WHERE book_num = @bookNum;
END


IF(@bookSort != '')
BEGIN
UPDATE BOOK
SET book_sort = @bookSort
WHERE book_num = @bookNum;
END

IF(@bookImage !='')
BEGIN
UPDATE BOOK
SET book_image = @bookImage
WHERE book_num = @bookNum;
END

END
ELSE   --등록 도서와 일치하는 기존 도서가 없을 경우
BEGIN
INSERT INTO BOOK(book_title,book_author,book_sort,book_date,publisher,book_image)
VALUES (@bookName, @author, @bookSort, @bookDate, @publisher, @bookImage   );


SELECT @bookNum = book_num from book
WHERE book_title = @bookName
AND book_author = @author;

END


--게시글 수정
UPDATE board
SET board_title = @title,
board_cont = @cont,
book_num = @bookNum,
book_grade = @bookGrade
where board_num = @board_num
GO

------------------------------------------------
--댓글 작성
CREATE OR ALTER PROCEDURE REPLYWRITE(
@board_num    int,
@reply_num    int,
@mem_num int,
@reply_cont   varchar(600)
)
AS
declare @step int;
declare @lvl  int;
declare @rnum int;

--새 댓글일 경우
IF(@reply_num =  0)
BEGIN
select @rnum = isnull(max(rnum),1)+1 from reply where board_num = @board_num;
set @lvl = 1;
set @step = 1; 
END
--대댓글일 경우
ELSE
BEGIN
select @rnum = rnum, @step = step+1,@lvl =  lvl+1
from reply
where reply_num = @reply_num
and board_num = @board_num
--기존 글 순서 변경
update reply
set step = step + 1
where rnum=@rnum
and   step > @step - 1
and   board_num = @board_num
END

insert into reply(reply_mem, reply_cont, rnum, lvl, step, board_num)
values (@mem_num, @reply_cont, @rnum, @lvl, @step, @board_num);

GO
-------------------------------------------------------------------
--댓글 삭제
CREATE OR ALTER PROCEDURE REPLYDELETE(
@reply_num int 
)
AS
 declare @step int;
 declare @rnum int;
 declare @board_num int;
 declare @lvl int;

 select @step = step , @rnum = rnum, @board_num = board_num, @lvl = lvl from reply
 where reply_num = @reply_num;

 
declare @step2 int;


 delete from reply
 where reply_num = @reply_num;

 select @step2 = min(step)-1
 from reply
 where board_num = @board_num
 and rnum = @rnum
 and lvl = @lvl
 and step > @step;

declare @tmp_table table(
step int
);
if(isnull(@step2,0)<> 0 )
begin
insert into @tmp_table
values(
(select step
from reply
where step between @step+1 and @step2
and board_num = @board_num
and rnum = @rnum));

 delete from reply
 where board_num = @board_num
 and rnum = @rnum
 and step in (select step from @tmp_table);

 update reply
 set step = step - (select count(*) from @tmp_table)
 where board_num = @board_num
 and rnum = @rnum
 and step > @step;



 end

 else
 begin
 delete from reply
 where board_num = @board_num
 and rnum = @rnum
 and step > @step;
 end

 go
-----------------------------------------------------------------------
--댓글 좋아요 증감
CREATE OR ALTER PROCEDURE REPLYLIKE(
@reply_num int,
@mem_num int,
@cnt int out
)
AS
declare @like int;

 select @like = count(*) from like_reply
 where reply_num = @reply_num
 and  like_mem = @mem_num;
 
 if(@like = 0)
 begin
 insert into like_reply(like_mem, reply_num) values (@mem_num, @reply_num);

 end

 else
 begin
 delete from like_reply
 where reply_num = @reply_num
 and  like_mem = @mem_num;
 end

 select @cnt = count(*) from like_reply
 where reply_num = @reply_num;

GO
--------------------------------------------------------------------------------------
--신고
CREATE OR ALTER PROCEDURE REPORT(
@report_mem   int,
@reported_mem int,
@num           int,
@sort          varchar(20),
@reason        varchar(100),
@cont          varchar(600),
@result        int  out
)
AS
 select @result = count(*)
 from report_tbl
 where report_mem = @report_mem
 and reported_mem = @reported_mem
 and report_sort = @sort
 and cont_num = @num
 and convert(varchar, report_date, 23) =  convert(varchar, getdate(),23);
 if(@result = 0)
 begin
 insert into report_tbl(report_mem, reported_mem, report_sort, cont_num, report_reason, report_cont)
 values (@report_mem, @reported_mem, @sort, @num, @reason, @cont );
 end

GO

-----------------------------------------------------------------------
--게시물 열람(공지사항)
create or alter procedure NOTICEVIEW(
  @IN_BNO int,
  @CHECK int
)
AS
  
  IF(@CHECK = 1 )
  BEGIN
  UPDATE notice
  SET readcount = readcount +1
  WHERE notice_num = @IN_BNO;
  END

  SELECT notice_num, notice_title, nickname notice_writer, notice_cont, regdate, readcount, notice_image
	,(select count(*) from like_notice where notice_num = notice.notice_num) likecount, (select count(*) from reply_notice where reply_notice.notice_num=notice.notice_num) replycount
  FROM notice
  JOIN member ON notice.notice_writer_num = member.mem_num
  WHERE notice_num = @IN_BNO;

  
GO
------------------------------------------------
--좋아요 증감(공지사항)
CREATE OR ALTER PROCEDURE NOTICELIKE(
@notice_num int,
@mem_num  int,
@cnt int out
)
AS
declare @like int;
 select @like = count(*) from like_notice
 where notice_num = @notice_num
 and   like_mem_num = @mem_num;
 
 if(@like = 0)
 begin
 insert into like_notice(like_mem_num, notice_num) values (@mem_num, @notice_num);
 
 end
 else
 begin
 delete from like_notice
 where notice_num = @notice_num
 and like_mem_num = @mem_num;
 end

 select @cnt = count(*) from like_notice
 where notice_num = @notice_num;

GO
--------------------------------------------------------------------------------------
--댓글 작성(공지사항)
CREATE OR ALTER PROCEDURE NOTICE_REPLYWRITE(
@notice_num    int,
@reply_num    int,
@mem_num int,
@reply_cont   varchar(600)
)
AS
declare @step int;
declare @lvl  int;
declare @rnum int;

--새 댓글일 경우
IF(@reply_num =  0)
BEGIN
select @rnum = isnull(max(rnum),1)+1 from reply_notice where notice_num = @notice_num;
set @lvl = 1;
set @step = 1; 
END
--대댓글일 경우
ELSE
BEGIN
select @rnum = rnum, @step = step+1,@lvl =  lvl+1
from reply_notice
where reply_num = @reply_num
and notice_num = @notice_num
--기존 글 순서 변경
update reply_notice
set step = step + 1
where rnum=@rnum
and   step > @step - 1
and   notice_num = @notice_num
END

insert into reply_notice(reply_mem, reply_cont, rnum, lvl, step, notice_num)
values (@mem_num, @reply_cont, @rnum, @lvl, @step, @notice_num);

GO
----------------------------------------------------------------------
--댓글 삭제(공지사항)
CREATE OR ALTER PROCEDURE NOTICE_REPLYDELETE(
@reply_num int 
)
AS
 declare @step int;
 declare @rnum int;
 declare @notice_num int;
 declare @lvl int;

 select @step = step , @rnum = rnum, @notice_num = notice_num, @lvl = lvl from reply_notice
 where reply_num = @reply_num;

 
declare @step2 int;


 delete from reply_notice
 where reply_num = @reply_num;

 select @step2 = min(step)-1
 from reply_notice
 where notice_num = @notice_num
 and rnum = @rnum
 and lvl = @lvl
 and step > @step;

declare @tmp_table table(
step int
);
if(isnull(@step2,0)<> 0 )
begin
insert into @tmp_table
values(
(select step
from reply_notice
where step between @step+1 and @step2
and notice_num = @notice_num
and rnum = @rnum));

 delete from reply_notice
 where notice_num = @notice_num
 and rnum = @rnum
 and step in (select step from @tmp_table);

 update reply_notice
 set step = step - (select count(*) from @tmp_table)
 where notice_num = @notice_num
 and rnum = @rnum
 and step > @step;



 end

 else
 begin
 delete from reply_notice
 where notice_num = @notice_num
 and rnum = @rnum
 and step > @step;
 end

 go
------------------------------------------------------
--댓글 좋아요 증감(공지사항)
CREATE OR ALTER PROCEDURE NOTICE_REPLYLIKE(
@reply_num int,
@mem_num int,
@cnt int out
)
AS
declare @like int;

 select @like = count(*) from like_reply_notice
 where reply_num = @reply_num
 and  like_mem = @mem_num;
 
 if(@like = 0)
 begin
 insert into like_reply_notice(like_mem, reply_num) values (@mem_num, @reply_num);

 end

 else
 begin
 delete from like_reply_notice
 where reply_num = @reply_num
 and  like_mem = @mem_num;
 end

 select @cnt = count(*) from like_reply_notice
 where reply_num = @reply_num;

GO
-----------------------------------------------------------------
--게시물 열람(자유게시판)
create or alter procedure FREE_BOARDVIEW(
  @IN_BNO int,
  @CHECK int
)
AS
  
  IF(@CHECK = 1 )
  BEGIN
  UPDATE free_board
  SET readcount = readcount +1
  WHERE board_num = @IN_BNO;
  END

  SELECT board_num, board_title, nickname board_writer, board_cont, regdate, readcount, board_image
	,(select count(*) from like_free where board_num = free_board.board_num) likecount, (select count(*) from reply_free where reply_free.board_num=free_board.board_num) replycount
  FROM free_board
  JOIN member ON free_board.board_writer_num = member.mem_num
  WHERE board_num = @IN_BNO;

  
GO

-----------------------------------------------------------------------------------------------------
--댓글 작성(자유게시판)
CREATE OR ALTER PROCEDURE FREE_REPLYWRITE(
@free_num    int,
@reply_num    int,
@mem_num int,
@reply_cont   varchar(600)
)
AS
declare @step int;
declare @lvl  int;
declare @rnum int;

--새 댓글일 경우
IF(@reply_num =  0)
BEGIN
select @rnum = isnull(max(rnum),1)+1 from reply_free where board_num = @free_num;
set @lvl = 1;
set @step = 1; 
END
--대댓글일 경우
ELSE
BEGIN
select @rnum = rnum, @step = step+1,@lvl =  lvl+1
from reply_free
where reply_num = @reply_num
and board_num = @free_num
--기존 글 순서 변경
update reply_free
set step = step + 1
where rnum=@rnum
and   step > @step - 1
and   board_num = @free_num
END

insert into reply_free(reply_mem, reply_cont, rnum, lvl, step, board_num)
values (@mem_num, @reply_cont, @rnum, @lvl, @step, @free_num);

GO

---------------------------------------------------------------------------------------
--댓글 삭제(자유게시판)
CREATE OR ALTER PROCEDURE FREE_REPLYDELETE(
@reply_num int 
)
AS
 declare @step int;
 declare @rnum int;
 declare @free_num int;
 declare @lvl int;

 select @step = step , @rnum = rnum, @free_num = board_num, @lvl = lvl from reply_free
 where reply_num = @reply_num;

 
declare @step2 int;


 delete from reply_free
 where reply_num = @reply_num;

 select @step2 = min(step)-1
 from reply_free
 where board_num = @free_num
 and rnum = @rnum
 and lvl = @lvl
 and step > @step;

declare @tmp_table table(
step int
);
if(isnull(@step2,0)<> 0 )
begin
insert into @tmp_table
values(
(select step
from reply_free
where step between @step+1 and @step2
and board_num = @free_num
and rnum = @rnum));

 delete from reply_free
 where board_num = @free_num
 and rnum = @rnum
 and step in (select step from @tmp_table);

 update reply_free
 set step = step - (select count(*) from @tmp_table)
 where board_num = @free_num
 and rnum = @rnum
 and step > @step;



 end

 else
 begin
 delete from reply_free
 where board_num = @free_num
 and rnum = @rnum
 and step > @step;
 end

 go
------------------------------------------------------------------------------------------
--댓글 좋아요 증감(자유게시판)
CREATE OR ALTER PROCEDURE FREE_REPLYLIKE(
@reply_num int,
@mem_num int,
@cnt int out
)
AS
declare @like int;

 select @like = count(*) from like_reply_free
 where reply_num = @reply_num
 and  like_mem = @mem_num;
 
 if(@like = 0)
 begin
 insert into like_reply_free(like_mem, reply_num) values (@mem_num, @reply_num);

 end

 else
 begin
 delete from like_reply_free
 where reply_num = @reply_num
 and  like_mem = @mem_num;
 end

 select @cnt = count(*) from like_reply_free
 where reply_num = @reply_num;

GO
-------------------------------------------------------------------------------------------
--좋아요 증감(자유게시판)
CREATE OR ALTER PROCEDURE FREE_BOARDLIKE(
@board_num int,
@mem_num  int,
@cnt int out
)
AS
declare @like int;
 select @like = count(*) from like_free
 where board_num = @board_num
 and   like_mem_num = @mem_num;
 
 if(@like = 0)
 begin
 insert into like_free(like_mem_num, board_num) values (@mem_num, @board_num);
 
 end
 else
 begin
 delete from like_free
 where board_num = @board_num
 and like_mem_num = @mem_num;
 end

 select @cnt = count(*) from like_free
 where board_num = @board_num;

GO
-------------------------------------------------------------------------------


