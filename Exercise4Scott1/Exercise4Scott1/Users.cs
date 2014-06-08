using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Exercise4Scott1
{
    public class Users
    {
    
       
        private string _userID { get; set; }
        private int _loginSuccessful { get; set; }
        private string _logDate { get; set; }
       
        
        public string UserID { get; set; }
        //public string UserID { get { return _userID; } }
        //public string UserID { set { _userID = value;} }
        //public string UserID
        //{
        //   get { return _userID; }
        //   set { _userID = value;}
        //}
        

        public int LoginSuccessful { get; set; }
        //public int LoginSuccessful { get { return _loginSuccessful; } }
        //public int LoginSuccessful { set { _loginSuccessful = value; } }
        //public int LoginSuccessful
        //{
        //    get { return _loginSuccessful; }
        //    set { _loginSuccessful = value; }
        //}

        public string LogDate { get; set; }
        ////public string LogDate { get { return _logDate; } }
        ////public string LogDate { set { _logDate = value; } }
        ////public string LogDate
        ////{
        ////    get { return _logDate; }
        ////    set { _logDate = value; }
        ////}


        public void SaveToLog(string UserId, string LoginSuccessful, int LogDate)
        {
            DAL_Project.DAL dal = new DAL_Project.DAL("Data Source=localhost;Initial Catalog=dbExerciseForScott1;Integrated Security=SSPI");
            dal.AddParam("@UserID", UserId);
            dal.AddParam("@LoginSuccessful", LoginSuccessful);
            dal.AddParam("@LogDate", LogDate);
            dal.ExecuteProcedure("spLogin");
        }
    }
}