namespace UserAccountsService.Models
{
    public class AccountModel
    {
   
            public int Id { get; set; }
            public int Person_Id { get; set; }
            public string Account_Number { get; set; }
            public string Account_Type { get; set; }
            public decimal Balance { get; set; }
        
    }
}
