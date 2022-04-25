Create or Alter PROCEDURE Twitter.insTweetData
(
    @TopicID int,
    @TweetData nvarchar(max)   
)
AS
    BEGIN
    DECLARE @response int
    SET NOCOUNT ON
        BEGIN TRY
        INSERT INTO Twitter.RawTweetData (TopicID, TweetDataJSON)
            Values(@TopicID, @TweetData)
        SET @response = SCOPE_IDENTITY()
        SELECT
            @response

        END TRY
        BEGIN CATCH
            SET 
                @response = 999999999
            SELECT 
                @response
        END CATCH
    SET NOCOUNT OFF
    END
GO 

Create or Alter PROCEDURE Twitter.insSentData
(
    @TweetID int,
    @RawTweetID int,
    @Data nvarchar(max)  
)
AS
    BEGIN
    DECLARE @response int
    SET NOCOUNT ON
        BEGIN TRY
        INSERT INTO Twitter.RawSentData (TweetID, RawTweetID, SentimentDataJSON)
            Values(@TweetID, @RawTweetID, @Data)
        SET @response = SCOPE_IDENTITY()
        SELECT
            @response

        END TRY
        BEGIN CATCH
            SET 
                @response = 999999999
            SELECT 
                @response
        END CATCH
    SET NOCOUNT OFF
    END
GO 

CREATE or alter PROCEDURE Twitter.NewTopic
(
    @Topic varchar(50),
    @Query nvarchar(max)
)
AS
    BEGIN
    DECLARE @response INT
    SET NOCOUNT ON
        BEGIN TRY
            IF(Select COUNT(*) FROM Twitter.Topics WHERE Topic = @Topic ) > 0
                BEGIN
                    SET @response = (Select TopicID FROM Twitter.Topics WHERE Topic = @Topic)
                    SELECT @response
                END
            ELSE
                BEGIN
                    INSERT INTO Twitter.Topics (Topic, Query)
                        VALUES (@Topic, @Query)
                    SET @response = SCOPE_IDENTITY()
                    SELECT 
                        @response
                END
        END TRY
        BEGIN CATCH
            SET @response = 999999999
            SELECT 
                @response
        END CATCH
    SET NOCOUNT OFF
    END
GO



--Users
CREATE OR ALTER PROCEDURE Twitter.insUsers
(
    @TwitterID varchar(255),
    @name varchar(50)
)
AS
    BEGIN
    SET NOCOUNT ON
    DECLARE @response int
        BEGIN TRY
            INSERT INTO Twitter.Users(TwitterID, [Name])
                Values(@TwitterID, @name)
            SET @response = SCOPE_IDENTITY()
            SELECT
                @response
        END TRY
        BEGIN CATCH
            SET @response = 999999999
            SELECT
                @response
        END CATCH
    SET NOCOUNT OFF
    END
GO
--Sources

CREATE OR ALTER PROCEDURE Twitter.addSource
(
    @source varchar(50)
)
AS
    BEGIN
    SET NOCOUNT ON
    DECLARE @response int
        BEGIN TRY
            IF (

                SELECT
                    COUNT(*)
                FROM
                    Twitter.Sources AS S
                WHERE
                    @source = S.Source

                ) > 0
                BEGIN 
                    SET @response = (Select SourceID FROM Twitter.Sources WHERE Source = @source)
                    SELECT 
                        @response
                END

            ELSE
                BEGIN 
                    INSERT INTO Twitter.Sources(Source)
                        Values(@Source)
                    SET @response = SCOPE_IDENTITY()
                    SELECT
                        @response
                END
        END TRY
        BEGIN CATCH
            SET @response = 999999999
            SELECT
                @response
        END CATCH
    SET NOCOUNT OFF
    END
GO


CREATE OR ALTER PROCEDURE Twitter.insTweets
(
    @API_TwitterID varchar(max),
    @RawTweetID varchar(max),
    @TweetText varchar(500),
    @RetweetCount int,
    @ReplyCount int,
    @LikeCount int,
    @QuoteCount int,
    @Location varchar(100),
    @UserID int,
    @SourceID int,
    @TopicID int

)
AS 
BEGIN
SET NOCOUNT ON 
DECLARE @response int
    BEGIN TRY
        INSERT INTO Twitter.Tweets(
                        TwitterResponse_ID, 
                        RawtweetDataID, 
                        [Tweet], 
                        RetweetCount, 
                        ReplyCount, 
                        LikeCount, 
                        QuoteCount, 
                        [Location], 
                        UserID, 
                        SourceID,
                        TopicID
                        )
            Values (
                @API_TwitterID,
                @RawTweetID,
                @TweetText,
                @RetweetCount,
                @ReplyCount,
                @LikeCount,
                @QuoteCount,
                @Location,
                @UserID,
                @SourceID,
                @TopicID
                )
            SET @response = SCOPE_IDENTITY()
            SELECT
                @response
    END TRY

    BEGIN CATCH
        SET @response = 999999999
        SELECT 
            @response
    END CATCH

SET NOCOUNT OFF
END

GO

CREATE OR ALTER PROCEDURE Twitter.GetTweetsForAnalysis
(
    @TopicID int
)
AS
BEGIN
    SET NOCOUNT ON
    BEGIN TRY
        SELECT
            Tweet,
            TweetID,
            RawTweetDataID,
            TopicID

        FROM Twitter.tweets
        WHERE TopicID = @TopicID
    END TRY

    BEGIN CATCH
        DECLARE @response int = 999999999
        SELECT 
        @response
    END CATCH
SET NOCOUNT OFF
END

GO

CREATE OR ALTER PROCEDURE Twitter.AddSentiment
(
    @sentiment varchar(50)
)
AS
BEGIN
SET NOCOUNT ON 
DECLARE @response int
    BEGIN TRY
        IF(SELECT Count(*) FROM Twitter.Sentiments WHERE Sentiment = @sentiment) > 0
          BEGIN
            SET @response = (SELECT SentimentID FROM Twitter.Sentiments WHERE Sentiment = @sentiment)
            SELECT 
                @response
            RETURN
          END  
        ELSE 
            BEGIN
            INSERT INTO Twitter.Sentiments(Sentiment)
                VALUES
                    (@sentiment)
            SET @response = SCOPE_IDENTITY()
            SELECT
                @response
            RETURN
            END
    END TRY
    BEGIN CATCH
         SET @response = 999999999
         SELECT
             @response
     END CATCH
SET NOCOUNT OFF
END

GO 

CREATE OR ALTER PROCEDURE Twitter.insTweetSentiments
(
    @tweetID int,
    @sentimentID int,
    @posConfScore decimal(8,2),
    @negConfScore decimal(8,2),
    @neutConfScore decimal(8,2)
)
AS
BEGIN
SET NOCOUNT ON 
DECLARE @response int
    BEGIN TRY
        INSERT INTO Twitter.tweetSentiments(TweetID, SentimentID, PositiveConfScore, NegativeConfScore, NeutralConfScore )
        VALUES 
            (@tweetID, @sentimentID, @posConfScore, @negConfScore, @neutConfScore)
        SET @response = SCOPE_IDENTITY()
        SELECT 
            @response
    END TRY
    BEGIN CATCH

        SET @response = 999999999
        SELECT 
            @response

    END CATCH

SET NOCOUNT OFF
END

GO 


--insert Key Phrases
CREATE OR ALTER PROCEDURE Twitter.insKeyPhrases
(
    @KeyPhrase varchar(max),
    @TweetID int
)
AS
BEGIN
SET NOCOUNT OFF
DECLARE @response int
DECLARE @KeyPhraseID int
    BEGIN TRY
        IF(SELECT COUNT(*) FROM Twitter.KeyPhrases WHERE KeyPhrase = @KeyPhrase) > 0
        BEGIN
            SET @KeyPhraseID = (SELECT KeyPhraseID FROM Twitter.KeyPhrases WHERE KeyPhrase = @KeyPhrase)
            --SELECT 
                --@KeyPhraseID
                --remove this...

            INSERT INTO Twitter.TweetsKeyPhrases(TweetID, KeyPhraseID)
                VALUES
                    (@tweetID, @KeyPhraseID)
                SET @response = SCOPE_IDENTITY()
            SELECT @response
        END

        ELSE
        BEGIN
            INSERT INTO Twitter.KeyPhrases(KeyPhrase)
            VALUES
                (@KeyPhrase)
            SET @KeyPhraseID = SCOPE_IDENTITY()

            INSERT INTO Twitter.TweetsKeyPhrases(TweetID, KeyPhraseID)
            VALUES
                (@TweetID, @KeyPhraseID)
            SET @response = SCOPE_IDENTITY()
            SELECT 
                @response
        END
    END TRY

    BEGIN CATCH
        SET @response = 999999999
        SELECT 
            @response
    END CATCH
SET NOCOUNT OFF
END

