using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Exercise4Scott1
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
            if (Session["UserID"] == null)
            {
                Response.Redirect("LoginPage.aspx");
            }
            pnlLogFields.Visible = false;
            try
            {
               
                if (!IsPostBack)
                {
                    BindData();//binds data if not a postback 
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Opps, Something went wrong, Please try again later " + ex.Message;//Something goes wrong this label appears
            }
        }

        private void BindData()
        {
            DAL_Project.DAL d = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbExerciseForScott1;Integrated Security=SSPI");
            DataSet ds = new DataSet();
            LoginGridView.DataSource = d.ExecuteProcedure("spLoginSelect");
            LoginGridView.DataBind();
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            if (txtloginID.Text == "")// if no LoginId is in the textbox...
            {
                lblError.Text = "Please select a Log first!";//the label with say this
            }
            else//but if there is a LoginId in the textbox...
            {
                pnlEditDelete.Visible = false;//Off
                DAL_Project.DAL dal = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbExerciseForScott1;Integrated Security=SSPI");
                DataSet ds = new DataSet();
                dal.ExecuteProcedure("spLoginSelect");
                pnlLogFields.Visible = true;//On
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                DAL_Project.DAL dal = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbExerciseForScott1;Integrated Security=SSPI");
                dal.AddParam("@LoginID", txtloginID.Text);
                dal.ExecuteProcedure("spLoginDelete");
                Clearfields();//Clears all the fields
                BindData();//binds the data
                
            }
            catch (Exception ex)
            {
                lblError.Text = "Opps, Something went wrong " + ex.Message;//if something goes wrong this will fire
            }
        }

        private void Clearfields()
        {
            txtloginID.Text = "";
            txtuserName.Text = "";
            txtloginSuccess.Text = "";
            txtlogDate.Text = "";
        }



        //fills the fields from the database to the text boxes
        private void FillFields(DataSet ds)
        {
            txtloginID.Text = ds.Tables[0].Rows[0]["LoginID"].ToString();
            txtuserName.Text = ds.Tables[0].Rows[0]["UserName"].ToString();
            txtloginSuccess.Text = ds.Tables[0].Rows[0]["LoginSuccessful"].ToString();
            txtlogDate.Text = ds.Tables[0].Rows[0]["LogDate"].ToString();
           
        }
        //When the Select is clicked, enables the fields to be filled, fills the fields, clears the error label if needed
        protected void LoginGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LoginGridView.SelectedIndex = Convert.ToInt32(e.CommandArgument.ToString());
            int LoginID = Convert.ToInt32(LoginGridView.SelectedValue.ToString());

            if (e.CommandName == "Select Log")// if the Select Button is clicked on the GridView
            {
                DAL_Project.DAL dal = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbExerciseForScott1;Integrated Security=SSPI");
                DataSet ds = new DataSet();
                ds = dal.ExecuteProcedure("spLoginSelect");
                FillFields(ds);//Fills all the fields
                SetEnabled(true);//Enables the fields to be filled

                pnlLogFields.Visible = true;//makes all the fields visible
                txtloginID.Text = LoginGridView.SelectedRow.Cells[1].Text;//will input data from the corresponding cell in the database to the textbox
                txtuserName.Text = LoginGridView.SelectedRow.Cells[2].Text;//will input data from the corresponding cell in the database to the textbox
                txtloginSuccess.Text = LoginGridView.SelectedRow.Cells[3].Text;//will input data from the corresponding cell in the database to the textbox
                txtlogDate.Text = LoginGridView.SelectedRow.Cells[4].Text;//will input data from the corresponding cell in the database to the textbox
                lblError.Text = "";//if the lblError was fired will clear the message
            }
            BindData();
        }

        private void SetEnabled(bool bEnabled)
        {
            txtloginID.Enabled = bEnabled;
            txtuserName.Enabled = bEnabled;
            txtloginSuccess.Enabled = bEnabled;
            txtlogDate.Enabled = bEnabled;
        }
        //Allows paging, splitting the data up into smaller groups 
        //so you go to the next page to see the data, 
        //like a book, instead of seeing all the data on one long page
        protected void LoginGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            DAL_Project.DAL dal = new DAL_Project.DAL(@"Data Source=localhost;Initial Catalog=dbExerciseForScott1;Integrated Security=SSPI");
            LoginGridView.DataSource = dal.ExecuteProcedure("spLoginSelect");
            LoginGridView.PageIndex = e.NewPageIndex;
            LoginGridView.DataBind();
        }

    }
}