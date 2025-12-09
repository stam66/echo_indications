#tag Class
Protected Class Context
	#tag Method, Flags = &h0
		Shared Function GetAll(db As MySQLCommunityServer) As Context()
		  Var results() As Context
		  
		  Try
		    Var sql As String = "SELECT * FROM contexts ORDER BY sort_order, name"
		    Var rs As RowSet = db.SelectSQL(sql)
		    
		    While Not rs.AfterLastRow
		      Var ctx As New Context
		      ctx.ID = rs.Column("id").IntegerValue
		      ctx.Name = rs.Column("name").StringValue
		      ctx.Description = rs.Column("description").StringValue
		      ctx.SortOrder = rs.Column("sort_order").IntegerValue
		      
		      results.Add(ctx)
		      rs.MoveToNextRow
		    Wend
		    
		  Catch err As DatabaseException
		    System.DebugLog("Error loading contexts: " + err.Message)
		  End Try
		  
		  Return results
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Description As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ID As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Name As String
	#tag EndProperty

	#tag Property, Flags = &h0
		SortOrder As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SortOrder"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
