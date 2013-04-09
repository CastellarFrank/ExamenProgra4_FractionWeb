using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using FractionQuiz;
using Fracciones;
using System.Drawing;

public partial class Quiz : System.Web.UI.Page
{
    FractionQuiz.Quiz quiz;
    int counter;
    bool finalizado;
    bool called;
    bool[] arrayImage;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if ((Request.Params["__EVENTTARGET"] != null) && (Request.Params["__EVENTARGUMENT"] != null))
        {
            if ((Request.Params["__EVENTTARGET"] == this.btnFinish.UniqueID) && (Request.Params["__EVENTARGUMENT"] == "finish"))
            {
                ViewState["finalizado"]=true;
            }
        }
        
        if (!IsPostBack)
        {
            
            finalizado = false;
            called = false;
            string cant = Request.QueryString["cant"];
            quiz = new FractionQuiz.Quiz(int.Parse(cant));
            quiz.generarRandoms();
            this.showInfo();
            arrayImage=new bool[quiz.cantidad];
            for (int i = 0; i < quiz.cantidad; i++)
                arrayImage[i] = false;
            ViewState.Add("listResults", quiz.userResults.ToArray());
            ViewState.Add("listOperacion", quiz.operaciones.ToArray());
            ViewState.Add("counter",counter);
            ViewState.Add("cantidad", quiz.cantidad);
            ViewState.Add("finalizado",finalizado);
            ViewState.Add("called",called);
            ViewState.Add("arrayImage", arrayImage);
            Debug.WriteLine("Not PostBack " + counter + " " + quiz.cantidad+" "+finalizado);
        }
        else
        {
            int cant=(int)ViewState["cantidad"];
            quiz=new FractionQuiz.Quiz(cant);
            arrayImage=new bool[cant];
            quiz.operaciones =new List<Operacion>((Operacion[])ViewState["listOperacion"]);
            quiz.userResults= new List<Fraccion>((Fraccion[])ViewState["listResults"]);
            this.counter=(int)ViewState["counter"];
            this.finalizado=(bool)ViewState["finalizado"];
            this.called = (bool)ViewState["called"];
            Debug.WriteLine("Yes PostBack " + counter + " " + quiz.cantidad + " " + finalizado);
            if (finalizado)
                finishProperties();
        }

    }
    protected void btnIzquierdo_Click(object sender, EventArgs e)
    {
        this.saveInfo();

        if (this.counter > 0)
        {
            this.counter--;
            ViewState["counter"] = counter;
            Debug.WriteLine("BtnSalida"+counter);
            this.showInfo();

        }
            
        
    }
    protected void btnDerecho_Click(object sender, EventArgs e)
    {
        
        this.saveInfo();
        if (this.counter < this.quiz.cantidad - 1)
        {
            this.counter++;
            ViewState["counter"] = counter;
            Debug.WriteLine("BtnSalida" + counter);
            this.showInfo();
        }
        
        
    }
    private void saveInfo()
    {
        Debug.WriteLine("SaveInfo");
        if (this.txtNum.Text != "" && this.txtDenom.Text != "")
        {
            if (this.finalizado)
                return;
            int num = Convert.ToInt32(this.txtNum.Text);
            int denom = Convert.ToInt32(this.txtDenom.Text);
            Fraccion temp = new Fraccion(num, denom);
            this.quiz.insertResult(this.counter, temp);
            Debug.WriteLine("Insertado");
            ViewState["listResults"] = quiz.userResults.ToArray();

        }
        
    }
    private void showInfo()
    {
        Operacion tempOp = quiz.getOperacion(this.counter);
        this.lblOperationNumber.Text = "Operation N# " + (this.counter + 1) + " of " + this.quiz.cantidad;
        this.lblNum1.Text = Convert.ToString(tempOp.F1.Numerador);
        this.lblNum2.Text = Convert.ToString(tempOp.F2.Numerador);
        this.lblDenom1.Text = Convert.ToString(tempOp.F1.Denominador);
        this.lblDenom2.Text = Convert.ToString(tempOp.F2.Denominador);
        this.lblSimbol.Text = Convert.ToString(tempOp.Operador);
        Fraccion val = this.quiz.getResult(this.counter);
        if (val.Inserted)
        {
            Debug.WriteLine("Si entra mostrar"+val.Numerador+" "+val.Denominador);
            this.txtNum.Text = val.Numerador.ToString();
            this.txtDenom.Text = val.Denominador.ToString();
        }
        else
        {
            Debug.WriteLine("Limpieza no entra");
            this.txtNum.Text="";
            this.txtDenom.Text="";
        }
        this.setImage();
    }

    protected override void Render(HtmlTextWriter writer)
    {
        Page.ClientScript.RegisterForEventValidation(this.btnFinish.UniqueID,"finish");
        // and so on
        base.Render(writer);
    }
    private void finishProperties()
    {
        this.txtNum.Enabled = false;
        this.txtDenom.Enabled = false;
        this.btnScore.Visible = true;
        this.btnFinish.Visible = false;
        this.lblCorrectAnswer.Visible = true;
        this.correctImage.Visible = true;
        if (!called)
        {
            this.checkAnswers();
            this.showInfo();
            ViewState["called"] = true;
        }
        
    }
    private void setImage()
    {
        if (this.finalizado)
        {
            this.arrayImage = (bool[])ViewState["arrayImage"];
            string value = "";
            if (this.arrayImage[this.counter])
            {
                this.correctImage.ImageUrl = "~/img/Correcto.png";
                value = "You answered correctly";
                this.lblCorrectAnswer.ForeColor = Color.DarkBlue;
            }
            else
            {
                this.correctImage.ImageUrl = "~/img/Incorrecto.png";
                this.lblCorrectAnswer.ForeColor = Color.Red;
                value = "The right answer was: " + this.quiz.getOperacion(this.counter).Result.ToString();
            }
            this.lblCorrectAnswer.Text = value;
        }
    }

    private void checkAnswers()
    {
        int cantResult = 0;
        for (int i = 0; i < this.quiz.cantidad; i++)
        {
            Fraccion temp = this.quiz.getOperacion(i).Result;
            if (temp.esIgual(this.quiz.getResult(i)))
            {
                this.arrayImage[i] = true;
                cantResult++;
            }
        }
        ViewState["arrayImage"]=arrayImage;
        ViewState.Add("cantResult",cantResult);
    }
    protected void btnScore_Click(object sender, EventArgs e)
    {
        int cantResult=(int)ViewState["cantResult"];
        double score = ((double)cantResult) / ((double)quiz.cantidad) * 100;
        int intScore = (int)score;
        Session.Add("score",intScore);
        Session.Add("cantResult", cantResult);
        Session.Add("cantidad",quiz.cantidad);
        Response.Redirect("~/score.aspx");
    }
}