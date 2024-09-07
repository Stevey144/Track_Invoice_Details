Imports System.Drawing.Color
Imports System.Data.SqlClient

Public Class Insert_Update_Delete_Invoice_Details
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
            Call BindData()
            Call LoadInvoiceDetails_GridviewData()
            TrackInvoiceDetails_FormView.DataBind()
        End If
    End Sub


    Private Sub BindData()

        Dim dbConnect As New Database
        Dim strSQL As String
        If dbConnect.ConnectionSate = 0 Then
            dbConnect.Connect()
        End If


        strSQL = "SELECT INVOICE_ID"
        strSQL = strSQL + ", INVOICE_NUMBER"
        strSQL = strSQL + ", CONVERT(NVARCHAR(12),INVOICE_DATE, 109) INVOICE_DATE"
        strSQL = strSQL + ", CONVERT(NVARCHAR(12),INVOICE_DUE_DATE, 109) INVOICE_DUE_DATE"
        strSQL = strSQL + ", INVOICE_DESCRIPTION"
        strSQL = strSQL + ", CUSTOMER"
        strSQL = strSQL + ", INVOICE_STATUS"
        strSQL = strSQL + "  FROM inventory.TRACK_INVOICE_DETAILS(NOLOCK)"
        strSQL = strSQL + "  WHERE 1 = 1"


        Dim objCommand As SqlCommand = New SqlCommand()
        objCommand.CommandText = strSQL
        objCommand.CommandType = CommandType.Text
        objCommand.Connection = dbConnect.Connection

        Dim mySqlAdapter As SqlDataAdapter = New SqlDataAdapter(objCommand)
        Dim myDataSet As DataSet = New DataSet()
        mySqlAdapter.Fill(myDataSet)

        Dim dt As DataTable = New DataTable()
        mySqlAdapter.Fill(dt)
        TrackInvoiceDetails_FormView.DataSource = myDataSet
        TrackInvoiceDetails_FormView.DataBind()
        dbConnect.CloseConnectionToDB()
    End Sub

    Protected Sub LoadInvoiceDetails_GridviewData()
        Dim dbConnect As New Database
        Dim strSQL As String
        If dbConnect.ConnectionSate = 0 Then
            dbConnect.Connect()
        End If

        strSQL = "SELECT INVOICE_ID"
        strSQL = strSQL + ", INVOICE_NUMBER"
        strSQL = strSQL + ", CONVERT(NVARCHAR(12),INVOICE_DATE, 109) INVOICE_DATE"
        strSQL = strSQL + ", CONVERT(NVARCHAR(12),INVOICE_DUE_DATE, 109) INVOICE_DUE_DATE"
        strSQL = strSQL + ", INVOICE_DESCRIPTION"
        strSQL = strSQL + ", CUSTOMER"
        strSQL = strSQL + ", INVOICE_STATUS"
        strSQL = strSQL + "  FROM inventory.TRACK_INVOICE_DETAILS(NOLOCK)"
        strSQL = strSQL + "  WHERE 1 = 1"

        If DropDownListInvoiceStatus.SelectedItem.Text <> "" Then
            strSQL = strSQL + " AND INVOICE_STATUS = '" + DropDownListInvoiceStatus.SelectedItem.Text + "'"
        End If

        Dim objCommand As SqlCommand = New SqlCommand()
        objCommand.CommandText = strSQL
        objCommand.CommandType = CommandType.Text
        objCommand.Connection = dbConnect.Connection

        Dim mySqlAdapter As SqlDataAdapter = New SqlDataAdapter(objCommand)
        Dim myDataSet As DataSet = New DataSet()
        mySqlAdapter.Fill(myDataSet)

        Dim dt As DataTable = New DataTable()
        mySqlAdapter.Fill(dt)
        gvInvoiceDetails.DataSource = myDataSet
        gvInvoiceDetails.DataBind()
        dbConnect.CloseConnectionToDB()
    End Sub

    Protected Sub TrackInvoiceDetailsFormView_ItemInserting(sender As Object, e As FormViewInsertEventArgs) Handles TrackInvoiceDetails_FormView.ItemInserting
        Dim txtInvoiceNumber As TextBox = CType(TrackInvoiceDetails_FormView.FindControl("txtInvoiceNumber"), TextBox)
        Dim txtInvoiceDate As TextBox = CType(TrackInvoiceDetails_FormView.FindControl("txtInvoiceDate"), TextBox)
        Dim txtInvoiceDueDate As TextBox = CType(TrackInvoiceDetails_FormView.FindControl("txtInvoiceDueDate"), TextBox)
        Dim txtDescription As TextBox = CType(TrackInvoiceDetails_FormView.FindControl("txtInvoiceDescription"), TextBox)
        Dim DropdownCustomer As DropDownList = TryCast(TrackInvoiceDetails_FormView.FindControl("DropListCustomers"), DropDownList)
        Dim DropdownInvoiceStatus As DropDownList = TryCast(TrackInvoiceDetails_FormView.FindControl("DropDownListInvoiceStatus"), DropDownList)
        If DropdownCustomer.SelectedItem.Text = "" Then
            Dim lblcustomerErrorMessage = CType(TrackInvoiceDetails_FormView.FindControl("lblcustomerErrorMessage"), Label)
            lblcustomerErrorMessage.Text = "please select a customer, use the Add customer icon on the top left to populate dropdown"
            lblcustomerErrorMessage.ForeColor = Red

        ElseIf DropdownInvoiceStatus.SelectedItem.Text = "" Then

            lblMessage.Text = "Invoice status is required"
            lblMessage.ForeColor = Red

        Else

            Dim objCommand As New SqlCommand
            Dim mySqlAdapter As New SqlDataAdapter(objCommand)
            Dim strError As String
            Dim dbConnect As New Database

            If dbConnect.ConnectionSate = 0 Then
                dbConnect.Connect()
            End If

            If dbConnect.ConnectionSate > 0 Then
                objCommand.CommandType = CommandType.StoredProcedure
                objCommand.CommandText = "GUI_Insert_Update_Delete_Invoice_Details"
                objCommand.Connection = dbConnect.Connection
                objCommand.Parameters.AddWithValue("@OP", "I")
                objCommand.Parameters.AddWithValue("@INVOICE_ID", 0)
                objCommand.Parameters.AddWithValue("@INVOICE_NUMBER", txtInvoiceNumber.Text)
                objCommand.Parameters.AddWithValue("@INVOICE_DATE", If(txtInvoiceDate.Text <> "", txtInvoiceDate.Text, CObj(DBNull.Value)))
                objCommand.Parameters.AddWithValue("@INVOICE_DUE_DATE", If(txtInvoiceDueDate.Text <> "", txtInvoiceDueDate.Text, CObj(DBNull.Value)))
                objCommand.Parameters.AddWithValue("@INVOICE_DESCRIPTION", txtDescription.Text)
                objCommand.Parameters.AddWithValue("@CUSTOMER", DropdownCustomer.SelectedItem.Text)
                objCommand.Parameters.AddWithValue("@INVOICE_STATUS", DropdownInvoiceStatus.SelectedItem.Text)

                Dim objOutputParameter As New SqlParameter("@ERROR_CODE", SqlDbType.NVarChar)
                objCommand.Parameters.Add(objOutputParameter)
                objOutputParameter.Direction = ParameterDirection.Output
                objOutputParameter.Size = 100

                objCommand.ExecuteNonQuery()
                strError = CStr(objCommand.Parameters("@ERROR_CODE").Value)

                If strError = "" Then
                    popUpMessage.ForeColor = Green
                    InsertInvoiceDetailsPopUp.Show()
                    popUpMessage.Text = "Record Inserted Succesfully"
                End If

            End If
            dbConnect.CloseConnectionToDB()
        End If

    End Sub

    Protected Sub TrackInvoiceDetailsFormView_ItemInserted(sender As Object, e As FormViewInsertedEventArgs)
        TrackInvoiceDetails_FormView.ChangeMode(FormViewMode.[ReadOnly])

    End Sub

    Protected Sub TrackInvoiceDetailsFormView_ItemDeleting(sender As Object, e As FormViewDeleteEventArgs)
        Dim key As DataKey = TrackInvoiceDetails_FormView.DataKey
        Dim objCommand As New SqlCommand
        Dim mySqlAdapter As New SqlDataAdapter(objCommand)
        Dim strError As String
        Dim dbConnect As New Database

        TrackInvoiceDetails_FormView.ChangeMode(FormViewMode.ReadOnly)

        If dbConnect.ConnectionSate = 0 Then
            dbConnect.Connect()
        End If

        If dbConnect.ConnectionSate > 0 Then
            objCommand.CommandType = CommandType.StoredProcedure
            objCommand.CommandText = "GUI_Insert_Update_Delete_Invoice_Details"
            objCommand.Connection = dbConnect.Connection
            objCommand.Parameters.AddWithValue("@OP", "D")
            objCommand.Parameters.AddWithValue("@INVOICE_ID", key.Value.ToString())
            objCommand.Parameters.AddWithValue("@INVOICE_NUMBER", "")
            objCommand.Parameters.AddWithValue("@INVOICE_DATE", "")
            objCommand.Parameters.AddWithValue("@INVOICE_DUE_DATE", "")
            objCommand.Parameters.AddWithValue("@INVOICE_DESCRIPTION", "")
            objCommand.Parameters.AddWithValue("@CUSTOMER", "")
            objCommand.Parameters.AddWithValue("@INVOICE_STATUS", "")

            Dim objOutputParameter As New SqlParameter("@ERROR_CODE", SqlDbType.NVarChar)
            objCommand.Parameters.Add(objOutputParameter)
            objOutputParameter.Direction = ParameterDirection.Output
            objOutputParameter.Size = 100

            objCommand.ExecuteNonQuery()
            strError = CStr(objCommand.Parameters("@ERROR_CODE").Value)

            If strError = "" Then
                InsertInvoiceDetailsPopUp.Show()
                popUpMessage.ForeColor = Green
                popUpMessage.Text = "Record Deleted Successfully"

            End If

        End If
        dbConnect.CloseConnectionToDB()
    End Sub

    Protected Sub TrackInvoiceDetailsFormView_ModeChanging(sender As Object, e As FormViewModeEventArgs)
        TrackInvoiceDetails_FormView.ChangeMode(e.NewMode)
        Call BindData()

        If e.NewMode = FormViewMode.Edit Then
            TrackInvoiceDetails_FormView.AllowPaging = False
        Else
            TrackInvoiceDetails_FormView.AllowPaging = True
        End If

    End Sub

    Protected Sub TrackInvoiceDetailsFormView_ItemUpdated(sender As Object, e As FormViewUpdatedEventArgs)
        TrackInvoiceDetails_FormView.ChangeMode(FormViewMode.[ReadOnly])
    End Sub




    Protected Sub TrackInvoiceDetailsFormView_ItemUpdating(sender As Object, e As FormViewUpdateEventArgs)

        Dim key As DataKey = TrackInvoiceDetails_FormView.DataKey
        Dim txtInvoiceNumber As TextBox = CType(TrackInvoiceDetails_FormView.FindControl("txtInvoiceNumber"), TextBox)
        Dim txtInvoiceDate As TextBox = CType(TrackInvoiceDetails_FormView.FindControl("txtInvoiceDate"), TextBox)
        Dim txtInvoiceDueDate As TextBox = CType(TrackInvoiceDetails_FormView.FindControl("txtInvoiceDueDate"), TextBox)
        Dim txtDescription As TextBox = CType(TrackInvoiceDetails_FormView.FindControl("txtInvoiceDescription"), TextBox)
        Dim DropdownCustomer As DropDownList = TryCast(TrackInvoiceDetails_FormView.FindControl("DropListCustomers"), DropDownList)
        Dim DropdownInvoiceStatus As DropDownList = TryCast(TrackInvoiceDetails_FormView.FindControl("DropDownListInvoiceStatus"), DropDownList)

        Dim objCommand As New SqlCommand
        Dim mySqlAdapter As New SqlDataAdapter(objCommand)
        Dim strError As String
        Dim dbConnect As New Database

        If dbConnect.ConnectionSate = 0 Then
            dbConnect.Connect()
        End If

        If dbConnect.ConnectionSate > 0 Then

            objCommand.CommandType = CommandType.StoredProcedure
            objCommand.CommandText = "GUI_Insert_Update_Delete_Invoice_Details"
            objCommand.Connection = dbConnect.Connection
            objCommand.Parameters.AddWithValue("@OP", "M")
            objCommand.Parameters.AddWithValue("@INVOICE_ID", key.Value.ToString())
            objCommand.Parameters.AddWithValue("@INVOICE_NUMBER", txtInvoiceNumber.Text)
            objCommand.Parameters.AddWithValue("@INVOICE_DATE", If(txtInvoiceDate.Text <> "", txtInvoiceDate.Text, CObj(DBNull.Value)))
            objCommand.Parameters.AddWithValue("@INVOICE_DUE_DATE", If(txtInvoiceDueDate.Text <> "", txtInvoiceDueDate.Text, CObj(DBNull.Value)))
            objCommand.Parameters.AddWithValue("@INVOICE_DESCRIPTION", txtDescription.Text)
            objCommand.Parameters.AddWithValue("@CUSTOMER", DropdownCustomer.SelectedItem.Text)
            objCommand.Parameters.AddWithValue("@INVOICE_STATUS", DropdownInvoiceStatus.SelectedItem.Text)

            Dim objOutputParameter As New SqlParameter("@ERROR_CODE", SqlDbType.NVarChar)
            objCommand.Parameters.Add(objOutputParameter)
            objOutputParameter.Direction = ParameterDirection.Output
            objOutputParameter.Size = 100

            objCommand.ExecuteNonQuery()
            strError = CStr(objCommand.Parameters("@ERROR_CODE").Value)

            If strError = "" Then
                popUpMessage.ForeColor = Green
                InsertInvoiceDetailsPopUp.Show()
                popUpMessage.Text = "Record Updated Succesfully"
            End If

        End If
        dbConnect.CloseConnectionToDB()
    End Sub

    Protected Sub gvInvoiceDetails_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvInvoiceDetails.RowCommand

        If e.CommandName = "Select" Then

            TrackInvoiceDetails_FormView.ChangeMode(FormViewMode.Edit)

            Dim Index As Integer = (CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)).RowIndex
            Dim row As GridViewRow = gvInvoiceDetails.Rows(Index)

            Dim strIdInvoice As String = TryCast(row.FindControl("hdInvoiceId"), HiddenField).Value

            Dim dbConnect As New Database
            Dim strSQL As String
            If dbConnect.ConnectionSate = 0 Then
                dbConnect.Connect()
            End If

            strSQL = "SELECT INVOICE_ID"
            strSQL = strSQL + ", INVOICE_NUMBER"
            strSQL = strSQL + ", CONVERT(NVARCHAR(12),INVOICE_DATE, 109) INVOICE_DATE"
            strSQL = strSQL + ", CONVERT(NVARCHAR(12),INVOICE_DUE_DATE, 109) INVOICE_DUE_DATE"
            strSQL = strSQL + ", INVOICE_DESCRIPTION"
            strSQL = strSQL + ", CUSTOMER"
            strSQL = strSQL + ", INVOICE_STATUS"
            strSQL = strSQL + "  FROM inventory.TRACK_INVOICE_DETAILS(NOLOCK)"
            strSQL = strSQL + "  WHERE INVOICE_ID =" + "'" + strIdInvoice + "'" + ""

            Dim objCommand As SqlCommand = New SqlCommand()
            objCommand.CommandText = strSQL
            objCommand.CommandType = CommandType.Text
            objCommand.Connection = dbConnect.Connection

            Dim mySqlAdapter As SqlDataAdapter = New SqlDataAdapter(objCommand)
            Dim myDataSet As DataSet = New DataSet()
            mySqlAdapter.Fill(myDataSet)

            Dim dt As DataTable = New DataTable()
            mySqlAdapter.Fill(dt)
            TrackInvoiceDetails_FormView.DataSource = myDataSet
            TrackInvoiceDetails_FormView.DataBind()
            dbConnect.CloseConnectionToDB()

        End If

    End Sub

    Protected Sub TrackInvoiceDetails_FormView_DataBound(sender As Object, e As EventArgs) Handles TrackInvoiceDetails_FormView.DataBound
        If TrackInvoiceDetails_FormView.DataItemCount = 0 Then
            TrackInvoiceDetails_FormView.ChangeMode(FormViewMode.Insert)
        End If

        If TrackInvoiceDetails_FormView.CurrentMode = FormViewMode.Edit Then
            Dim DropdownCustomer As DropDownList = TryCast(TrackInvoiceDetails_FormView.FindControl("DropListCustomers"), DropDownList)
            Dim DropdownInvoiceStatus As DropDownList = TryCast(TrackInvoiceDetails_FormView.FindControl("DropDownListInvoiceStatus"), DropDownList)

            DropdownCustomer.SelectedItem.Text = DataBinder.Eval(TrackInvoiceDetails_FormView.DataItem, "CUSTOMER").ToString()
            DropdownCustomer.SelectedItem.Value = DataBinder.Eval(TrackInvoiceDetails_FormView.DataItem, "CUSTOMER").ToString()

            DropdownInvoiceStatus.SelectedItem.Text = DataBinder.Eval(TrackInvoiceDetails_FormView.DataItem, "INVOICE_STATUS").ToString()
            DropdownInvoiceStatus.SelectedItem.Value = DataBinder.Eval(TrackInvoiceDetails_FormView.DataItem, "INVOICE_STATUS").ToString()

        End If

    End Sub

    Protected Sub btn_SearchInvoiceByStatus_Click()
        Call LoadInvoiceDetails_GridviewData()
    End Sub

    Protected Sub AddCustomer_Click()
        Response.Redirect("AddCustomer.aspx")
    End Sub

    Protected Sub TrackInvoiceDetailsFormView_PageIndexChanging(sender As Object, e As FormViewPageEventArgs) Handles TrackInvoiceDetails_FormView.PageIndexChanging
        TrackInvoiceDetails_FormView.PageIndex = e.NewPageIndex
        Call BindData()
    End Sub

    Protected Sub TrackInvoiceDetails_FormView_PageIndexChanged(sender As Object, e As EventArgs) Handles TrackInvoiceDetails_FormView.PageIndexChanged
        TrackInvoiceDetails_FormView.DataBind()
        Dim ID As String = TrackInvoiceDetails_FormView.DataKey(0).ToString()
    End Sub

    Protected Sub gvInvoiceDetails_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles gvInvoiceDetails.PageIndexChanging
        gvInvoiceDetails.PageIndex = e.NewPageIndex
        Call LoadInvoiceDetails_GridviewData()
    End Sub

    Protected Sub btClose_Click()
        InsertInvoiceDetailsPopUp.Hide()
        Response.Redirect("Insert_Update_Delete_Invoice_Details.aspx")
    End Sub

End Class