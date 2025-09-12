using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Practica01.Domain
{
    public class Article
    {
        public int Id { get; set; }
        public string Nombre { get; set; }
        public int Stock { get; set; }
        public double PrecioUnitario{ get; set; }

        public override string ToString()
        {
            return Id+ "-" +Nombre+ "-"+Stock;
        }

         
    }
}
