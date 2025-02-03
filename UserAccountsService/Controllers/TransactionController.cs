using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
using UserAccountsService.Models;
using UserAccountsService.Services;

[Route("api/[controller]")]
[ApiController]
public class TransactionsController : ControllerBase
{
    private readonly DataService _dataService;

    public TransactionsController(DataService dataService)
    {
        _dataService = dataService;
    }

    [HttpPost]
    public async Task<IActionResult> CreateTransaction([FromBody] TransactionModel transaction)
    {
        await _dataService.ExecuteAsync("sp_create_transaction", new
        {
            account_id = transaction.Account_Id,
            transaction_type = transaction.Transaction_Type,
            amount = transaction.Amount,
            description = transaction.Description
        });
        return Ok();
    }

    [HttpGet("{account_id}")]
    public async Task<IEnumerable<TransactionModel>> GetAllTransactions(int account_id)
    {
        return await _dataService.ExecuteQueryAsync<TransactionModel>("sp_read_all_transactions", new { account_id});
    }

    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateTransaction(int id, [FromBody] TransactionModel transaction)
    {
        await _dataService.ExecuteAsync("sp_update_transaction", new
        {
            id = id,
            transaction_type = transaction.Transaction_Type,
            amount = transaction.Amount,
            description = transaction.Description
        });
        return Ok();
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteTransaction(int id)
    {
        await _dataService.ExecuteAsync("sp_delete_transaction", new { id });
        return Ok();
    }
}
