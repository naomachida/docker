# -*- coding: utf-8 -*-

# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: http://doc.scrapy.org/en/latest/topics/item-pipeline.html

import MySQLdb
import ConfigParser



class MyPipeline(object):

    def __init__(self):

        #get config
        CONFIG_FILE = 'mysql.ini'

        conf = ConfigParser.SafeConfigParser()
        conf.read(CONFIG_FILE)

        USER = conf.get('conn', 'user')
        PASS = conf.get('conn', 'pass')
        DB = conf.get('conn', 'db')
        HOST = conf.get('conn', 'host')
        CHAR = conf.get('conn', 'char')

        self.conn = MySQLdb.connect(
            user = USER,
            passwd = PASS,
            host = HOST,
            db = DB,
            charset = CHAR
        )

        self.c = self.conn.cursor()

    def process_item(self, item, spider):

        sql = 'insert into scrapy_result (item, result) values(%s, %s)'
        self.c.execute(sql, ('title', item['name'][0:200]))
        self.conn.commit()
        return item

    def close_spider(self, spider):
        self.c.close()
        self.conn.close()
