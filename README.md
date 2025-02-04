# System Overview

This system is comprised of three main components:
- SQL Database
- C# API Backend
- Angular Frontend

## SQL Database

To set up the SQL database:
1. Execute the SQL file (`sqlTables_storedProcedures.sql`) on localhost.

## C# API Backend

To configure the C# API Backend:
1. Update the database connection string in `appSettings.json` at line 10. For example: DefaultConnection: Server=IG-UMH-LPT-0655\MSSQLSERVER_MAIN;Database=peoplesaccounts;Trusted_Connection=True;TrustServerCertificate=True;
  
2. Run the C# API Backend using IIS Express.
3. Note the port number on which the application is running.

## Swagger Documentation

The API's Swagger documentation can be accessed at:  
[https://localhost:44330/swagger/index.html](https://localhost:44330/swagger/index.html)

## Angular Frontend

To configure the Angular Frontend:
1. If needed, update the service endpoint ports in the following files:
- `accounts.service.ts`
- `people.service.ts`
- `transactions.service.ts`

2. For example, update the API URL Port to:
https://localhost:44330/api/People
3. Ensure that the port on the endpoint matches the port where the C# API Backend is running.
4. Open the command line and navigate to the root directory of the Angular app.
5. Run the following command to start the Angular development server:

```bash
ng serve
```

Login Credentials:
Username: test
Password: testpass
