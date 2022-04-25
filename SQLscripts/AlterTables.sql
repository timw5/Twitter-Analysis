
-- ALTER TABLE Twitter.TweetsKeyPhrases
-- ADD CONSTRAINT fk_KPID
-- FOREIGN KEY(KeyPhraseID) REFERENCES Twitter.KeyPhrases(KeyPhraseID)

-- ALTER TABLE Twitter.TweetsKeyPhrases
-- ADD CONSTRAINT fk_tweets_id 
-- FOREIGN KEY(TweetID) REFERENCES Twitter.Tweets(TweetID)

-- ALTER TABLE Twitter.tweetSentiments 
-- ADD CONSTRAINT fk_tweet_ID
-- FOREIGN KEY(TweetID) REFERENCES Twitter.tweets(TweetID)

-- ALTER TABLE Twitter.tweetSentiments
-- ADD CONSTRAINT fk_sentID
-- FOREIGN KEY(SentimentID) REFERENCES Twitter.Sentiments(SentimentID)

-- ALTER TABLE Twitter.Tweets
-- ADD CONSTRAINT fk_rawTweetID 
-- FOREIGN KEY(RawTweetDataID) REFERENCES Twitter.RawTweetData(RawTweetDataID)

-- ALTER TABLE Twitter.Tweets
-- ADD CONSTRAINT fk_userID 
-- FOREIGN KEY(UserID) REFERENCES Twitter.Users(UserID)

-- ALTER TABLE Twitter.Tweets
-- ADD CONSTRAINT fk_SourceID 
-- FOREIGN KEY(SourceID) REFERENCES Twitter.Sources(SourceID)

-- ALTER TABLE Twitter.Tweets
-- ADD CONSTRAINT fk_TopicID
-- FOREIGN KEY(TopicID) REFERENCES Twitter.Topics(TopicID)

-- ALTER TABLE Twitter.RawSentData
-- ADD CONSTRAINT fktweetID
-- FOREIGN KEY(TweetID) REFERENCES Twitter.Tweets(TweetID)

-- ALTER TABLE Twitter.RawSentData
-- ADD CONSTRAINT fkRawtweetID
-- FOREIGN KEY(RawTweetID) REFERENCES Twitter.RawTweetData(RawTweetDataID)

-- ALTER TABLE Twitter.RawTweetData
-- ADD CONSTRAINT fkTopicID 
-- FOREIGN KEY(TopicID) REFERENCES Twitter.Topics(TopicID)
