using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using UserAccountsService.Services;
using UserAccountsService.Models;

[Route("api/[controller]")]
[ApiController]
public class PeopleController : ControllerBase
{
    private readonly DataService _dataService;

    public PeopleController(DataService dataService)
    {
        _dataService = dataService;
    }

    [HttpPost]
    public async Task<IActionResult> CreatePerson([FromBody] PeopleModel person)
    {
        await _dataService.ExecuteAsync("sp_create_person", new
        {
            person.Name,
            person.Email,
            person.Surname,
            person.IdNumber,
            person.AccountNumber
        });
        return Ok();
    }

    [HttpGet]
    public async Task<IEnumerable<PeopleModel>> GetAllPeople()
    {
        var result = await _dataService.ExecuteQueryAsync<PeopleModel>("sp_read_all_people");
        return result;
    }
    [HttpGet("{id}")]
    public async Task<PeopleModel> GetPeople(int id)
    {
        var result = await _dataService.ExecuteQueryAsync<PeopleModel>("GetPeople", new { id = id });

        // Assuming the stored procedure returns only one row
        return result.SingleOrDefault(); // Ensures you return a single result or null if not found
    }
    [HttpPut("{id}")]
    public async Task<IActionResult> UpdatePerson(int id, [FromBody] PeopleModel person)
    {
        await _dataService.ExecuteAsync("sp_update_person", new
        {
            id,
            person.Name,
            person.Surname,
            person.Email,
            person.IdNumber,
            person.AccountNumber
        });
        return Ok();
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> DeletePerson(int id)
    {
        await _dataService.ExecuteAsync("sp_delete_person", new { id });
        return Ok();
    }
}