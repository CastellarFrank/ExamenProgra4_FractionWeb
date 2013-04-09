using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class score : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        int score=(int)Session["score"];
        int cantResult = (int)Session["cantResult"];
        int cantidad = (int)Session["cantidad"];

        this.lblScoreScore.Text = "Score: " + score;
        this.lblScorePuntuation.Text = "You have "+cantResult+" right answers of "+cantidad;
    }
    protected void btnRestart_Click(object sender, EventArgs e)
    {
        Response.Redirect("~/Default.aspx");
    }
}