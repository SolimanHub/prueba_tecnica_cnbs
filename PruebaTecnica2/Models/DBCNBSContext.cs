using Microsoft.EntityFrameworkCore;
using PruebaTecnica2.Models;

namespace PruebaTecnica2.Models
{
    public class DBCNBSContext : DbContext
    {
        public DBCNBSContext(DbContextOptions<DBCNBSContext> options)
            : base(options)
        {
        }

        public DbSet<DDT> DDT { get; set; }
        public DbSet<ART> ART { get; set; }
        public DbSet<LIQ> LIQ { get; set; }
        public DbSet<LQA> LQA { get; set; }
    }
}
