
--회원
create table member(
mem_num int identity(1,1) primary key,
mem_name varchar(30) not null,
mem_id varchar(12) unique not null,
password varchar(12) not null,
nickname varchar(30) unique not null,
gender varchar(10) not null,
email varchar(30) not null,
mem_tel varchar(20) not null,
birth date not null,
address varchar(50) not null,
address_detail varchar(50),
mem_lvl int unique not null,
joindate smalldatetime default GETDATE(),
delnum int default 0 
)

-- 관리자
insert into member(mem_name, mem_id, password, nickname, gender, email, mem_tel, birth, address, mem_lvl)
values ('김승신','master123','spring1234','master','남','master123@naver.com','010-0000-0000','1991-01-22','미공개',100  );
commit;


-- 후기 게시판
create table board(
board_num int identity(1,1) primary key,
board_title varchar(50) not null,
board_writer_num int not null foreign key references member ( mem_num  )  ,
board_cont varchar(4000) not null,
book_num int not null foreign key references book (book_num),
book_grade int not null,
regdate smalldatetime default GETDATE(),
readcount int default 0
)


-- 추천 테이블
create table like_board(
like_mem_num int not null,
board_num int not null foreign key references board (board_num) on delete cascade,
like_date smalldatetime default GETDATE(),
constraint like_board_group_PK primary key(like_mem_num, board_num) 
)


-- 책 테이블
create table book(
book_num int identity(1,1) primary key,
book_title varchar(30) not null,
book_author varchar(30) not null,
book_sort varchar(20),
book_date date,
publisher varchar(20),
book_image varchar(200) 
)


--reply  - 댓글
create table reply (
reply_num int identity(1,1) primary key,
reply_mem int foreign key references member(mem_num),
reply_cont varchar(800) not null,
reply_date datetime default GETDATE(),
board_num int foreign key references board(board_num) on delete cascade,
rnum int not null,
lvl int not null default 1,
step int not null
)


-- 댓글 추천 테이블
create table like_reply(
like_mem int not null,
reply_num int not null foreign key references reply (reply_num) on delete cascade,
like_date smalldatetime default GETDATE(),
constraint like_reply_group_PK primary key(like_mem, reply_num) 
)





-- 신고 테이블
create table report_tbl(
report_num int identity(1,1) primary key,
report_mem int  not null foreign key references member(mem_num),
reported_mem int not null foreign key references member(mem_num),
report_sort varchar(20) not null,
cont_num int not null,
report_reason varchar(100) not null,
report_cont varchar(600) not null,
report_date datetime default getdate()
)



-- 공지사항
create table notice(
notice_num int identity(1,1) primary key,
notice_title varchar(30) not null,
notice_writer_num int not null foreign key references member ( mem_num  ),
notice_cont varchar(4000) not null,
notice_image varchar(200),
regdate datetime default GETDATE(),
readcount int default 0
)


-- 공지 추천
create table like_notice(
like_mem_num int not null,
notice_num int not null foreign key references notice (notice_num) on delete cascade,
like_date smalldatetime default GETDATE(),
constraint like_notice_group_PK primary key(like_mem_num, notice_num) 
)


-- 공지 댓글
create table reply_notice(
reply_num int identity(1,1) primary key,
reply_mem int foreign key references member(mem_num),
reply_cont varchar(800) not null,
reply_date datetime default GETDATE(),
notice_num int foreign key references notice(notice_num) on delete cascade,
rnum int not null,
lvl int not null default 1,
step int not null
)

-- 공지 댓글 좋아요
create table like_reply_notice(
like_mem int not null,
reply_num int not null foreign key references reply_notice (reply_num) on delete cascade,
like_date smalldatetime default GETDATE(),
constraint like_reply_notice_group_PK primary key(like_mem, reply_num) 
)

-- 자유게시판
create table free_board(
board_num int identity(1,1) primary key,
board_title varchar(50) not null,
board_writer_num int not null foreign key references member ( mem_num  )  ,
board_cont varchar(4000) not null,
board_image varchar(200),
regdate smalldatetime default GETDATE(),
readcount int default 0
)

-- 자유게시판 추천
create table like_free(
like_mem_num int not null,
board_num int not null foreign key references free_board (board_num) on delete cascade,
like_date smalldatetime default GETDATE(),
constraint like_free_group_PK primary key(like_mem_num, board_num) 
)
-- 자유게시판 댓글
create table reply_free(
reply_num int identity(1,1) primary key,
reply_mem int foreign key references member(mem_num),
reply_cont varchar(800) not null,
reply_date datetime default GETDATE(),
board_num int foreign key references free_board(board_num) on delete cascade,
rnum int not null,
lvl int not null default 1,
step int not null
)


-- 자유게시판 댓글 좋아요
create table like_reply_free(
like_mem int not null,
reply_num int not null foreign key references reply_free (reply_num) on delete cascade,
like_date smalldatetime default GETDATE(),
constraint like_reply_free_group_PK primary key(like_mem, reply_num) 
)




