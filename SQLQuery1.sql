create database Fall2021
use Fall2021

--IDENTITY FIELDS
CREATE TABLE Lollipops  
(  
 LollipopID int IDENTITY(1,1),  
 LollipopColor varchar (10),  
 LollipopFlavor varchar(10),  
 constraint pk_Lollipops primary key (LollipopID)
)
  
INSERT Lollipops  
   (LollipopColor, LollipopFlavor)  
VALUES  
   ('Red', 'Cherry') 

--TRIGGERS
CREATE TABLE Source (Source_ID int IDENTITY, Source_Desc varchar(10)) 
go 

CREATE TRIGGER tr_Source_INSERT 
ON Source 
AFTER INSERT 
AS 
SELECT GETDATE() 
go 

INSERT Source (Source_Desc) VALUES ('Test 1') 
go
select * from source

drop trigger tr_Source_INSERT

--STORED PROCEDURES
CREATE PROCEDURE sp_Lollipops_INSERT @LColor varchar(10), @LFlavor varchar(10) AS 
INSERT Lollipops (LollipopColor, LollipopFlavor) VALUES (@LColor,@LFlavor ) 
IF @@ERROR <> 0 GOTO ErrorCode 
IF @LColor = 'Black' 
SELECT 'Yuck' 
ELSE
select 'Yum'
ErrorCode: 
IF @@TRANCOUNT <> 0 
SELECT 'Error Code' 
go

exec sp_Lollipops_INSERT 'Black', 'Licorice'
exec sp_Lollipops_INSERT 'Purple', 'Grape'

select * from Lollipops


--DETERMINE IF AN OBJECT (TABLE, VIEW, STORED PROC, ETC.) EXISTS
select OBJECT_ID ('dbo.lollipops') 

IF OBJECT_ID ('dbo.lollipops') IS NOT NULL  
   DROP TABLE lollipops  
  
Create table Lollipops
(LollipopID int,
LollipopColor varchar(10),
LollipopFlavor varchar(10),
constraint pk_Lollipops primary key (LollipopID))


--TRY CATCH BLOCKS IN STORED PROCEDURES
CREATE PROCEDURE sp_Lollipops_INSERT_2   @LId int, @LColor varchar(10), @LFlavor varchar(10) AS 
    SET XACT_ABORT OFF 
    SET NOCOUNT ON   
    BEGIN TRY
         BEGIN TRANSACTION
             INSERT Lollipops (LollipopID, LollipopColor, LollipopFlavor) 
             VALUES (@LId, @LColor,@LFlavor ) 
          COMMIT TRANSACTION
   END TRY
   BEGIN CATCH
      ROLLBACK TRANSACTION
      PRINT 'In catch block.';  
      THROW;
   END CATCH


exec sp_Lollipops_INSERT_2 1, 'Black', 'Licorice'
exec sp_Lollipops_INSERT_2 2, 'Purple', 'Grape'
exec sp_Lollipops_INSERT_2 3, 'Pink', 'Watermelon'


--CURSORS
DECLARE 
    @LColor VARCHAR(10), 
    @LFlavor  VARCHAR(10);

DECLARE cursor_lollipop CURSOR
FOR SELECT 
        LollipopColor, 
        LollipopFlavor
    FROM 
        Lollipops;
OPEN cursor_lollipop;
FETCH NEXT FROM cursor_lollipop INTO 
    @LColor, 
    @LFlavor;
WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @LColor + ' - ' + @LFlavor;
        FETCH NEXT FROM cursor_lollipop INTO 
            @LColor, 
            @LFlavor;
    END;
CLOSE cursor_lollipop
DEALLOCATE cursor_lollipop


--VIEWS
CREATE VIEW vw_Lollipops AS
select distinct Lollipopflavor from Lollipops

select * from vw_Lollipops

drop view vw_lollipops



