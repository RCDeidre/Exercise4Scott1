using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DAL_Project
{
    public class DAL
    {

        public string ConnString;
        List<SqlParameter> _parameters;

        public DAL(string connString)
        {
            ConnString = connString;
            _parameters = new List<SqlParameter>();
        }

        public void AddParam(string paramName, object paramValue)
        {
            _parameters.Add(new SqlParameter(paramName, paramValue));
        }

        public DataSet ExecuteProcedure(string ProcName)
        {
            DataSet dsResult = new DataSet();

            SqlConnection conn = new SqlConnection(ConnString);
            SqlDataAdapter da = new SqlDataAdapter(ProcName, conn);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            // Parameters
            foreach (SqlParameter parameter in _parameters)
            {
                da.SelectCommand.Parameters.Add(parameter);
            }

            conn.Open();
            da.Fill(dsResult);
            conn.Close();
            ClearParams();

            return dsResult;
        }

        public void ClearParams()
        {
            _parameters = new List<SqlParameter>();
        }
    }
}

//How to use the DAL

//DAL_Project.DAL dal = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog="NAME OF YOUR DATABASE HERE";Integrated Security=SSPI");
//dal.AddParam("@ClientID", txtClientID.Text);//example only: repeat for all Parameters
//return dal.ExecuteProcedure("Put Stored Procedure name here");
//if you do not return anything no need to use 'return' here like deleting info -  dal.ExecuteProcedure("Put Stored Procedure name here");


