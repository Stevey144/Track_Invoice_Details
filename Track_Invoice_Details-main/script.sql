
/****** Object:  Database [POSITIVE8]    Script Date: 16/04/2022 21:54:31 ******/
CREATE DATABASE [POSITIVE8]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'POSITIVE8', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\POSITIVE8.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'POSITIVE8_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\POSITIVE8_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [POSITIVE8] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [POSITIVE8].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [POSITIVE8] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [POSITIVE8] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [POSITIVE8] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [POSITIVE8] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [POSITIVE8] SET ARITHABORT OFF 
GO
ALTER DATABASE [POSITIVE8] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [POSITIVE8] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [POSITIVE8] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [POSITIVE8] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [POSITIVE8] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [POSITIVE8] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [POSITIVE8] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [POSITIVE8] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [POSITIVE8] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [POSITIVE8] SET  ENABLE_BROKER 
GO
ALTER DATABASE [POSITIVE8] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [POSITIVE8] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [POSITIVE8] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [POSITIVE8] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [POSITIVE8] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [POSITIVE8] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [POSITIVE8] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [POSITIVE8] SET RECOVERY FULL 
GO
ALTER DATABASE [POSITIVE8] SET  MULTI_USER 
GO
ALTER DATABASE [POSITIVE8] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [POSITIVE8] SET DB_CHAINING OFF 
GO
ALTER DATABASE [POSITIVE8] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [POSITIVE8] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [POSITIVE8] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [POSITIVE8] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'POSITIVE8', N'ON'
GO
ALTER DATABASE [POSITIVE8] SET QUERY_STORE = OFF
GO
USE [POSITIVE8]
GO
/****** Object:  Schema [positive8]    Script Date: 16/04/2022 21:54:32 ******/
CREATE SCHEMA [positive8]
GO
/****** Object:  Table [positive8].[CUSTOMERS]    Script Date: 16/04/2022 21:54:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [positive8].[CUSTOMERS](
	[CUSTOMER_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[CUSTOMER] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [positive8].[TRACK_INVOICE_DETAILS]    Script Date: 16/04/2022 21:54:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [positive8].[TRACK_INVOICE_DETAILS](
	[INVOICE_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[INVOICE_NUMBER] [nvarchar](100) NULL,
	[INVOICE_DATE] [datetime] NULL,
	[INVOICE_DUE_DATE] [datetime] NULL,
	[INVOICE_DESCRIPTION] [nvarchar](max) NULL,
	[CUSTOMER] [nvarchar](50) NULL,
	[INVOICE_STATUS] [nvarchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GUI_Insert_Customer]    Script Date: 16/04/2022 21:54:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GUI_Insert_Customer](@CUSTOMER     NVARCHAR(100)
                                            ,@ERROR_CODE   NVARCHAR(MAX) OUT)
AS
BEGIN
  SET @ERROR_CODE = ''
  BEGIN TRY
     IF EXISTS(SELECT CUSTOMER FROM positive8.CUSTOMERS WHERE CUSTOMER IN(@CUSTOMER))
		  BEGIN
			 SET @ERROR_CODE = 'Customer Already Exists:'
		  END
	  ELSE
		  BEGIN
             INSERT INTO positive8.CUSTOMERS (CUSTOMER) VALUES (@CUSTOMER)
		  END
  END TRY

  BEGIN CATCH
         SET @ERROR_CODE = 'An error occured, Please contact the system administrator.Errors:'+ CONVERT(NVARCHAR(MAX), ERROR_MESSAGE());
  END CATCH
END

GO
/****** Object:  StoredProcedure [dbo].[GUI_Insert_Update_Delete_Invoice_Details]    Script Date: 16/04/2022 21:54:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GUI_Insert_Update_Delete_Invoice_Details](@OP                  NVARCHAR(1)
																,@INVOICE_ID           BIGINT
																,@INVOICE_NUMBER       NVARCHAR(100)
																,@INVOICE_DATE         DATETIME
																,@INVOICE_DUE_DATE     DATETIME
																,@COLUMNNAME           NVARCHAR(100)= NULL
																,@INVOICE_DESCRIPTION  NVARCHAR(MAX)
																,@CUSTOMER             NVARCHAR(50)
																,@INVOICE_STATUS       NVARCHAR(20)
																,@ERROR_CODE           NVARCHAR(MAX) OUT)

AS
BEGIN
SET @ERROR_CODE = ''

  BEGIN TRY
      IF @OP = 'I'
	  BEGIN
	     INSERT INTO positive8.TRACK_INVOICE_DETAILS (INVOICE_NUMBER
		                                             ,INVOICE_DATE
													 ,INVOICE_DUE_DATE
													 ,INVOICE_DESCRIPTION
													 ,CUSTOMER
													 ,INVOICE_STATUS)
									VALUES
									                 (@INVOICE_NUMBER
													 ,@INVOICE_DATE
													 ,@INVOICE_DUE_DATE
													 ,@INVOICE_DESCRIPTION
													 ,@CUSTOMER
													 ,@INVOICE_STATUS)

	   END

	   IF @OP = 'M'
	   BEGIN
		  UPDATE positive8.TRACK_INVOICE_DETAILS 
		     SET  INVOICE_NUMBER      =  @INVOICE_NUMBER
			     ,INVOICE_DATE        =  @INVOICE_DATE
			     ,INVOICE_DUE_DATE    =  @INVOICE_DUE_DATE
				 ,INVOICE_DESCRIPTION =  @INVOICE_DESCRIPTION
				 ,CUSTOMER            =  @CUSTOMER
				 ,INVOICE_STATUS      =  @INVOICE_STATUS
		   WHERE  INVOICE_ID          =  @INVOICE_ID
	   END

	IF @OP = 'D'
	   BEGIN
		  DELETE FROM positive8.TRACK_INVOICE_DETAILS 
		        WHERE  INVOICE_ID = @INVOICE_ID
   END

  END TRY

  BEGIN CATCH
     SET @ERROR_CODE = 'An error occured, Please contact the system administrator.Errors:'+ CONVERT(NVARCHAR(MAX), ERROR_MESSAGE());
  END CATCH

END
GO
ALTER DATABASE [POSITIVE8] SET  READ_WRITE 
GO
