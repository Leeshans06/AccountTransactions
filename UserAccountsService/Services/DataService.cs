using Dapper;
using Microsoft.Data.SqlClient;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace UserAccountsService.Services
{
    public class DataService
    {
        private readonly string _connectionString;

        public DataService(string connectionString)
        {
            _connectionString = connectionString;
        }

        // Execute stored procedure with no return value
        public async Task ExecuteAsync(string storedProcedure, object parameters = null)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                await connection.ExecuteAsync(storedProcedure, parameters, commandType: CommandType.StoredProcedure);
            }
        }

        // Execute stored procedure and return a single result
        public async Task<T> ExecuteScalarAsync<T>(string storedProcedure, object parameters = null)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                return await connection.ExecuteScalarAsync<T>(storedProcedure, parameters, commandType: CommandType.StoredProcedure);
            }
        }

        // Execute stored procedure and return a list of results
        public async Task<IEnumerable<T>> ExecuteQueryAsync<T>(string storedProcedure, object parameters = null)
        {
            using (var connection = new SqlConnection(_connectionString))
            {
                return await connection.QueryAsync<T>(storedProcedure, parameters, commandType: CommandType.StoredProcedure);
            }
        }
    }
}
