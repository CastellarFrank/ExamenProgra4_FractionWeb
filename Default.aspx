<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>Fraction Quiz Online</title>
    <script src="Scripts/myScripts.js" type="text/javascript"></script>
    <script src="Scripts/apprise-1.5.min.js" type="text/javascript"></script>
    <link href="Styles/main.css" rel="stylesheet" type="text/css" />
    <link href="Styles/apprise.min.css" rel="stylesheet" type="text/css" />
  
    <%--<script type="text/javascript">
        function redireccionar() {
            var oForm = document.forms["form1"];
            var otext = oForm.elements["txtOperationCant"];
            location.href = "Quiz.aspx?red="+otext.value+"";
        }        
    </script>--%>
</head>
<body>
	<section id="Main">
		<section id="secondary">
			<a href="Default.aspx">
				<img class="fade" alt="Welcome" src="img/welcome-logo.png"/>
			</a>
			<form id="form1" runat="server">
		        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
		        </asp:ToolkitScriptManager>
		        <asp:UpdatePanel ID="startUpdatePanel" runat="server">
		            <ContentTemplate>
		                <asp:TextBox ID="txtOperationCant" runat="server" Text="10">
		                </asp:TextBox>
                        <br />
                        <asp:CompareValidator ID="CompareValidator1" 
                            ControlToValidate="txtOperationCant"
                            runat="server" 
                            ErrorMessage="You have to enter a number greater than 0" 
                            ForeColor="Red" 
                            ValueToCompare="0" 
                            Type="Integer" 
                            Operator="GreaterThan" Display="Dynamic" />                       
	                    <br />
                        <br />
	                    <asp:Button ID="btnStart" runat="server" Text="Start Quiz" 
                            onclick="btnStart_Click">
	                    </asp:Button>
		            </ContentTemplate>
		        </asp:UpdatePanel>
	    	</form>
	    	<p>     
	    		This is a quiz aplication that you can use for practice the basics operations with fractions,
		        you must to enter the quantity of operation (problems) to resolve.
		    </p>
		</section>
	</section>
    
</body>
</html>
