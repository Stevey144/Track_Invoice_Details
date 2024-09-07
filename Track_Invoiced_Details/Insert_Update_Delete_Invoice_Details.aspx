<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Insert_Update_Delete_Invoice_Details.aspx.vb" Inherits="Track_Invoiced_Details.Insert_Update_Delete_Invoice_Details" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title>Track Invoice Details</title>
    <link rel="stylesheet" href="assets/css/main.css" />
    <link rel="stylesheet" href="assets/css/Global.css" />
</head>

<body>
    <script type="text/javascript">
        function ConfirmDelete() {

            var DeleteRecord = confirm("are you sure you want to delete this Record? you cannot undo this !!");

            if (DeleteRecord) {

                alert("Record deleted Successfully!");

                return true;
            }
            else {
                return false;
            }

        }


    </script>
    <div style="width: 100%">

        <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManger1" runat="server" EnablePartialRendering="true" AsyncPostBackTimeout="360000">
            </asp:ScriptManager>
            <div class="formviewdiv">

                <div class="head">TRACK INVOICE DETAILS</div>
                <asp:Label ID="lblMessage" runat="server" Text="" />

                <table>

                    <tr>
                        <td>
                            <asp:LinkButton runat="server" OnClick="AddCustomer_Click"> <img src="~/images/plus.png" runat="server"/>Add Customer</asp:LinkButton></td>
                    </tr>

                </table>

                <asp:FormView ID="TrackInvoiceDetails_FormView"
                    DataKeyNames="INVOICE_ID"
                    GridLines="Both"
                    AllowPaging="true"
                    AutoGenerateColumns="False"
                    CellPadding="1"
                    CellSpacing="1"
                    PageSize="10"
                    CssClass="table-bordered table-sm"
                    PagerStyle-CssClass="table pgr"
                    AlternatingRowStyle-CssClass="normal11"
                    Width="98%"
                    runat="server"
                    OnItemDeleting="TrackInvoiceDetailsFormView_ItemDeleting"
                    OnPageIndexChanging="TrackInvoiceDetailsFormView_PageIndexChanging"
                    OnItemUpdating="TrackInvoiceDetailsFormView_ItemUpdating"
                    OnItemInserted="TrackInvoiceDetailsFormView_ItemInserted"
                    OnItemInserting="TrackInvoiceDetailsFormView_ItemInserting"
                    OnItemUpdated="TrackInvoiceDetailsFormView_ItemUpdated"
                    OnModeChanging="TrackInvoiceDetailsFormView_ModeChanging">

                    <ItemTemplate>

                        <table>

                            <tr>
                                <td align="right"><b>Invoice ID:</b></td>
                                <td><%# Eval("INVOICE_ID") %></td>
                            </tr>

                            <tr>
                                <td align="right"><b>Invoice Number:</b></td>
                                <td><%# Eval("INVOICE_NUMBER") %></td>
                            </tr>

                            <tr>
                                <td align="right"><b>Invoice Date:</b></td>
                                <td><%# Eval("INVOICE_DATE") %></td>
                            </tr>

                            <tr>
                                <td align="right"><b>Invoice Due Date:</b></td>
                                <td><%# Eval("INVOICE_DUE_DATE")%></td>
                            </tr>

                            <tr>
                                <td align="right"><b>Invoice Description:</b></td>
                                <td><%# Eval("INVOICE_DESCRIPTION")%></td>
                            </tr>

                            <tr>
                                <td align="right"><b>Customer:</b></td>
                                <td><%# Eval("CUSTOMER")%></td>
                            </tr>

                            <tr>
                                <td align="right"><b>Invoice Status:</b></td>
                                <td><%# Eval("INVOICE_STATUS")%></td>
                            </tr>

                            <tr>

                                <td colspan="2">

                                    <asp:LinkButton ID="EditButton"
                                        Text="Edit"
                                        CssClass="btnPrimary"
                                        CommandName="Edit"
                                        runat="server" />

                                    &nbsp;

                       

                                    <asp:LinkButton ID="NewButton"
                                        Text="New"
                                        CssClass="btnPrimary"
                                        CommandName="New"
                                        runat="server" />

                                    &nbsp;

                       

                                    <asp:LinkButton ID="DeleteButton"
                                        Text="Delete"
                                        CssClass="btnDanger"
                                        CommandName="Delete"
                                        OnClientClick="return ConfirmDelete();"
                                        runat="server" />

                                </td>

                            </tr>

                        </table>

                    </ItemTemplate>



                    <EditItemTemplate>

                        <table>

                            <tr>
                                <td align="right"><b>Invoice ID:</b></td>

                                <td>
                                    <asp:TextBox ID="txtInvoiceID"
                                        Text='<%# Bind("INVOICE_ID") %>'
                                        runat="Server" /></td>
                            </tr>





                            <tr>
                                <td align="right"><b>Invoice Number:</b></td>

                                <td>
                                    <asp:TextBox ID="txtInvoiceNumber"
                                        Text='<%# Bind("INVOICE_NUMBER") %>'
                                        runat="Server" /></td>
                            </tr>



                            <tr>
                                <td align="right"><b>Invoice Date:</b></td>


                                <td>
                                    <asp:TextBox ID="txtInvoiceDate"
                                        Text='<%# Bind("INVOICE_DATE") %>'
                                        runat="Server"
                                        AutoPostBack="True" />
                                    <ajaxToolkit:CalendarExtender
                                        runat="server"
                                        ID="txtInvoiceDate_CalendarExtender"
                                        Format="MM/dd/yyyy"
                                        PopupButtonID="ImageButton63"
                                        TargetControlID="txtInvoiceDate"></ajaxToolkit:CalendarExtender>
                                </td>

                                <td>
                                    <asp:ImageButton ID="ImageButton63" ImageUrl="~/images/_calendar.png" Width="30px" runat="server" />
                                </td>
                            </tr>

                            <tr>
                                <td align="right"><b>Invoice Due Date:</b></td>
                                <td>
                                    <asp:TextBox ID="txtInvoiceDueDate"
                                        Text='<%# Bind("INVOICE_DUE_DATE") %>'
                                        runat="Server"
                                        AutoPostBack="True" />
                                    <ajaxToolkit:CalendarExtender
                                        runat="server"
                                        ID="CalendarExtender1"
                                        Format="MM/dd/yyyy"
                                        PopupButtonID="ImageButton1"
                                        TargetControlID="txtInvoiceDueDate"></ajaxToolkit:CalendarExtender>
                                </td>

                                <td>
                                    <asp:ImageButton ID="ImageButton1" ImageUrl="~/images/_calendar.png" Width="30px" runat="server" />
                                </td>
                            </tr>


                            <tr>
                                <td align="right"><b>Invoice Description:</b></td>

                                <td>
                                    <asp:TextBox ID="txtInvoiceDescription"
                                        Text='<%# Bind("INVOICE_DESCRIPTION") %>'
                                        runat="Server" /></td>
                            </tr>

                            <tr>
                                <td align="right"><b>Customer:</b></td>

                                <td>
                                    <asp:DropDownList ID="DropListCustomers" AppendDataBoundItems="true" runat="server" DataSourceID="CustomerDataSource" DataValueField="CUSTOMER" DataTextField="CUSTOMER" required="required" AutoPostBack="true">
                                    </asp:DropDownList></td>
                                <asp:SqlDataSource ID="CustomerDataSource" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:TrackInvoice %>"
                                    SelectCommand="SELECT  [CUSTOMER] FROM inventory.CUSTOMERS"></asp:SqlDataSource>
                            </tr>

                            <tr>
                                <td align="right"><b>Invoice Status:</b></td>
                                <td>
                                    <asp:DropDownList ID="DropDownListInvoiceStatus" runat="server" DataValueField="INVOICE_STATUS" SelectedValue='<%# Bind("INVOICE_STATUS") %>' DataTextField="INVOICE_STATUS">
                                        <asp:ListItem>Outstanding</asp:ListItem>
                                        <asp:ListItem>Paid</asp:ListItem>
                                    </asp:DropDownList>
                                </td>

                            </tr>

                            <tr>
                                <td colspan="2">

                                    <asp:LinkButton ID="UpdateButton"
                                        Text="Update"
                                        CommandName="Update"
                                        CssClass="btnPrimary"
                                        runat="server" />

                                    &nbsp;

                       

                                    <asp:LinkButton ID="CancelUpdateButton"
                                        Text="Cancel"
                                        CssClass="btnPrimary"
                                        CommandName="Cancel"
                                        runat="server" />

                                </td>

                            </tr>

                        </table>

                    </EditItemTemplate>


                    <InsertItemTemplate>

                        <table>

                            <tr>
                                <td align="right"><b>Invoice Number:</b></td>

                                <td>
                                    <asp:TextBox ID="txtInvoiceNumber"
                                        Text='<%# Bind("INVOICE_NUMBER") %>'
                                        runat="Server" /></td>
                            </tr>

                            <tr>
                                <td align="right"><b>Invoice Date:</b></td>

                                <td align="left">
                                    <asp:TextBox ID="txtInvoiceDate"
                                        Text='<%# Bind("INVOICE_DATE") %>'
                                        runat="Server"
                                        AutoPostBack="True"
                                        onfocus='this.blur();' />
                                    <ajaxToolkit:CalendarExtender runat="server"
                                        ID="txtInvoiceDate_CalendarExtender"
                                        Format="MM/dd/yyyy"
                                        PopupButtonID="ImageButton63"
                                        TargetControlID="txtInvoiceDate"></ajaxToolkit:CalendarExtender>

                                </td>
                                <td align="left">
                                    <asp:ImageButton ID="ImageButton63" ImageUrl="~/images/_calendar.png" Width="30px" runat="server" /></td>
                            </tr>

                            <tr>
                                <td align="right"><b>Invoice Due Date:</b></td>
                                <td>
                                    <asp:TextBox ID="txtInvoiceDueDate"
                                        Text='<%# Bind("INVOICE_DUE_DATE") %>'
                                        runat="Server"
                                        onfocus='this.blur();'
                                        AutoPostBack="True" />
                                    <ajaxToolkit:CalendarExtender runat="server"
                                        ID="CalendarExtender1"
                                        Format="MM/dd/yyyy"
                                        PopupButtonID="ImageButton1"
                                        TargetControlID="txtInvoiceDueDate"></ajaxToolkit:CalendarExtender>
                                </td>

                                <td>
                                    <asp:ImageButton ID="ImageButton1" ImageUrl="~/images/_calendar.png" Width="30px" runat="server" /></td>
                            </tr>



                            <tr>
                                <td align="right"><b>Invoice Description:</b></td>

                                <td>
                                    <asp:TextBox ID="txtInvoiceDescription"
                                        Text='<%# Bind("INVOICE_DESCRIPTION") %>'
                                        runat="Server" /></td>

                            </tr>



                            <tr>
                                <td align="right"><b>Customer:</b></td>
                                <td>
                                    <asp:DropDownList ID="DropListCustomers" AppendDataBoundItems="true" required="required" runat="server" AutoPostBack="true" DataValueField="CUSTOMER" DataTextField="CUSTOMER" SelectedValue='<%# Bind("CUSTOMER") %>' DataSourceID="CustomerDataSource">
                                        <asp:ListItem Text="" Value=""></asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:Label ID="lblcustomerErrorMessage" runat="server" Text="" />
                                </td>
                                <asp:SqlDataSource ID="CustomerDataSource" runat="server"
                                    ConnectionString="<%$ ConnectionStrings:TrackInvoice %>"
                                    SelectCommand="SELECT [CUSTOMER] FROM inventory.CUSTOMERS"></asp:SqlDataSource>
                            </tr>

                            <tr>
                                <td align="right"><b>Invoice Status:</b></td>
                                <td>
                                    <asp:DropDownList ID="DropDownListInvoiceStatus" runat="server" SelectedValue='<%# Bind("INVOICE_STATUS") %>'>
                                        <asp:ListItem></asp:ListItem>
                                        <asp:ListItem>Outstanding</asp:ListItem>
                                        <asp:ListItem>Paid</asp:ListItem>
                                    </asp:DropDownList>
                                </td>
                            </tr>

                            <tr>

                                <td colspan="2">

                                    <asp:LinkButton ID="InsertButton"
                                        Text="Insert"
                                        CssClass="btnPrimary"
                                        CommandName="Insert"
                                        runat="server" />

                                    &nbsp;

                       

                                    <asp:LinkButton ID="CancelInsertButton"
                                        Text="Cancel"
                                        CssClass="btnPrimary"
                                        CommandName="Cancel"
                                        runat="server" />

                                </td>
                            </tr>
                        </table>
                    </InsertItemTemplate>
                    <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />

                </asp:FormView>
            </div>

            <div class="gridDiv">
                <div class="head">LIST OF INVOICE</div>
                <table>
                    <tr>

                        <td align="right"><b>Invoice Status:</b></td>
                        <td>
                            <asp:DropDownList ID="DropDownListInvoiceStatus" runat="server">
                                <asp:ListItem></asp:ListItem>
                                <asp:ListItem>Outstanding</asp:ListItem>
                                <asp:ListItem>Paid</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Button ID="btnsearch" runat="server" Text="Search" class="btn btn-primary btn-sm mb-3" OnClick="btn_SearchInvoiceByStatus_Click" /></td>

                    </tr>
                </table>


                <asp:GridView ID="gvInvoiceDetails"
                    runat="server"
                    AutoGenerateColumns="False"
                    CellPadding="1"
                    CellSpacing="1"
                    GridLines="None"
                    AllowPaging="True"
                    PageSize="4"
                    DataKeyNames="INVOICE_ID"
                    CssClass="table-bordered table-sm"
                    PagerStyle-CssClass="table pgr"
                    AlternatingRowStyle-CssClass="normal11"
                    Width="98%">

                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:HiddenField ID="hdInvoiceId" runat="server" Value='<%# Eval("INVOICE_ID")%>' />
                            </ItemTemplate>
                        </asp:TemplateField>


                        <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" DataField="INVOICE_ID" HeaderText="ID" />
                        <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" DataField="INVOICE_NUMBER" HeaderText="Invoice Number" />
                        <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" DataField="INVOICE_DATE" HeaderText="Invoice Date" />
                        <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" DataField="INVOICE_DUE_DATE" HeaderText="Invoice Due Date" />
                        <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" DataField="INVOICE_DESCRIPTION" HeaderText="Invoice Description" />
                        <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" DataField="CUSTOMER" HeaderText="Customer" />
                        <asp:BoundField ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left" DataField="INVOICE_STATUS" HeaderText="Invoice Status" />

                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="btnSelect" runat="server" ItemStyle-Width="1%" ControlStyle-CssClass="button" CommandName="Select" Text="Select" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>

                    <SelectedRowStyle BackColor="#fba557" Font-Bold="True" ForeColor="#ffffff" />

                    <EmptyDataTemplate>
                        <div style="color: red; text-align: center;">No Invoice Details Found !</div>
                    </EmptyDataTemplate>

                    <PagerStyle HorizontalAlign="Center" CssClass="GridPager" />
                </asp:GridView>
            </div>


            <asp:ModalPopupExtender ID="InsertInvoiceDetailsPopUp"
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
                                            <asp:Label ID="popUpMessage" runat="server" Text="" /></h2>
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
        </form>
    </div>
</body>

</html>
