/*****************Start the MASTER DATABASE ****************************************/
--USE master
--GO
/*****Runs only after the the Database has been run the first time******************/
DROP DATABASE dbExerciseForScott1
USE master
GO

/*Starts at the MASTER DATABASE, creates a new database different than the Master***/
CREATE DATABASE dbExerciseForScott1
GO

/**********Uses the database just created, not any other database*******************/
USE dbExerciseForScott1 
GO


/***********************************************************************************/
/*************************CREATE TABLES*********************************************/
CREATE TABLE tbUsers
(UserID INT IDENTITY (1,1) PRIMARY KEY,
UserName VARCHAR (15),
Password VARCHAR(8),
AccessLevel VARCHAR(5));
GO

CREATE TABLE tbLogin
(LoginID INT IDENTITY (1,1) PRIMARY KEY,
UserName VARCHAR(15),
LoginSuccessful BIT,
LogDate DATETIME);
GO


/*************************INSERT DATA INTO TABLES***********************************
***********************************************************************************/


/*************************USER DATA************************************************/
INSERT INTO tbUsers(UserName,Password,AccessLevel)VALUES
('Scott','2345','2'),
('Deidre','1234','1');
GO
/*************************ITEM DATA************************************************/
INSERT INTO tbLogin (UserName,LoginSuccessful,LogDate) VALUES 
('Scott',1,'01/01/2014'),
('Deidre',0,'01/01/2014');
GO






/*************************STORED PROCEDURES*****************************************
***********************************************************************************/

/****************************GROUP: LOGIN(3)*****************************
************************************************************************************
**      File: dbExerciseForScott1
**      Desc: spLogin
**			  spLoginSelect - Select all Login
**			  spLoginDelete - Deleting Login Records
**      Auth: Deidre Steenman
**      Date: 2014
************************************************************************************/

CREATE PROCEDURE spLogin
(
@UserName VARCHAR(15), 
@Password VARCHAR(8)
)
AS
BEGIN TRANSACTION
	SELECT * FROM tbUsers WHERE Username = @UserName AND Password = @Password

	-- INSERT ONLY IF the user/password combination is correct!
    IF @@ERROR = 0 AND @@ROWCOUNT > 0
		INSERT INTO tbLogin Values(@UserName,@Password,GETDATE());
	IF @@ERROR = 1 AND @@ROWCOUNT > 0
		INSERT INTO tbLogin Values(@UserName,@Password,GETDATE());
	IF @@ERROR = 0
		COMMIT TRANSACTION
	ELSE
		ROLLBACK TRANSACTION
GO
/* TEST */
--spLogin @UserName = Scott, @Password = 1234
--GO
--Select * FROM tbLogin
GO
/**********************************************************************************/




CREATE PROCEDURE spLoginSelect
AS
BEGIN
Select * from tbLogin
END
/* TEST Works*/
--spLoginSelect
GO
/**********************************************************************************/
--CREATE PROCEDURE spLoginSelect
--( 
--@LoginID INT = NULL
--)
--AS
--BEGIN
--		--IF EXISTS(SELECT UserName FROM tbUsers WHERE UserName = @UserName AND UserPassword = @Password AND SecurityLevel = '2')
--		SELECT * FROM tbLogin
--        WHERE LoginID = ISNULL(@LoginID,LoginID)			
--END

--/* TEST Works*/
----spLoginSelect will not work without UserName and Password
----GO
----spLoginSelect @UserName = Scott, @Password = 2345
--GO


/**********************************************************************************/
CREATE PROCEDURE spLoginDelete
(
@LoginID INT 
)
AS
BEGIN
BEGIN TRANSACTION
		
		BEGIN
		DELETE FROM tbLogin
        WHERE LoginID = @LoginID;
        END
 		
		IF @@ERROR = 0
			COMMIT TRANSACTION
		ELSE
			ROLLBACK TRANSACTION
END
/* TEST Works*/
--Select * from tbLogin
--GO
--spLoginDelete @LoginID = '1' 
--GO
--Select * from tbLogin
GO


Select *  from tbUsers
Select * from tbLogin