namespace UserAccountsService.Models
{
    public class PeopleModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Surname { get; set; }  
        public string Email { get; set; }
        public string IdNumber { get; set; } 
        public string AccountNumber { get; set; } 
        public DateTime? DateOfBirth { get; set; }
    }
}
