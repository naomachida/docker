CREATE TABLE IF NOT EXISTS scrapy_result(
id int auto_increment
,item varchar(255) 
,result varchar(900) character set utf8 collate utf8_unicode_ci
,unique(id)
);

