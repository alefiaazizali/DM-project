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
    BRAND_ID     NVARCHAR(50)   NULL,
    BRAND_NAME   NVARCHAR(255)  NULL,
    SPEND_AMOUNT NVARCHAR(50)   NULL,
    STATE_ABBR   NVARCHAR(10)   NULL,
    TRANS_COUNT  NVARCHAR(50)   NULL,
    TRANS_DATE   NVARCHAR(50)   NULL,
    VERSION      NVARCHAR(50)   NULL
);
GO


-- ===== Helpful indexes =====
CREATE INDEX IX_DailySpend_Date  ON dbo.DailySpend(TRANS_DATE);
CREATE INDEX IX_DailySpend_State ON dbo.DailySpend(STATE_ABBR);
GO

-- ===== Quick smoke checks =====
SELECT TOP 5 * FROM dbo.BrandDetail;
SELECT TOP 5 * FROM dbo.DailySpend;
