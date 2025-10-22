-- ===== Safe re-run drops =====
IF OBJECT_ID('dbo.DailySpend', 'U') IS NOT NULL DROP TABLE dbo.DailySpend;
IF OBJECT_ID('dbo.BrandDetail', 'U') IS NOT NULL DROP TABLE dbo.BrandDetail;
GO

-- ===== Master/lookup table =====
CREATE TABLE dbo.BrandDetail (
    BRAND_ID         NVARCHAR(50)   NOT NULL PRIMARY KEY,
    BRAND_NAME       NVARCHAR(255)  NULL,
    BRAND_TYPE       NVARCHAR(100)  NULL,
    BRAND_URL_ADDR   NVARCHAR(500)  NULL,
    INDUSTRY_NAME    NVARCHAR(255)  NULL,
    SUBINDUSTRY_ID   NVARCHAR(50)   NULL,
    SUBINDUSTRY_NAME NVARCHAR(255)  NULL
);
GO


-- ===== Fact table =====
CREATE TABLE dbo.DailySpend (
    BRAND_ID     INT            NOT NULL,
    BRAND_NAME   NVARCHAR(255)  NULL,
    SPEND_AMOUNT DECIMAL(18,2)  NOT NULL,
    STATE_ABBR   CHAR(2)        NOT NULL,
    TRANS_COUNT  DECIMAL(18,2)  NOT NULL,
    TRANS_DATE   DATE           NOT NULL,
    VERSION      DATE           NULL,
    CONSTRAINT PK_DailySpend PRIMARY KEY (BRAND_ID, STATE_ABBR, TRANS_DATE),
    CONSTRAINT FK_DailySpend_Brand
        FOREIGN KEY (BRAND_ID) REFERENCES dbo.BrandDetail(BRAND_ID)
);
GO

-- ===== Helpful indexes =====
CREATE INDEX IX_DailySpend_Date  ON dbo.DailySpend(TRANS_DATE);
CREATE INDEX IX_DailySpend_State ON dbo.DailySpend(STATE_ABBR);
GO

-- ===== Quick smoke checks =====
SELECT TOP 5 * FROM dbo.BrandDetail;
SELECT TOP 5 * FROM dbo.DailySpend;
