﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NAV
{


    // additional comments
    public partial class NAV : System.Web.UI.MasterPage
    {
        string sourcePage = "/report/portfoliodetails.asp"; //--->temporary!
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session.Contents.Count != 0)
            {
                //Response.Write(Session.Contents.Count.ToString());
                foreach (string key in Session.Keys)
                {
                    //Response.Write(key + " - " + Session[key].ToString() + "<br />");
                }
            }
            else
            {
                //Response.Redirect("https://" + Request.ServerVariables["SERVER_NAME"] + ":" + Request.ServerVariables["SERVER_PORT"] + "/report/" + sourcePage);
                Response.Redirect("https://" + Request.ServerVariables["SERVER_NAME"] + ":" + Request.ServerVariables["SERVER_PORT"] + sourcePage);
            }
        }

        protected void btnBack_Classic_Click(object sender, EventArgs e)
        {
            if (Session["SourcePage"] != null)
            {
                sourcePage = Session["SourcePage"].ToString();
            }
            Session["SourcePage"] = null;
            //throw new Exception("https://" + Request.ServerVariables["SERVER_NAME"] + ":" + Request.ServerVariables["SERVER_PORT"] + sourcePage);
            Response.Redirect("https://" + Request.ServerVariables["SERVER_NAME"] + ":" + Request.ServerVariables["SERVER_PORT"] + sourcePage);
        }
    }
}
