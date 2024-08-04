using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PruebaTecnica2.Models
{
    public class LIQ
    {
        [Key]
        public string Iliq { get; set; }

        public string Cliqdop { get; set; }

        public string Cliqeta { get; set; }

        public decimal Mliq { get; set; }
        public decimal Mliqgar { get; set; }
        public DateTime? Dlippay { get; set; }
        public string? Clipnomope { get; set; }

        [ForeignKey("Iliq")]
        public DDT DDT { get; set; }
    }
}
