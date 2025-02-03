using System;
using BCrypt.Net;
using Microsoft.AspNetCore.Mvc;
using UserAccountsService.Models;
using UserAccountsService.Services;


namespace UserAccountsService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UsersController : ControllerBase
    {
        private readonly DataService _dataService;

        public UsersController(DataService dataService)
        {
            _dataService = dataService;
        }
        [HttpGet]
        public async Task<bool> GetUserCredentials(string username, string password)
        {
            // Query to call the stored procedure
            string storedProcedure = "GetUserCredentials"; // Name of the stored procedure

            // Use _dataService to execute the query and map to UserCredentialsModel
            var parameters = new { username }; // Anonymous object to pass parameter to SP
            var result = await _dataService.ExecuteQueryAsync<UserCredentialModel>(storedProcedure, parameters);
            var storedPass = result.FirstOrDefault()?.password;
           
            bool match = BCrypt.Net.BCrypt.Verify(password, storedPass);
            return match;

        }
    }    
}
