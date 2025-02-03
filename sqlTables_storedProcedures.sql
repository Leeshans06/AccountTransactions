USE [peoplesaccounts]
GO
/****** Object:  Table [dbo].[accounts]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[accounts](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[date_of_birth] [date] NULL

PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[account_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[people]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[people](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[email] [nvarchar](255) NOT NULL,
	[date_of_birth] [date] NULL,
	[created_at] [datetime] NULL,
	[surname] [nvarchar](100) NULL,
	[idnumber] [nvarchar](20) NULL,
	[accountnumber] [nvarchar](50) NULL
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transactions]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transactions](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[account_id] [int] NOT NULL,
	[transaction_type] [nvarchar](20) NULL,
	[amount] [decimal](18, 2) NOT NULL,
	[transaction_date] [datetime] NULL,
	[description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[users]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](255) NOT NULL,
	[password] [nvarchar](255) NOT NULL,
	[created_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[password] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[accounts] ADD  DEFAULT ((0.00)) FOR [balance]
GO
ALTER TABLE [dbo].[accounts] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[people] ADD  DEFAULT (getdate()) FOR [created_at]
GO
ALTER TABLE [dbo].[transactions] ADD  DEFAULT (getdate()) FOR [transaction_date]
GO
ALTER TABLE [dbo].[users] ADD  DEFAULT (getdate()) FOR [created_at]
GO
/****** Object:  StoredProcedure [dbo].[GetPeople]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPeople]
    @id int
AS
BEGIN
    SELECT *
    FROM people
    WHERE id = @id;
END;

GO
/****** Object:  StoredProcedure [dbo].[GetUserCredentials]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserCredentials]
    @username NVARCHAR(255)
AS
BEGIN
    SELECT username, password
    FROM users
    WHERE username = @username;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_create_account]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_create_account]
    @person_id INT,
    @account_number NVARCHAR(20),
    @account_type NVARCHAR(20),
    @balance DECIMAL(18, 2) = 0.00
AS
BEGIN
    INSERT INTO accounts (person_id, account_number, account_type, balance)
    VALUES (@person_id, @account_number, @account_type, @balance);
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_create_person]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_create_person]
	@name NVARCHAR(255),
    @surname NVARCHAR(255),
    @email NVARCHAR(255),
    @idnumber NVARCHAR(20),
    @accountnumber NVARCHAR(50),
    @date_of_birth DATE = NULL
AS
BEGIN
    INSERT INTO people (name, surname, email, idnumber, accountnumber, date_of_birth)
    VALUES (@name, @surname, @email, @idnumber, @accountnumber, @date_of_birth);
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_create_transaction]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_create_transaction]
    @account_id INT,
    @transaction_type NVARCHAR(20),
    @amount DECIMAL(18, 2),
    @description NVARCHAR(MAX) = NULL
AS
BEGIN
    INSERT INTO transactions (account_id, transaction_type, amount, description)
    VALUES (@account_id, @transaction_type, @amount, @description);
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_account]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_delete_account]
    @id INT
AS
BEGIN
    DELETE FROM accounts
    WHERE id = @id;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_person]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_delete_person]
    @id INT
AS
BEGIN
    DELETE FROM people
    WHERE id = @id;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_delete_transaction]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_delete_transaction]
    @id INT
AS
BEGIN
    DELETE FROM transactions
    WHERE id = @id;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_read_all_accounts]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_read_all_accounts]
AS
BEGIN
    SELECT * FROM accounts;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_read_all_people]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_read_all_people]
AS
BEGIN
    SELECT * FROM people;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_read_all_transactions]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_read_all_transactions]
    @account_id INT
AS
BEGIN
    SELECT * 
    FROM transactions
    WHERE account_id = @account_id;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_read_person_account]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_read_person_account]
    @id int
AS
BEGIN
    SELECT *
    FROM accounts
    WHERE person_id = @id;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_account]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_update_account]
    @id INT,
    @account_type NVARCHAR(20),
    @balance DECIMAL(18, 2)
AS
BEGIN
    UPDATE accounts
    SET account_type = @account_type, balance = @balance
    WHERE id = @id;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_person]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_update_person]
    @id INT,
    @name NVARCHAR(255),
    @surname NVARCHAR(255),
    @email NVARCHAR(255),
    @idnumber NVARCHAR(20),
    @accountnumber NVARCHAR(50),
    @date_of_birth DATE = NULL
AS
BEGIN
      UPDATE people
    SET 
        name = @name, 
        surname = @surname, 
        email = @email, 
        idnumber = @idnumber, 
        accountnumber = @accountnumber, 
        date_of_birth = @date_of_birth
    WHERE id = @id;
END;

GO
/****** Object:  StoredProcedure [dbo].[sp_update_transaction]    Script Date: 2025/02/02 17:09:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_update_transaction]
    @id INT,
    @transaction_type NVARCHAR(20),
    @amount DECIMAL(18, 2),
    @description NVARCHAR(MAX) = NULL
AS
BEGIN
    UPDATE transactions
    SET transaction_type = @transaction_type, amount = @amount, description = @description
    WHERE id = @id;
END;

GO
insert into users(username,password) values ('test','testpass');
Go