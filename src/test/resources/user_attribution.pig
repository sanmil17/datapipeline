REGISTER /usr/local/Cellar/pig-0.17.0/lib/piggybank.jar;
REGISTER /usr/local/Cellar/pig-0.17.0/lib/joda-time-2.9.3.jar;

DEFINE CustomFormatToISO org.apache.pig.piggybank.evaluation.datetime.convert.CustomFormatToISO();
DEFINE ISOToUnix org.apache.pig.piggybank.evaluation.datetime.convert.ISOToUnix();
transactions = LOAD 'input/transactions_attr.txt' USING PigStorage(',') AS (transactionid:int,deviceid:int,hotelid:int,price:int,desc:chararray,transactiondate:chararray);
users_attr = LOAD 'input/user_attr.txt' USING PigStorage(',') AS (deviceid1:int,channelid:chararray,campaignid:int,vendor:chararray,userdate:chararray,touchtype:chararray);

user_transactions = join transactions by deviceid, users_attr by deviceid1;

dump user_transactions;

user_transactions_group = group user_transactions by transactionid;

dump user_transactions_group;

attr_campaign = FOREACH user_transactions_group GENERATE group,MAX(user_transactions.userdate);


dump attr_campaign;