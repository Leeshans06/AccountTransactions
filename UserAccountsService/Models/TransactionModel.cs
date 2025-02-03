namespace UserAccountsService.Models
{
    public class TransactionModel
    {
        public int Id { get; set; }
        public int Account_Id { get; set; }
        public string Transaction_Type { get; set; }
        public decimal Amount { get; set; }
        public DateTime TransactionDate { get; set; }
        public string Description { get; set; }
    }
}
