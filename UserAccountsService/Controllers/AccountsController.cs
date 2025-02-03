using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using UserAccountsService.Models;
using UserAccountsService.Services;

[Route("api/[controller]")]
[ApiController]
public class AccountsController : ControllerBase
{
    private readonly DataService _dataService;

    public AccountsController(DataService dataService)
    {
        _dataService = dataService;
    }

    [HttpPost]
    public async Task<IActionResult> CreateAccount([FromBody] AccountModel account)
    {
        await _dataService.ExecuteAsync("sp_create_account", new
        {
            account.Person_Id,
            account.Account_Number,
            account.Account_Type,
            account.Balance
        });
        return Ok();
    }

    [HttpGet]
    public async Task<IEnumerable<AccountModel>> GetAllAccounts()
    {
        return await _dataService.ExecuteQueryAsync<AccountModel>("sp_read_all_accounts");
    }

    [HttpGet("{id}")]
    public async Task<IEnumerable<AccountModel>> GetAccountById(int id)
    {
        return await _dataService.ExecuteQueryAsync<AccountModel>("sp_read_person_account", new { id });
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateAccount(int id, [FromBody] AccountModel account)
    {
        await _dataService.ExecuteAsync("sp_update_account", new
        {
            id,
            account.Account_Type,
            account.Balance
        });
        return Ok();
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteAccount(int id)
    {
        await _dataService.ExecuteAsync("sp_delete_account", new { id });
        return Ok();
    }
}
