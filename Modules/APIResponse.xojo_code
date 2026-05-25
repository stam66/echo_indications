#tag Module
Protected Module APIResponse
	#tag Method, Flags = &h0
		Sub WriteError(response As WebResponse, status As Integer, message As String)
		  response.Status = status
		  Var err As New JSONItem
		  err.Value("error") = message
		  err.Value("status") = status
		  response.Write(err.ToString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub WriteJSON(response As WebResponse, json As JSONItem, status As Integer = 200)
		  response.Status = status
		  response.Write(json.ToString)
		End Sub
	#tag EndMethod


End Module
#tag EndModule
