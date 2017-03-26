CREATE TABLE scrapy_target(
id int auto_increment
,url varchar(255)
,unique(id)
);
INSERT IGNORE INTO scrapy_target (id, url)
SELECT * FROM (SELECT 1, 'http://c-netchina.com.cn/') AS tmp
WHERE NOT EXISTS (
    SELECT id FROM scrapy_target WHERE id = 1
) LIMIT 1;
