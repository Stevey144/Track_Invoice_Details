Imports System.Data.SqlClient
Public Class Database
    Dim ConnectToDB As New SqlConnection
    Public ReadOnly Property Connection() As SqlConnection

        Get
            Return ConnectToDB

        End Get

    End Property

    Public ReadOnly Property ConnectionSate() As Integer

        Get

            Return ConnectToDB.State

        End Get

    End Property

    Public Function Connect()

        Try

            ConnectToDB.ConnectionString = fun_Get_ConnectionString()
            ConnectToDB.Open()

        Catch ex As Exception

            Return -1

            Exit Function

        End Try

        Return ConnectToDB

    End Function

    Public Function CloseConnectionToDB()

        Try
            If ConnectToDB.State = 1 Then

                ConnectToDB.Close()
                ConnectToDB.Dispose()
                SqlConnection.ClearPool(ConnectToDB)

            End If

            CloseConnectionToDB = 1

        Catch ex As Exception

            CloseConnectionToDB = -1

            Exit Function

        End Try

    End Function

    Public Function fun_Get_ConnectionString() As String

        Dim strConn As String = ConfigurationManager.ConnectionStrings("TrackInvoice").ConnectionString
        Return strConn
    End Function

End Class
