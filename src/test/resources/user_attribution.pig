REGISTER /usr/local/Cellar/pig-0.17.0/lib/piggybank.jar;
REGISTER /usr/local/Cellar/pig-0.17.0/lib/joda-time-2.9.3.jar;

DEFINE CustomFormatToISO org.apache.pig.piggybank.evaluation.datetime.convert.CustomFormatToISO();
DEFINE ISOToUnix org.apache.pig.piggybank.evaluation.datetime.convert.ISOToUnix();
transactions = LOAD 'input/transactions_attr.txt' USING PigStorage('\t') AS (transactionid:int,deviceid:int,hotelid:int,price:int,desc:chararray,transactiondate:chararray);
users_attr = LOAD 'input/user_attr.txt' USING PigStorage('\t') AS (deviceid:int,channelid:chararray,campaignid:int,vendor:chararray,userdate:chararray,touchtype:chararray);

users_attr_data = foreach users_attr generate (long)ISOToUnix(CustomFormatToISO(userdate, 'yyyy-MM-dd HH:mm')) AS time:long;

user_transactions = join transactions by (deviceid), users_attr by (deviceid);

user_transactions_group = group user_transactions by transactionid;

attr_campaign = FOREACH user_transactions_group GENERATE flatten(transactions.transactionid) as trans_id,
flatten(users_attr.deviceid) as device_id, flatten(users_attr.channelid) as channel_id, flatten(users_attr.campaignid) as campaign_id,
flatten(users_attr_data.time) as campaign_date_time;
dump attr_campaign;