using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Practica01.Domain;

namespace Practica01.Data
{
    public class ArticleRepository : IArticleRepository
    {
        public bool Delete(int id)
        {
            throw new NotImplementedException();
        }

        public List<Article> GetAll()
        {
            List<Article> list = new List<Article>();  
            //
            var dt= DataHelper.GetInstance().ExecuteSPQuery("SP_RECUPERAR_ARTICULOS");
            
            foreach (DataRow row in dt.Rows)
            {
                Article a = new Article();
                a.Id = (int)row["id_articulo"];
                a.Nombre = (string)row["nombre"];
                a.Stock = (int)row["stock"];
                a.PrecioUnitario = (double)row["precio"];
                
                list.Add(a); 
            }
            return list;

        }

        public Article GetById(int id)
        {
            throw new NotImplementedException();
        }

        public bool Save(Article article)
        {
            throw new NotImplementedException();
        }
    }
}
