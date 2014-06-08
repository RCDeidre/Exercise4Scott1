using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Exercise4Scott1
{
    public partial class MyMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            lbnAdmin.Visible = false;
            lbnUser.Visible = false;
            pnlSignedOut.Visible = false;

            HttpCookie cookieUserID = Request.Cookies["StaySignedInUserID"];//Bakes a cookie
            HttpCookie cookieAccess = Request.Cookies["StaySignedInAccessLevel"];
           
            /* If the cookie is not expired and the Session is empty
             * puts the value of the cookie into the Session*/
            if (cookieAccess != null && Session["AccessLevel"] == null)
            {
                Session["AccessLevel"] = cookieAccess.Value;
            }
            if (cookieUserID != null && Session["UserID"] == null)
            {
                Session["UserID"] = cookieUserID.Value;
            }

            if (Session["UserID"] != null)
            {

                pnlSignedIn.Visible = false;
                pnlSignedOut.Visible = true;


                if (Session["AccessLevel"] != null && Session["AccessLevel"].ToString() == "2")
                {
                    lbnAdmin.Visible = true;
                   
                }
               
            }

        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
               Session["SignedIn"] = "User";
               DataSet ds = new DataSet();
               DAL_Project.DAL d = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbExerciseForScott1;Integrated Security=SSPI");
               d.AddParam("@UserName", txtUserName.Text);//@UserName will compare value txtUserName.Text
               d.AddParam("@Password", txtPassword.Text);//@Password will compare value txtPassword.Text
               ds = d.ExecuteProcedure("spLogin");
               

               if (ds.Tables[0].Rows.Count > 0)
               {
                   lbnUser.Visible = true;
                   Session["UserID"] = ds.Tables[0].Rows[0]["UserID"].ToString();
                   Session["AccessLevel"] = ds.Tables[0].Rows[0]["AccessLevel"].ToString();
                   Session["UserName"] = ds.Tables[0].Rows[0]["UserName"].ToString();
                   Session["Password"] = ds.Tables[0].Rows[0]["Password"].ToString();
                                      

                   if (Session["AccessLevel"].ToString() == "2")
                   {
                       lbnAdmin.Visible = true;
                       lbnUser.Visible = false;
                   }

                   if (chxStaySignedIn.Checked)
                   {
                       HttpCookie myCookieAdm = new HttpCookie("StaySignedInUserID");
                       myCookieAdm.Value = Session["UserID"].ToString();
                       myCookieAdm.Expires = DateTime.Now.AddDays(2);
                       Response.Cookies.Add(myCookieAdm);

                       HttpCookie myCookieReg = new HttpCookie("StaySignedInSecurityLevel");
                       myCookieReg.Value = Session["SecurityAccessLevel"].ToString();
                       myCookieReg.Expires = DateTime.Now.AddDays(2);
                       Response.Cookies.Add(myCookieReg);
                   }
               }

               else
               {
                   lblErrorSignIn.Text = "INCORRECT USERNAME AND PASSWORD!";
               }
               lblYouAre.Text = "Welcome " + txtUserName.Text;
               pnlSignedOut.Visible = true;
               pnlSignedIn.Visible = false;
               
            }

        protected void btnSignOut_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            pnlSignedIn.Visible = true;
            pnlSignedOut.Visible = false;
            lbnAdmin.Visible = false;
            lbnUser.Visible = false;
            Response.Redirect("LoginPage.aspx");

            HttpCookie cookieAdm = Request.Cookies["StaySignedInAdm"];
            HttpCookie cookieReg = Request.Cookies["StaySignedInReg"];
            if (cookieAdm != null)
            {
                cookieAdm.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookieAdm);
            }
            if (cookieReg != null)
            {
                cookieReg.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookieReg);
            }
        }
        }
    }
