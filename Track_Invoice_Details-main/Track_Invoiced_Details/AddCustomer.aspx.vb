Imports System.Data.SqlClient
Imports System.Drawing.Color
Public Class AddCustomer
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    Private Sub sb_Insert_Customer()
        Dim objCommand As New SqlCommand
        Dim mySqlAdapter As New SqlDataAdapter(objCommand)
        Dim strError As String
        Dim dbConnect As New Database

        If dbConnect.ConnectionSate = 0 Then
            dbConnect.Connect()
        End If

        If dbConnect.ConnectionSate > 0 Then
            objCommand.CommandType = CommandType.StoredProcedure
            objCommand.CommandText = "GUI_Insert_Customer"
            objCommand.Connection = dbConnect.Connection
            objCommand.Parameters.AddWithValue("@CUSTOMER", txtCustomerName.Text)

            Dim objOutputParameter As New SqlParameter("@ERROR_CODE", SqlDbType.NVarChar)
            objCommand.Parameters.Add(objOutputParameter)
            objOutputParameter.Direction = ParameterDirection.Output
            objOutputParameter.Size = 100

            objCommand.ExecuteNonQuery()
            strError = CStr(objCommand.Parameters("@ERROR_CODE").Value)

            If strError = "" Then
                lblMessage.ForeColor = Green
                lblMessage.Text = "Customer Added Successfully"
                AddCustomerPopUp.Show()
                hdError.Value = False

            Else
                AddCustomerPopUp.Show()
                lblMessage.Text = strError
                lblMessage.ForeColor = Red
                hdError.Value = True
            End If

        End If
        dbConnect.CloseConnectionToDB()
    End Sub

    Protected Sub btn_AddCustomer_Click()
        If txtCustomerName.Text = "" Then
            lblValidateMessage.ForeColor = Red
            lblValidateMessage.Text = "please enter a customer name"
        Else
            Call sb_Insert_Customer()
        End If
    End Sub

    Protected Sub btClose_Click()
        AddCustomerPopUp.Hide()
        If hdError.Value <> True Then
            Response.Redirect("Insert_Update_Delete_Invoice_Details.aspx")
        End If

    End Sub

End Class