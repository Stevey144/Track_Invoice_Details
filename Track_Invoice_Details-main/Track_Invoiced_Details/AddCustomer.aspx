<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AddCustomer.aspx.vb" Inherits="Track_Invoiced_Details.AddCustomer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
       <title>Add Customer</title>
        <link rel="stylesheet" href="assets/css/main.css" />
        <link rel="stylesheet" href="assets/css/Global.css" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="margin:0 auto;width:680px;">
            <div class="head">ADD NEW CUSTOMER</div>
            <table>
                   <tr>
                       <td align="right"><b>Customer Name:</b></td>
                       <td><asp:TextBox ID="txtCustomerName"  RunAt="Server" /></td>
                       <td><asp:Button Text="ADD" runat="server"  OnClick="btn_AddCustomer_Click"/></td>
                  </tr> 
            </table>
         <asp:label id="lblMessage" runat="server"  text=""/>
        </div>
    </form>
</body>
</html>
