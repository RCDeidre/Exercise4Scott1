/*****************Start the MASTER DATABASE ****************************************/
USE master
GO
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



/****************************GROUP: MISC(1)*****************************************
************************************************************************************
**      File: dbExerciseForScott1
**      Desc: spSigningIn - Signing in to Site Regular
**      Auth: Deidre Steenman
**      Date: 2014
***********************************************************************************/
CREATE PROCEDURE spSigningIn 
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
--spSignIn @UserName = Scott, @Password = 1234
--GO
--Select * FROM tbLogin
GO




/****************************GROUP: LOGIN(2)*****************************
************************************************************************************
**      File: dbExerciseForScott1
**      Desc: spLoginSelect - Select all Login
**			  spLoginDelete - Deleting Login Records
**      Auth: Deidre Steenman
**      Date: 2014
************************************************************************************/
CREATE PROCEDURE spLoginSelect
AS
BEGIN
Select * from tbLogin
END
/* TEST Works*/
--spLoginSelect
GO
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





/*************************GROUP: USERS(4)*************************************
************************************************************************************
**      File: dbExerciseForScott1
**      Desc: spUserUpdate - Update a Users Record
**			  spUserSelect - Selects all Users
**			  spUserDelete - Deletes a User
**			  spUserPasswordUpdate - Update a Users Password
**			  Auth: Deidre Steenman
**      Date: 2014
***********************************************************************************/
CREATE PROCEDURE spUserUpdate
(
@UserID INT = NULL,
@UserName VARCHAR(15)= NULL,
@Password VARCHAR(8)= NULL,
@AccessLevel VARCHAR(5)= NULL
)
AS
BEGIN
BEGIN TRANSACTION
		BEGIN
			UPDATE tbUsers
			SET UserName = ISNULL(@UserName,UserName),
				Password = ISNULL(@Password,Password),
				AccessLevel = ISNULL(@AccessLevel,AccessLevel)
				
			WHERE UserID = @UserID
		END
				
		IF @@ERROR = 0
			COMMIT TRANSACTION
		ELSE
			ROLLBACK TRANSACTION
END	
--/*TEST WORKS*/
--spUserAddUpdate @UserID = 1, @UserName = "Karol"
GO
/***********************************************************************************/
CREATE PROCEDURE spUserSelect
AS
BEGIN
	SELECT * FROM tbUsers
END
/*TEST Works*/
--spUserSelect
GO
/***********************************************************************************/
CREATE PROCEDURE spUserDelete
(
@UserID INT 
)
AS
BEGIN
BEGIN TRANSACTION
			BEGIN
				DELETE FROM tbUsers WHERE UserID = @UserID 
				
			END

		IF @@ERROR = 0
			COMMIT TRANSACTION
		ELSE
			ROLLBACK TRANSACTION
END	
GO
/***********************************************************************************/
CREATE PROCEDURE spUserPasswordUpdate
(
@UserName VARCHAR(15),
@Password VARCHAR(8),
@NewPassword VARCHAR(8)
)
AS
BEGIN
BEGIN TRANSACTION
		IF EXISTS(SELECT * FROM tbUsers WHERE UserName = @UserName AND Password = @Password)
		BEGIN
		UPDATE tbUsers
		SET Password = @NewPassword
		WHERE UserName = @UserName
		AND Password = @Password
		END
				
		IF @@ERROR = 0
			COMMIT TRANSACTION
		ELSE
			ROLLBACK TRANSACTION
		
END	
--/*TEST Works*/
--spUserPasswordUpdate @UserName = Scott, @Password = 1234, @NewPassword = 9876
--GO
--Select * from tbUsers
GO
/***********************************************************************************/


Select *  from tbUsers
Select * from tbLogin