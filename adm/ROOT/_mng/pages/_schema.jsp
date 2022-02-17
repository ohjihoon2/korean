<%--

//카테고리
DROP TABLE `NARO_NEWS_CATEGORY`;
CREATE TABLE `NARO_NEWS_CATEGORY` (
  `idx` int(11) NOT NULL auto_increment,
  `parent_idx` int(11) default NULL,
  `lvl` int(11) default NULL,
  `name` varchar(255) default NULL,
  `link` varchar(255) default NULL,
  `default_thumbnail_file` varchar(255) default NULL,
  `default_banner_file` varchar(255) default NULL,
  `sort_order` varchar(20) default NULL,
  `del_yn` varchar(1) default NULL,
  `write_id` varchar(20) default NULL,
  `write_date` datetime default NULL,
  `update_id` varchar(20) default NULL,
  `update_date` datetime default NULL,
  PRIMARY KEY  (`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


INSERT INTO `NARO_NEWS_CATEGORY`( lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (1, 'A', '궁금한 우리말', 'N', 'naro',now() );
INSERT INTO `NARO_NEWS_CATEGORY`( lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (1, 'B', '놀라운 우리말', 'N', 'naro',now() );
INSERT INTO `NARO_NEWS_CATEGORY`( lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (1, 'C', '쉬어가는 우리말', 'N', 'naro',now() );
INSERT INTO `NARO_NEWS_CATEGORY`( lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (1, 'D', '갈무리할 우리말', 'N', 'naro',now() );

UPDATE `NARO_NEWS_CATEGORY` SET parent_idx = idx WHERE parent_idx IS NULL;


INSERT INTO `NARO_NEWS_CATEGORY`( parent_idx, lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (1, 2, '0010', '안녕! 우리말', 'N', 'naro',now() );
INSERT INTO `NARO_NEWS_CATEGORY`( parent_idx, lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (1, 2, '0020', '전국 방언 말모이', 'N', 'naro',now() );
INSERT INTO `NARO_NEWS_CATEGORY`( parent_idx, lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (1, 2, '0030', '통계로 보는 우리말', 'N', 'naro',now() );

INSERT INTO `NARO_NEWS_CATEGORY`( parent_idx, lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (2, 2, '0010', '한글 위인 열전', 'N', 'naro',now() );
INSERT INTO `NARO_NEWS_CATEGORY`( parent_idx, lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (2, 2, '0020', '국외통신원 편지', 'N', 'naro',now() );
INSERT INTO `NARO_NEWS_CATEGORY`( parent_idx, lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (2, 2, '0030', '국어 교실에서', 'N', 'naro',now() );
INSERT INTO `NARO_NEWS_CATEGORY`( parent_idx, lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (2, 2, '0040', '뭐라고 부를까?', 'N', 'naro',now() );

INSERT INTO `NARO_NEWS_CATEGORY`( parent_idx, lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (3, 2, '0010', '지명, 알고 보니', 'N', 'naro',now() );
INSERT INTO `NARO_NEWS_CATEGORY`( parent_idx, lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (3, 2, '0020', '지혜가 반짝이는 속담', 'N', 'naro',now() );
INSERT INTO `NARO_NEWS_CATEGORY`( parent_idx, lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (3, 2, '0030', '아름다운 우리말', 'N', 'naro',now() );

INSERT INTO `NARO_NEWS_CATEGORY`( parent_idx, lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (4, 2, '0010', '한글 맞춤법', 'N', 'naro',now() );
INSERT INTO `NARO_NEWS_CATEGORY`( parent_idx, lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (4, 2, '0020', '우리말 달인', 'N', 'naro',now() );
INSERT INTO `NARO_NEWS_CATEGORY`( parent_idx, lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (4, 2, '0030', '단어장', 'N', 'naro',now() );
INSERT INTO `NARO_NEWS_CATEGORY`( parent_idx, lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (4, 2, '0040', '소리가 예쁜 우리말', 'N', 'naro',now() );
INSERT INTO `NARO_NEWS_CATEGORY`( parent_idx, lvl, sort_order, name, del_yn, write_id, write_date ) VALUES (4, 2, '0050', '우리말 소식', 'N', 'naro',now() );




update newsdb.NARO_NEWS_CATEGORY set default_thumbnail_file='/images/common/thumnail_category01_01.jpg' where idx=5;
update newsdb.NARO_NEWS_CATEGORY set default_thumbnail_file='/images/common/thumnail_category01_02.jpg' where idx=6;
update newsdb.NARO_NEWS_CATEGORY set default_thumbnail_file='/images/common/thumnail_category01_03.jpg' where idx=7;
update newsdb.NARO_NEWS_CATEGORY set default_thumbnail_file='/images/common/thumnail_category02_01.jpg' where idx=8;
update newsdb.NARO_NEWS_CATEGORY set default_thumbnail_file='/images/common/thumnail_category02_02.jpg' where idx=9;
update newsdb.NARO_NEWS_CATEGORY set default_thumbnail_file='/images/common/thumnail_category02_03.jpg' where idx=10;
update newsdb.NARO_NEWS_CATEGORY set default_thumbnail_file='/images/common/thumnail_category02_04.jpg' where idx=11;
update newsdb.NARO_NEWS_CATEGORY set default_thumbnail_file='/images/common/thumnail_category03_01.jpg' where idx=12;
update newsdb.NARO_NEWS_CATEGORY set default_thumbnail_file='/images/common/thumnail_category03_02.jpg' where idx=13;
update newsdb.NARO_NEWS_CATEGORY set default_thumbnail_file='/images/common/thumnail_category03_03.jpg' where idx=14;
update newsdb.NARO_NEWS_CATEGORY set default_thumbnail_file='/images/common/thumnail_category04_01.jpg' where idx=15;
update newsdb.NARO_NEWS_CATEGORY set default_thumbnail_file='/images/common/thumnail_category04_02.jpg' where idx=17;
update newsdb.NARO_NEWS_CATEGORY set default_thumbnail_file='/images/common/thumnail_category04_03.jpg' where idx=18;
update newsdb.NARO_NEWS_CATEGORY set default_thumbnail_file='/images/common/thumnail_category04_04.jpg' where idx=19;

update newsdb.NARO_NEWS_CATEGORY set default_banner_file='/images/common/banner_category01_01.jpg' where idx=5;
update newsdb.NARO_NEWS_CATEGORY set default_banner_file='/images/common/banner_category01_02.jpg' where idx=6;
update newsdb.NARO_NEWS_CATEGORY set default_banner_file='/images/common/banner_category01_03.jpg' where idx=7;
update newsdb.NARO_NEWS_CATEGORY set default_banner_file='/images/common/banner_category02_01.jpg' where idx=8;
update newsdb.NARO_NEWS_CATEGORY set default_banner_file='/images/common/banner_category02_02.jpg' where idx=9;
update newsdb.NARO_NEWS_CATEGORY set default_banner_file='/images/common/banner_category02_03.jpg' where idx=10;
update newsdb.NARO_NEWS_CATEGORY set default_banner_file='/images/common/banner_category02_04.jpg' where idx=11;
update newsdb.NARO_NEWS_CATEGORY set default_banner_file='/images/common/banner_category03_01.jpg' where idx=12;
update newsdb.NARO_NEWS_CATEGORY set default_banner_file='/images/common/banner_category03_02.jpg' where idx=13;
update newsdb.NARO_NEWS_CATEGORY set default_banner_file='/images/common/banner_category03_03.jpg' where idx=14;
update newsdb.NARO_NEWS_CATEGORY set default_banner_file='/images/common/banner_category04_01.jpg' where idx=15;
update newsdb.NARO_NEWS_CATEGORY set default_banner_file='/images/common/banner_category04_02.jpg' where idx=17;
update newsdb.NARO_NEWS_CATEGORY set default_banner_file='/images/common/banner_category04_03.jpg' where idx=18;
update newsdb.NARO_NEWS_CATEGORY set default_banner_file='/images/common/banner_category04_04.jpg' where idx=19;





//게시글
DROP TABLE `NARO_NEWS`;
CREATE TABLE `NARO_NEWS` (
  `idx` int(11) NOT NULL auto_increment,
  `category_idx` int(11) default NULL,
  `title` varchar(500) default NULL,  
  `subtitle` varchar(500) default NULL,
  `except` varchar(500) default NULL,
  `contents` mediumtext default NULL,
  `thumbnail_file` varchar(255) default NULL,
  `banner_yn` varchar(1) default 'N',
  `banner_file` varchar(255) default NULL,
  `banner_link` varchar(255) default NULL,
  `read_count` int(11) default 0,	  
  `open_yn` varchar(1) default 'N',
  `open_start_datetime` varchar(20) default NULL,
  `open_end_datetime` varchar(20) default NULL,
  `title2` varchar(500) default NULL,
  `title3` varchar(1000) default NULL,
  `del_yn` varchar(1) default 'N',
  `write_id` varchar(20) default NULL,
  `write_date` datetime default NULL,
  `update_id` varchar(20) default NULL,
  `update_date` datetime default NULL,
  PRIMARY KEY  (`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



//기시글 View
DROP VIEW `VW_NARO_NEWS`;
CREATE VIEW `VW_NARO_NEWS` AS
  SELECT 
    a.* , b.name AS category_name, b.parent_idx AS cate1, b.lvl AS cate_lvl,
    CASE WHEN IfNull(a.thumbnail_file,'') = '' THEN b.default_thumbnail_file ELSE a.thumbnail_file END AS default_thumbnail_file,
    CASE WHEN IfNull(a.banner_file,'') = '' THEN b.default_banner_file ELSE a.banner_file END AS default_banner_file,
	CASE WHEN IfNull(a.open_start_datetime,'')='' THEN DATE_FORMAT( a.write_date, '%Y-%m-%d %H:%i') ELSE a.open_start_datetime END AS publish_date
  FROM 
    NARO_NEWS a
    LEFT OUTER JOIN NARO_NEWS_CATEGORY b ON a.category_idx=b.idx
  WHERE 
    a.del_yn='N' AND a.open_yn='Y'
    AND (IfNull(open_start_datetime,'')='' OR open_start_datetime<=DATE_FORMAT( now(), '%Y-%m-%d %H:%i') )
    AND (IfNull(open_end_datetime,'')='' OR DATE_FORMAT( now(), '%Y-%m-%d %H:%i')<=open_end_datetime )
;



//컨텐츠 관리
DROP TABLE `NARO_CONTENTS`;
CREATE TABLE `NARO_CONTENTS` (
  `idx` int(11) NOT NULL auto_increment,
  `gbn` varchar(50) default NULL,
  `open_yn` varchar(1) default 'N',
  `contents` mediumtext default NULL,
  `del_yn` varchar(1) default 'N',
  `write_id` varchar(20) default NULL,
  `write_date` datetime default NULL,
  `update_id` varchar(20) default NULL,
  `update_date` datetime default NULL,
  PRIMARY KEY  (`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



//퀴즈관리
CREATE TABLE `NARO_QUIZ` (
  `idx` int(11) NOT NULL auto_increment,
  `title` varchar(100) default NULL,
  `subtitle` varchar(500) default NULL,
  `ym` varchar(50) default NULL,
  `contents` mediumtext default NULL,
  `open_yn` varchar(1) default 'N',
  `open_start_datetime` varchar(20) default NULL,
  `open_end_datetime` varchar(20) default NULL,  
  `del_yn` varchar(1) default 'N',
  `write_id` varchar(20) default NULL,
  `write_date` datetime default NULL,
  `update_id` varchar(20) default NULL,
  `update_date` datetime default NULL,
  PRIMARY KEY  (`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


//퀴즈문항
CREATE TABLE `NARO_QUIZ_QUESTION` (
  `idx` int(11) NOT NULL auto_increment,
  `quiz_idx` int(11) NOT NULL, 
  `num` int(11) NOT NULL, 
  `title` varchar(100) default NULL,
  `subtitle` varchar(500) default NULL,
  `right_answer` varchar(10) default NULL,
  `contents` mediumtext default NULL,
  `del_yn` varchar(1) default 'N',
  `write_id` varchar(20) default NULL,
  `write_date` datetime default NULL,
  `update_id` varchar(20) default NULL,
  `update_date` datetime default NULL,
  PRIMARY KEY  (`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


//퀴즈 View
DROP VIEW `VW_NARO_QUIZ`;
CREATE VIEW `VW_NARO_QUIZ` AS
  SELECT 
    a.*
  FROM 
    NARO_QUIZ a    
  WHERE 
    a.del_yn='N' AND a.open_yn='Y'
    AND (IfNull(open_start_datetime,'')='' OR open_start_datetime<=DATE_FORMAT( now(), '%Y-%m-%d %H:%i') )
    AND (IfNull(open_end_datetime,'')='' OR DATE_FORMAT( now(), '%Y-%m-%d %H:%i')<=open_end_datetime )
;



//퀴즈문항
DROP TABLE `NARO_QUIZ_APPLY`;
CREATE TABLE `NARO_QUIZ_APPLY` (
  `idx` int(11) NOT NULL auto_increment,
  `quiz_idx` int(11) NOT NULL, 
  `answer` varchar(100) default NULL,
  `score` int(11) default NULL,
  `grade` int(11) default NULL,
  `name` varchar(100) default NULL,
  `phone` varchar(50) default NULL,
  `email` varchar(100) default NULL,  
  `end_yn` varchar(1) default 'N',
  `agree_yn` varchar(1) default 'N',
  `application_yn` varchar(1) default 'N',  
  `del_yn` varchar(1) default 'N',
  `write_id` varchar(20) default NULL,
  `write_date` datetime default NULL,
  `update_id` varchar(20) default NULL,
  `update_date` datetime default NULL,
  PRIMARY KEY  (`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



//소식지 신청/거부
DROP TABLE `NARO_RECEPTION`;
CREATE TABLE `NARO_RECEPTION` (
  `idx` int(11) NOT NULL auto_increment,
  `gbn` varchar(20) default NULL,
  `check1` varchar(1) default 'N',  
  `check2` varchar(1) default 'N',  
  `receipt_gbn` varchar(1) default NULL,
  `name` varchar(100) default NULL,  
  `email` varchar(100) default NULL, 
  `post` varchar(10) default NULL,   
  `address` varchar(500) default NULL,   
  `confirm_yn` varchar(1) default 'N',  
  `del_yn` varchar(1) default 'N',
  `write_ip` varchar(50) default NULL,
  `write_date` datetime default NULL,
  `update_id` varchar(20) default NULL,
  `update_date` datetime default NULL,
  PRIMARY KEY  (`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



//미디어 
DROP TABLE `NARO_MEDIA`;
CREATE TABLE `NARO_MEDIA` (
  `idx` int(11) NOT NULL auto_increment,
  `url` varchar(255) default NULL,  
  `path` varchar(255) default NULL,  
  `filename` varchar(255) default NULL,  
  `del_yn` varchar(1) default 'N',
  `write_id` varchar(20) default NULL,
  `write_date` datetime default NULL,
  `update_id` varchar(20) default NULL,
  `update_date` datetime default NULL,
  PRIMARY KEY  (`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;





/////////////////////////////////////////////////////////
//데이터 이전 ( default db : URIMAL)
// - 기본정보 id, 작성일, 제목, 내용, 작성자 아이디
insert into newsdb.NARO_NEWS( old_idx, write_date, title, contents, write_id )
select ID,  post_date, post_title, post_content, 'admin' from wa_posts where post_status in ('future','publish','inherit') and comment_status='open' and post_type='post' order by ID asc 

//기본 이관된 글의 삭제 상테와 오픈상태 설정
update newsdb.NARO_NEWS set del_yn='N', open_yn='Y' WHERE old_idx IS NOT NULL

//except설정
update newsdb.NARO_NEWS set newsdb.NARO_NEWS.except = ( SELECT post_excerpt FROM wa_posts x WHERE x.ID=old_idx ) where  old_idx is not null

//조회수 설정
update newsdb.NARO_NEWS set newsdb.NARO_NEWS.read_count = ( SELECT pageviews FROM wa_popularpostsdata x WHERE x.postid=old_idx ) where  old_idx is not null



//카테고리 뷰 생성
CREATE VIEW VW_CATE AS
select 
	a.ID, a.post_title, d.name AS cate_name
from 
	wa_posts a 
    inner join wa_term_relationships b on a.ID = b.object_id
    inner join wa_term_taxonomy c on b.term_taxonomy_id = c.term_taxonomy_id
    inner join wa_terms d on c.term_id = d.term_id
where 
	a.post_status in ('future','publish','inherit') and a.comment_status='open' and a.post_type='post' 


//카테 설정
update newsdb.NARO_NEWS set newsdb.NARO_NEWS.category_idx = ( select b.idx from VW_CATE a inner join  newsdb.NARO_NEWS_CATEGORY b on a.cate_name=b.name WHERE a.id=old_idx AND b.lvl=2 LIMIT 1 ) where  old_idx is not null


//내용에 이미지 경로 변경
update newsdb.NARO_NEWS set contents=replace( contents,'http://www.urimal365.kr/','/') where contents like '%http://www.urimal365.kr/%'

update newsdb.NARO_NEWS set contents=replace( contents,'[box-info2]','<div class="content_info">') where contents like '%[box-info2]%'
update newsdb.NARO_NEWS set contents=replace( contents,'[/box-info2]','</div>') where contents like '%[/box-info2]%'


//카테고리별 썸메일 / 배너이미지 등록
update newsdb.NARO_NEWS set thumbnail_file='/images/common/thumnail_category01_01.jpg' where del_yn='N' AND category_idx=5;
update newsdb.NARO_NEWS set thumbnail_file='/images/common/thumnail_category01_02.jpg' where del_yn='N' AND category_idx=6;
update newsdb.NARO_NEWS set thumbnail_file='/images/common/thumnail_category01_03.jpg' where del_yn='N' AND category_idx=7;

update newsdb.NARO_NEWS set thumbnail_file='/images/common/thumnail_category02_01.jpg' where del_yn='N' AND category_idx=8;
update newsdb.NARO_NEWS set thumbnail_file='/images/common/thumnail_category02_02.jpg' where del_yn='N' AND category_idx=9;
update newsdb.NARO_NEWS set thumbnail_file='/images/common/thumnail_category02_03.jpg' where del_yn='N' AND category_idx=10;
update newsdb.NARO_NEWS set thumbnail_file='/images/common/thumnail_category02_04.jpg' where del_yn='N' AND category_idx=11;

update newsdb.NARO_NEWS set thumbnail_file='/images/common/thumnail_category03_01.jpg' where del_yn='N' AND category_idx=12;
update newsdb.NARO_NEWS set thumbnail_file='/images/common/thumnail_category03_02.jpg' where del_yn='N' AND category_idx=13;
update newsdb.NARO_NEWS set thumbnail_file='/images/common/thumnail_category03_03.jpg' where del_yn='N' AND category_idx=14;

update newsdb.NARO_NEWS set thumbnail_file='/images/common/thumnail_category04_01.jpg' where del_yn='N' AND category_idx=15;
update newsdb.NARO_NEWS set thumbnail_file='/images/common/thumnail_category04_02.jpg' where del_yn='N' AND category_idx=17;
update newsdb.NARO_NEWS set thumbnail_file='/images/common/thumnail_category04_03.jpg' where del_yn='N' AND category_idx=18;
update newsdb.NARO_NEWS set thumbnail_file='/images/common/thumnail_category04_04.jpg' where del_yn='N' AND category_idx=19;

update newsdb.NARO_NEWS set banner_file='/images/common/banner_category01_01.jpg' where del_yn='N' AND category_idx=5;
update newsdb.NARO_NEWS set banner_file='/images/common/banner_category01_02.jpg' where del_yn='N' AND category_idx=6;
update newsdb.NARO_NEWS set banner_file='/images/common/banner_category01_03.jpg' where del_yn='N' AND category_idx=7;

update newsdb.NARO_NEWS set banner_file='/images/common/banner_category02_01.jpg' where del_yn='N' AND category_idx=8;
update newsdb.NARO_NEWS set banner_file='/images/common/banner_category02_02.jpg' where del_yn='N' AND category_idx=9;
update newsdb.NARO_NEWS set banner_file='/images/common/banner_category02_03.jpg' where del_yn='N' AND category_idx=10;
update newsdb.NARO_NEWS set banner_file='/images/common/banner_category02_04.jpg' where del_yn='N' AND category_idx=11;

update newsdb.NARO_NEWS set banner_file='/images/common/banner_category03_01.jpg' where del_yn='N' AND category_idx=12;
update newsdb.NARO_NEWS set banner_file='/images/common/banner_category03_02.jpg' where del_yn='N' AND category_idx=13;
update newsdb.NARO_NEWS set banner_file='/images/common/banner_category03_03.jpg' where del_yn='N' AND category_idx=14;

update newsdb.NARO_NEWS set banner_file='/images/common/banner_category04_01.jpg' where del_yn='N' AND category_idx=15;
update newsdb.NARO_NEWS set banner_file='/images/common/banner_category04_02.jpg' where del_yn='N' AND category_idx=17;
update newsdb.NARO_NEWS set banner_file='/images/common/banner_category04_03.jpg' where del_yn='N' AND category_idx=18;
update newsdb.NARO_NEWS set banner_file='/images/common/banner_category04_04.jpg' where del_yn='N' AND category_idx=19;

--%>


