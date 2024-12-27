using Dapper;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Services;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

namespace Partner_Management
{
    public partial class Default : System.Web.UI.Page
    {
        private int? newPolicy_Partner_ID
        {
            get { return ViewState["newPolicy_Partner_ID"] == null ? null : (int?)Int32.Parse(ViewState["newPolicy_Partner_ID"].ToString()); }
            set { ViewState["newPolicy_Partner_ID"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getAndBindPartners();

            }
 
        }
        
       
        protected void getAndBindPartners()
        {

            var connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["PartnerManagementDBconnString"].ConnectionString);
            var sql = @"SELECT p.Partner_ID,
                           p.FirstName,
                           p.LastName,
                           p.PartnerNumber,
                           p.CroatianPIN,
                           p.CreatedAtUTC,
                           p.IsForeign,
                           p.Gender,       
                           p.PartnerType_ID,
                           pt.TypeName,
						   IsMarked = (SELECT CASE WHEN EXISTS(SELECT * FROM (SELECT count(*) as PolicyCount,SUM(PolicyAmount) AS SUMPolicyAmount FROM Policy plc WHERE plc.Partner_ID = p.Partner_ID) a  WHERE PolicyCount > 5 OR SUMPolicyAmount >5000) THEN 1 ELSE 0 END)
                        FROM Partner p INNER JOIN PartnerType pt ON p.PartnerType_ID = pt.PartnerType_ID
                        ORDER BY p.CreatedAtUTC DESC";
            var partners = connection.Query<Partner, PartnerType,Int32, Wrapper_Partner_PartnerType> (sql,
                     (c1, c2,c3) =>
                     {
                         return new Wrapper_Partner_PartnerType { Partner = c1, PartnerType = c2,IsMarked=Convert.ToBoolean(c3) };
                     },
                     splitOn: "PartnerType_ID,IsMarked"
                     ).AsQueryable();

            rptPartners.DataSource = partners;
            rptPartners.DataBind();
        }



        protected void btnPartnersDetails_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;

            var connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["PartnerManagementDBconnString"].ConnectionString);
            var sql = @"SELECT p.Partner_ID,
                           p.FirstName,
                           p.LastName,
                           p.PartnerNumber,
                           p.CroatianPIN,
                           p.CreatedAtUTC,
                           p.IsForeign,
                           p.Address,
                           p.CreatedByUser,
                           p.ExternalCode,
                           p.Gender,       
                           p.PartnerType_ID,
                           pt.TypeName    
                        FROM Partner p INNER JOIN PartnerType pt ON p.PartnerType_ID = pt.PartnerType_ID
                        WHERE p.Partner_ID = @Partner_ID
                        ORDER BY p.CreatedAtUTC DESC";
            var parameters = new DynamicParameters(new { ProductId = 1 });
            var partners = connection.Query<Partner, PartnerType, Wrapper_Partner_PartnerType>(sql,
                     (c1, c2) =>
                     {
                         return new Wrapper_Partner_PartnerType { Partner = c1, PartnerType = c2 };
                     },
                     splitOn: "PartnerType_ID",
                     param: new { Partner_ID = Int32.Parse(btn.CommandArgument) }
                     ).AsQueryable();

            rptPartnersDetails.DataSource = partners;
            rptPartnersDetails.DataBind();

            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#partnerDetailsModal').modal('show')", true);
        }

        protected void ViewPolicies_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            var connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["PartnerManagementDBconnString"].ConnectionString);
            var sql = @"SELECT  p.Policy_ID,
                            p.PolicyNumber,
                            p.PolicyAmount
                        FROM Policy p 
                        WHERE p.Partner_ID = @Partner_ID
                        ORDER BY p.PolicyNumber DESC";

            var policies = connection.Query<Policy>(sql,
                     param: new
                     {
                         Partner_ID = Int32.Parse(btn.CommandArgument)
                     }
                     ).AsQueryable();

            rptPoliciesView.DataSource = policies;
            rptPoliciesView.DataBind();



            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#policiesViewModal').modal('show')", true);

        }

        protected void AddNewPolicy_Click(object sender, EventArgs e)
        {
            LinkButton btn = (LinkButton)sender;
            newPolicy_Partner_ID = Int32.Parse(btn.CommandArgument);
            lblTitle_AddNewPolicyModal.Visible = true;
            divPolicyAmount.Visible = true;
            divPolicyNumber.Visible = true;
            valid_tbPolicyAmount.Visible = false;
            valid_tbPolicyNumber.Visible = false;
            savePolicy.Visible = true;
            lblSuccess.Visible = false;
            ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#addNewPolicy').modal('show')", true);

        }


        protected void AddNewPartner_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddPartner");
        }

        protected void savePolicy_Click(object sender, EventArgs e)
        {
            bool isValid = true;
            if (!SharedMethods.IsDigitsOnly(tbPolicyNumber.Text) || (!(tbPolicyNumber.Text.Length >= 10) || !(tbPolicyNumber.Text.Length <= 15)))
            {

                valid_tbPolicyNumber.Visible = true;
                isValid = false;
            }
            else
            {
                valid_tbPolicyNumber.Visible = false;

            }
            if (!decimal.TryParse(tbPolicyAmount.Text, out decimal res) || !(res >= 0))
            {
                valid_tbPolicyAmount.Visible = true;
                isValid = false;
            }
            else
            {
                valid_tbPolicyAmount.Visible = false;
            }

            if (isValid == false)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#addNewPolicy').modal('show')", true);
            }
            else
            {
                using (var connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["PartnerManagementDBconnString"].ConnectionString))
                {
                    var sql = @"INSERT INTO Policy (PolicyNumber,PolicyAmount,Partner_ID) VALUES (@PolicyNumber, @PolicyAmount, @Partner_ID)";
                   
                        var policy = new Policy() { Partner_ID = (int)newPolicy_Partner_ID, PolicyNumber = tbPolicyNumber.Text,PolicyAmount=decimal.Parse(tbPolicyAmount.Text) };
                        var rowsAffected = connection.Execute(sql, policy);
                }


                divPolicyAmount.Visible = false;
                divPolicyNumber.Visible = false;
                lblTitle_AddNewPolicyModal.Visible = false;
                savePolicy.Visible = false;
                lblSuccess.Visible = true;
                tbPolicyAmount.Text = string.Empty;
                tbPolicyNumber.Text = string.Empty;
                ClientScript.RegisterStartupScript(this.GetType(), "Popup", "$('#addNewPolicy').modal('show')", true);
            }
        }


        [WebMethod]
        public static List<int> CheckPolicyCountAndAmount()
        {
            var connection = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["PartnerManagementDBconnString"].ConnectionString);
            var sql = @"SELECT Partner_ID
                        FROM(SELECT Partner_ID,count(*) as PolicyCount,SUM(PolicyAmount) AS SUMPolicyAmount FROM Policy GROUP BY (Partner_ID)) a
                        WHERE a.PolicyCount > 5 OR SUMPolicyAmount > 5000
                        ";

           return connection.Query<int>(sql).ToList();
        }

       
    }
}