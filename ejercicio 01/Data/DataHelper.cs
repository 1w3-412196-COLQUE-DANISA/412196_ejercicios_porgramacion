using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Data.SqlClient;
using System.Data;


namespace Practica01.Data
{
    public class DataHelper
    {
        private static DataHelper _instance;
        private SqlConnection _connection;

        private DataHelper()
        { //_connection = new SqlConnection (@"Data Source=DANISA\SQLEXPRESS;Initial Catalog=Practica_01;Integrated Security=True;Encrypt=False");    
            _connection = new SqlConnection(Properties.Resources.CadenaConexionLocal);
        }
        public static DataHelper GetInstance()
        {
            if (_instance == null)
            { 
                _instance = new DataHelper();
            } 
            return _instance;
        
        }

        public DataTable ExecuteSPQuery(string sp)//, List<ParametroSP>? param = null)
        {
            DataTable dt = new DataTable();
            try
            {
                _connection.Open();
                var cmd = new SqlCommand(sp, _connection);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = sp;
                dt.Load(cmd.ExecuteReader());
            

                ////if (param != null)
                //{
                //    foreach (ParametroSP p in param)
                //    {
                //        cmd.Parameters.AddWithValue(p.Name, p.Valor);
                //    }
                //}

                //dt.Load(cmd.ExecuteReader());
            }
            catch (SqlException ex)
            {
                dt = null;
            }
            finally
            {
                _connection.Close();
            }

            return dt;
        }

    }
}
