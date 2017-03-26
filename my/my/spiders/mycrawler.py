# -*- coding: utf-8 -*-
import scrapy
from scrapy.linkextractors import LinkExtractor
from scrapy.spiders import CrawlSpider, Rule
from my.items import MyItem


class MycrawlerSpider(CrawlSpider):
    name = 'mycrawler'
    allowed_domains = ['c-netchina.com.cn']
    start_urls = ['http://c-netchina.com.cn/']

    rules = (
        Rule(LinkExtractor(allow=r'office/'), callback='parse_item', follow=True),
    )

    def parse_item(self, response):
        i = MyItem()
        #i['domain_id'] = response.xpath('//input[@id="sid"]/@value').extract()
        i['name'] = response.xpath('//title/text()').extract_first()
        #i['description'] = response.xpath('//div[@id="description"]').extract()
        return i
