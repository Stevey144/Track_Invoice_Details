<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="AddCustomer.aspx.vb" Inherits="Track_Invoiced_Details.AddCustomer" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Customer</title>
    <link rel="stylesheet" href="assets/css/main.css" />
    <link rel="stylesheet" href="assets/css/Global.css" />
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManger1" runat="server" EnablePartialRendering="true" AsyncPostBackTimeout="360000">
        </asp:ScriptManager>

        <div style="margin: 0 auto; width: 680px;">
            <div class="head">ADD NEW CUSTOMER</div>
            <table>
                <tr>
                    <td align="right"><b>Customer Name:</b></td>
                    <td>
                        <asp:TextBox ID="txtCustomerName" runat="Server" />
                        <asp:Label ID="lblValidateMessage" runat="server" />
                    </td>
                      
                    <td>
                        <asp:Button Text="ADD" runat="server" OnClick="btn_AddCustomer_Click" /></td>
                </tr>
            </table>

        </div>

        <asp:ModalPopupExtender ID="AddCustomerPopUp"
            BehaviorID="mpe1"
            runat="server"
            PopupControlID="pnlPopup"
            TargetControlID="hdCardRequest"
            BackgroundCssClass="modalBackground" />

        <asp:HiddenField ID="hdCardRequest" runat="server" />
        <asp:Panel ID="pnlPopup" runat="server" CssClass="confirm-dialog">
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <div class="modal-dialog" role="document" style="border: 2px solid #2aa85e; background-color: #f2f3f2; height: 100%; width: 800px;">
                        <div class="modal-content" style="width: 700px; margin: 0 auto;">
                            <br />
                            <div class="modal-header">
                                <%--<h3>Details Test Case</h3>--%>
                                <asp:Label ID="lblDetailsTestCase" runat="server" Text="" />
                            </div>
                            <hr />
                            <div class="modal-body">
                                <center>
                                    <h2>
                                        <asp:Label ID="lblMessage" runat="server" Text="" /></h2>
                                </center>

                            </div>

                            <div class="modal-footer">
                                <center>
                                    <asp:Button ID="btClose" class="btn btn-danger" runat="server" Text="Close" OnClick="btClose_Click" />
                                    <br />
                                </center>

                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
        </asp:Panel>
        <!--Modal End-->
        <asp:HiddenField runat="server" ID="hdError" />
    </form>

</body>
</html>
