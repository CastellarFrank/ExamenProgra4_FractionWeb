<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Quiz.aspx.cs" Inherits="Quiz" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Fraction Quiz Online</title>
    <link href="Styles/quiz.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/jquery-1.4.1.min.js" type="text/javascript"></script>
    <script src="Scripts/apprise-1.5.min.js" type="text/javascript"></script>
    <link href="Styles/apprise.min.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function restart(variable) {
            if (variable) {
                location.href = "Default.aspx";
            }
        }
        function finish(variable) {
            if(variable)
                __doPostBack('<%= btnFinish.UniqueID %>', 'finish');
        }
        function askRestart() {
            apprise("Do you really want to restart the quiz?",
             { 'verify': true, 'textYes': 'Yes, I do', 'textNo': 'No, I dont' }, function (r) {
                 restart(r);
             });
        };
        function __doPostBack(eventTarget, eventArgument) {
            if (!theForm.onsubmit || (theForm.onsubmit() != false)) {
                theForm.__EVENTTARGET.value = eventTarget;
                theForm.__EVENTARGUMENT.value = eventArgument;
                theForm.submit();
            }
        }

        function ask() {
            apprise("Do you really want to finish?",
             { 'verify': true, 'textYes': 'Yes, I do', 'textNo': 'No, I dont' }, function (r) {
                 finish(r);
             });
        };
    </script>
</head>
<body>
    <section id="super">
        <form id="form1" runat="server">
            <section ID="paneTitle">
                <asp:Label ID="lblTitle" runat="server" Text="Fraction Quiz"></asp:Label>
            </section>
            <section ID="panelTextOperation">
                <asp:Label ID="lblOperationNumber" runat="server" Text="The Operation N#  00 of 00"></asp:Label>
            </section>
            <section ID="Principal">
                <section ID="panelBtnIzquierdo">
                    <asp:Button ID="btnIzquierdo" runat="server" Text="Back" 
                                onclick="btnIzquierdo_Click">
                    </asp:Button>
                </section>
                <section ID="Izquierdo">
                    <asp:Label ID="lblNum1" runat="server" Text="00" Font-Bold="True"></asp:Label>
                    <br />
                    <asp:Label ID="lblGuion1" runat="server" Text="-----" Font-Bold="True"></asp:Label>
                    <br />
                    <asp:Label ID="lblDenom1" runat="server" Text="00" Font-Bold="True"></asp:Label>
                </section>
                <section id="Simbol">
                    <asp:Label ID="lblSimbol" runat="server" Text=" + " Font-Bold="True"></asp:Label>
                </section>
                <section ID="Medio">
                    <asp:Label ID="lblNum2" runat="server" Text="00" Font-Bold="True"></asp:Label>
                    <br />
                    <asp:Label ID="lblGuion2" runat="server" Text="-----" Font-Bold="True"></asp:Label>
                    <br />
                    <asp:Label ID="lblDenom2" runat="server" Text="00" Font-Bold="True"></asp:Label>                
                </section>
                <section id="Simbol2">
                    <asp:Label ID="lblSimbol2" runat="server" Text=" = " Font-Bold="True"></asp:Label>
                </section>
                <section ID="Derecho">
                    <asp:TextBox ID="txtNum" runat="server" Font-Bold="True" Width="52px"></asp:TextBox>
                    <br />                  
                    <asp:Label ID="lblGuion3" runat="server" Text="-----" Font-Bold="True"></asp:Label>
                    <br />
                    <asp:TextBox ID="txtDenom" runat="server" Font-Bold="True" Width="52px"></asp:TextBox>
                </section>
                <section ID="panelBtnDerecho">
                    <asp:Button ID="btnDerecho" runat="server" Text="Next" 
                    onclick="btnDerecho_Click"></asp:Button>
                </section>
                <section ID="paneErrors">
                    <asp:CompareValidator ID="CompareValidator1" 
                        runat="server" 
                        ErrorMessage="X" 
                        ForeColor="Red" 
                        ControlToValidate="txtNum"  
                        ValueToCompare="0"
                        Operator="DataTypeCheck"
                        Type="Integer" 
                        ToolTip="The numerator must to be a number"
                    />
                    <asp:CompareValidator ID="CompareValidator4" 
                        runat="server" 
                        ErrorMessage="X" 
                        ForeColor="Red" 
                        ControlToValidate="txtNum" 
                        ValueToCompare="0"
                        Operator="NotEqual"
                        Type="Integer" 
                        ToolTip="The numerator can't be zero"
                    />
                    <asp:CompareValidator ID="CompareValidator2" 
                        runat="server" 
                        ErrorMessage="X" 
                        ForeColor="Red" 
                        ControlToValidate="txtDenom" 
                        ValueToCompare="0"
                        Operator="DataTypeCheck"
                        Type="Integer" 
                        ToolTip="The denominator must to be a number"
                    />
                    <asp:CompareValidator ID="CompareValidator3" 
                        runat="server" 
                        ErrorMessage="X" 
                        ForeColor="Red" 
                        ControlToValidate="txtDenom" 
                        ValueToCompare="0"
                        Operator="NotEqual"
                        Type="Integer" 
                        ToolTip="The denominator can't be zero"
                    />
                    <asp:CompareValidator ID="CompareValidator5" 
                        runat="server" 
                        ErrorMessage="X" 
                        ForeColor="Red" 
                        ControlToValidate="txtDenom" 
                        ValueToCompare="0"
                        Operator="GreaterThan"
                        Type="Integer" 
                        ToolTip="The denominator must to be greater than zero"
                    />
                </section>
                <section ID="PanelLabelFinish">
                    <asp:Label ID="lblCorrectAnswer" runat="server" Text="This is just a test" Visible="false"></asp:Label>
                    <asp:Image ID="correctImage" runat="server" Visible="false"></asp:Image>
                </section>
                <section ID="panelFinish">
                    <asp:Button ID="btnFinish" runat="server" Text="Finish!" OnClientClick="ask(); return false;"></asp:Button>
                    <asp:Button ID="btnRestart" runat="server" Text="Reiniciar" OnClientClick="askRestart(); return false;"></asp:Button>
                    <asp:Button ID="btnScore" runat="server" Text="View Score" 
                Visible="false" onclick="btnScore_Click"></asp:Button>
                </section>
            </section> 
        </form>
    </section>
</body>
</html>
