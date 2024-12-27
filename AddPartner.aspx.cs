using Dapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net.Mail;
using System.ComponentModel.DataAnnotations;

namespace Partner_Management
{
    public partial class AddPartner : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["PartnerManagementDBconnString"].ConnectionString);
                var sql = @"SELECT  pt.PartnerType_ID,
                                    pt.TypeName
                                    FROM PartnerType pt";

                var partnerType = connection.Query<PartnerType>(sql).AsQueryable();
                ddlPartnerType.DataValueField = "PartnerType_ID";
                ddlPartnerType.DataTextField = "TypeName";
                ddlPartnerType.DataSource = partnerType; ddlPartnerType.DataBind();
            }
        }

        protected void cbIsForeign_CheckedChanged(object sender, EventArgs e)
        {
            if (((CheckBox)sender).Checked)
            {
                divForeigner.Visible = false;
            }
            else
            {
                divForeigner.Visible = true;
            }
        }

        protected void btnAddPartner_Click(object sender, EventArgs e)
        {
            bool isValid = true;

            if (String.IsNullOrWhiteSpace(tbFirstName.Text))
            {
                isValid = false;
                lblValidFirstName.Text = "This field cannot be empty!";
                lblValidFirstName.Visible = true;
            }
            if (String.IsNullOrWhiteSpace(tbLastName.Text))
            {
                isValid = false;
                lblValidLastName.Text = "This field cannot be empty!";
                lblValidLastName.Visible = true;
            }


            if (String.IsNullOrWhiteSpace(tbPartnerNumber.Text))
            {
                isValid = false;
                lblValidPartnerNumber.Text = "This field cannot be empty!";
                lblValidPartnerNumber.Visible = true;
            }
            else if (!SharedMethods.IsDigitsOnly(tbPartnerNumber.Text) || tbPartnerNumber.Text.Length != 20)
            {
                isValid = false;
                lblValidPartnerNumber.Text = "Has to consist of exactly 20 numbers!";
                lblValidPartnerNumber.Visible = true;
            }
            else
            {
                lblValidPartnerNumber.Visible = false;
            }


            if (!cbIsForeign.Checked)
            {
                if (String.IsNullOrWhiteSpace(tbCroatianPIN.Text))
                {
                    isValid = false;
                    lblValidCroatianPIN.Text = "This field cannot be empty!";
                    lblValidCroatianPIN.Visible = true;
                }
                else if (!SharedMethods.IsDigitsOnly(tbCroatianPIN.Text) || tbCroatianPIN.Text.Length != 11)
                {
                    isValid = false;
                    lblValidCroatianPIN.Text = "Has to consist of exactly 11 numbers!";
                    lblValidCroatianPIN.Visible = true;
                }
                else
                {
                    lblValidCroatianPIN.Visible = false;
                }
            }
            else
            {
                lblValidCroatianPIN.Visible = false;
            }




            if (String.IsNullOrWhiteSpace(tbExternalCode.Text))
            {
                isValid = false;
                lblValidExternalCode.Text = "This field cannot be empty!";
                lblValidExternalCode.Visible = true;
            }
            else if (!SharedMethods.IsDigitsOnly(tbExternalCode.Text) || (tbExternalCode.Text.Length < 10 || tbExternalCode.Text.Length > 20))
            {
                isValid = false;
                lblValidExternalCode.Text = "Has to be in range of 10 to 20 numbers only!";
                lblValidExternalCode.Visible = true;
            }
            else if (ExternalCodeExists(tbExternalCode.Text))
            {
                isValid = false;
                lblValidExternalCode.Text = "This code already exists! Has to be unique!";
                lblValidExternalCode.Visible = true;
            }
            else
            {
                lblValidExternalCode.Visible = false;
            }

            if (String.IsNullOrWhiteSpace(tbCreatedByUser.Text))
            {
                isValid = false;
                lblValidCreatedByUser.Text = "This field cannot be empty!";
                lblValidCreatedByUser.Visible = true;
            }
            else if (!IsMailValid(tbCreatedByUser.Text))
            {
                isValid = false;
                lblValidCreatedByUser.Text = "Email is not valid!";
                lblValidCreatedByUser.Visible = true;
            }
            else
            {
                lblValidCreatedByUser.Visible = false;
            }

            if(isValid)
            {
                using (var connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["PartnerManagementDBconnString"].ConnectionString))
                {
                    var sql = @"INSERT INTO [dbo].[Partner]
                                                 ([FirstName]
                                                 ,[LastName]
                                                 ,[Address]
                                                 ,[PartnerNumber]
                                                 ,[CroatianPIN]
                                                 ,[PartnerType_ID]
                                                 ,[CreatedByUser]
                                                 ,[IsForeign]
                                                 ,[ExternalCode]
                                                 ,[Gender])
                                        VALUES
                                                 (@FirstName
                                                 ,@LastName
                                                 ,@Address
                                                 ,@PartnerNumber
                                                 ,@CroatianPIN
                                                 ,@PartnerType_ID
                                                 ,@CreatedByUser
                                                 ,@IsForeign
                                                 ,@ExternalCode
                                                 ,@Gender)
                                                 ";
                    Partner partner = new Partner();
                    partner.FirstName = tbFirstName.Text;
                    partner.LastName = tbLastName.Text;
                    if (!string.IsNullOrWhiteSpace(tbAddress.Text)) { partner.Address = tbAddress.Text; }
                    partner.PartnerNumber = tbPartnerNumber.Text;
                    if(!cbIsForeign.Checked)partner.CroatianPIN = tbCroatianPIN.Text;
                    partner.PartnerType_ID = Int32.Parse(ddlPartnerType.SelectedValue);
                    partner.CreatedByUser = tbCreatedByUser.Text; 
                    partner.IsForeign = cbIsForeign.Checked;
                    partner.ExternalCode = tbExternalCode.Text;
                    partner.Gender = Convert.ToChar(ddlGender.SelectedValue);
                    var rowsAffected = connection.Execute(sql, partner);
                }



                Response.Redirect("Default?NewPartnerAdded=true", true);
            }
        }

        private bool ExternalCodeExists(string ExternalCode)
        {
            var connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["PartnerManagementDBconnString"].ConnectionString);
            var sql = @"SELECT ex = (CASE WHEN EXISTS(SELECT Partner_ID FROM Partner Where ExternalCode = @ExternalCode) THEN 1 ELSE 0 END)";
            dynamic res = connection.Query(sql, param: new { ExternalCode = ExternalCode }).SingleOrDefault();
            return Convert.ToBoolean(res.ex);
        }
        private bool IsMailValid(string email)
        {
            var trimmedEmail = email.Trim();

            if (trimmedEmail.EndsWith("."))
            {
                return false;
            }
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == trimmedEmail;
            }
            catch
            {
                return false;
            }
        }
    }
}