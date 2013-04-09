<%@ Page Language="C#" AutoEventWireup="true" CodeFile="score.aspx.cs" Inherits="score" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Fraction Quiz Score</title>
    <link href="Styles/quiz.css" rel="stylesheet" type="text/css" />
</head>
<body id="score">
    <section ID="super">
        <form id="form1" runat="server">
            <section ID="paneLabelScore">
                <section ID="center">
                    <asp:Label ID="lblScore" runat="server" Text="Your Score!"></asp:Label>
                    <asp:Label ID="lblScoreScore" runat="server" Text="Label"></asp:Label>
                    <asp:Label ID="lblScorePuntuation" runat="server" Text="Label"></asp:Label>
                    <asp:Button ID="btnRestart2" runat="server" Text="Restart!" 
                    onclick="btnRestart_Click"></asp:Button>
                </section>                
            </section>
        </form>
    </section>
</body>
</html>
