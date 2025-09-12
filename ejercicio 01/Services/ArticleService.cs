using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Practica01.Data;
using Practica01.Domain;

namespace Practica01.Services
{
    public class ArticleService
    {
        private IArticleRepository _repository;

        public ArticleService()
        {
            _repository = new ArticleRepository();
        }

        public List<Article> GetArticles()
        {
            return _repository.GetAll();
        }

        public bool Save(Article article)
        {
            return _repository.Save(article);
        }


    }
}
