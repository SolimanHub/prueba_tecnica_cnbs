using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PruebaTecnica2.Models
{
    public class LQA
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        [StringLength(50)]
        public string? Iliq { get; set; }

        public int? Nart { get; set; }

        public string? Clqatax { get; set; }

        public string? Clqatyp { get; set; }

        public decimal? Mlqabas { get; set; }

        public decimal? Qlqacoefic { get; set; }

        public decimal? Mlqa { get; set; }

        [ForeignKey("Iliq")]
        public LIQ LIQ { get; set; }
    }
}
