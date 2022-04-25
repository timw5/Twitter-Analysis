Create Schema Twitter;
GO

--Done
Create Table Twitter.RawTweetData 
(
    RawTweetDataID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TopicID int NOT NULL,
    [TweetDataJSON] nvarchar(max) NOT NULL,
)

--Done
Create Table Twitter.RawSentData
(
    RawSentDataID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TweetID int NOT NULL,
    RawTweetID int NOT NULL,
    [SentimentDataJSON] nvarchar(max) NOT NULL
)


--Done
Create Table Twitter.Topics
(
    TopicID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Topic varchar(50) NOT NULL,
    Query nvarchar(max) NOT NULL
)

--Done
Create Table Twitter.Users
(
    UserID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name] varchar(50) NOT NULL DEFAULT('unknown'),
    TwitterID varchar(50) NOT NULL DEFAULT('unknown')
)

--Done
Create Table Twitter.Sources
(
    SourceID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Source varchar(max) NOT NULL DEFAULT('unknown')
)

--Done
Create Table Twitter.Tweets
(
    TweetID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TwitterResponse_ID varchar(50) NOT NULL,
    RawTweetDataID int NOT NULL,
    [Tweet] nvarchar(max) NOT NULL,
    RetweetCount int NOT NULL DEFAULT(0),
    ReplyCount int NOT NULL DEFAULT(0),
    LikeCount int NOT NULL DEFAULT(0),
    QuoteCount int NOT NULL DEFAULT(0),
    [Location] varchar(max) NOT NULL DEFAULT('Unknown'),
    UserID int NOT NULL,
    SourceID int NOT NULL,
    TopicID int NOT NULL
)

--Done
Create Table Twitter.Sentiments
(
    SentimentID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Sentiment varchar(50) NOT NULL
)

--Done
CREATE TABLE Twitter.tweetSentiments
(
    TweetSentimentID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TweetID int NOT NULL,
    SentimentID int NOT NULL,
    PositiveConfScore decimal(8,2) NOT NULL,
    NegativeConfScore decimal(8,2) NOT NULL,
    NeutralConfScore decimal(8,2)  NOT NULL,
)

--Done
Create Table Twitter.KeyPhrases
(
    KeyPhraseID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    KeyPhrase varchar(max) NOT NULL
)

--Done
Create Table Twitter.TweetsKeyPhrases
(
    TweetsKeyPhrasesID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
    TweetID int NOT NULL,
    KeyPhraseID int NOT NULL
)


--drops if needed:

-- DROP TABLE if EXISTS Twitter.RawSentData
-- DROP TABLE if EXISTS Twitter.TweetsKeyPhrases
-- DROP TABLE if EXISTS Twitter.Tweets
-- DROP TABLE if EXISTS Twitter.Users
-- DROP TABLE if EXISTS Twitter.Sources
-- DROP TABLE if EXISTS Twitter.Topics
-- DROP TABLE if EXISTS Twitter.KeyPhrases
-- DROP TABLE if EXISTS Twitter.Sentiments
-- DROP TABLE if EXISTS Twitter.TweetSentiments
-- DROP TABLE if EXISTS Twitter.RawTweetData
--

