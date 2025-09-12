// See https://aka.ms/new-console-template for more information
//Console.WriteLine("Hello, World!");

using Practica01.Domain;
using Practica01.Services;
 
ArticleService oService = new ArticleService();
List<Article> la= oService.GetArticles();
if (la.Count > 0)
    foreach (Article a in la)
        Console.WriteLine(a);
else
    Console.WriteLine("NO HAY PRODUCTOS");

