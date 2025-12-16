#tag Module
Protected Module AuditTracker
	#tag Method, Flags = &h0
		Function LogCreate(tableName As String, primaryKey As Integer, username As String, newData As Dictionary) As Boolean
		  Var sql As String
		  Var newValuesJSON As String = GenerateJSON(newData)
		  
		  sql = "INSERT INTO audit (audit_user, audit_table, audit_primarykey, action, new_values) " + _
		  "VALUES (?, ?, ?, 'create', ?)"
		  
		  Try
		    Var ps As MySQLPreparedStatement = Session.DB.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    
		    ps.Bind(0, username)
		    ps.Bind(1, tableName)
		    ps.Bind(2, primaryKey)
		    ps.Bind(3, newValuesJSON)
		    
		    ps.ExecuteSQL
		    Return True
		    
		  Catch err As DatabaseException
		    System.DebugLog("Audit log error: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogDelete(tableName As String, primaryKey As Integer, username As String, oldData As Dictionary) As Boolean
		  Var sql As String
		  Var oldValuesJSON As String = GenerateJSON(oldData)
		  
		  sql = "INSERT INTO audit (audit_user, audit_table, audit_primarykey, action, old_values) " + _
		  "VALUES (?, ?, ?, 'delete', ?)"
		  
		  Try
		    Var ps As MySQLPreparedStatement = Session.DB.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    
		    ps.Bind(0, username)
		    ps.Bind(1, tableName)
		    ps.Bind(2, primaryKey)
		    ps.Bind(3, oldValuesJSON)
		    
		    ps.ExecuteSQL
		    Return True
		    
		  Catch err As DatabaseException
		    System.DebugLog("Audit log error: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function LogUpdate(tableName As String, primaryKey As Integer, username As String, oldData As Dictionary, newData As Dictionary) As Boolean
		  // Build list of changed fields
		  Var changedFields() As String
		  Var oldValues As New Dictionary
		  Var newValues As New Dictionary
		  
		  For Each key As Variant In newData.Keys
		    Var fieldName As String = key.StringValue
		    If oldData.HasKey(fieldName) Then
		      If oldData.Value(fieldName) <> newData.Value(fieldName) Then
		        changedFields.Add(fieldName)
		        oldValues.Value(fieldName) = oldData.Value(fieldName)
		        newValues.Value(fieldName) = newData.Value(fieldName)
		      End If
		    End If
		  Next
		  
		  // Only log if something actually changed
		  If changedFields.Count = 0 Then Return True
		  
		  Var sql As String = "INSERT INTO audit (audit_user, audit_table, audit_primarykey, action, " + _
		  "changed_fields, old_values, new_values) VALUES (?, ?, ?, 'update', ?, ?, ?)"
		  
		  Try
		    Var ps As MySQLPreparedStatement = Session.DB.Prepare(sql)
		    ps.BindType(0, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(1, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(2, MySQLPreparedStatement.MYSQL_TYPE_LONG)
		    ps.BindType(3, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(4, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    ps.BindType(5, MySQLPreparedStatement.MYSQL_TYPE_STRING)
		    
		    ps.Bind(0, username)
		    ps.Bind(1, tableName)
		    ps.Bind(2, primaryKey)
		    ps.Bind(3, String.FromArray(changedFields, ","))
		    ps.Bind(4, GenerateJSON(oldValues))
		    ps.Bind(5, GenerateJSON(newValues))
		    
		    ps.ExecuteSQL
		    Return True
		    
		  Catch err As DatabaseException
		    System.DebugLog("Audit log error: " + err.Message)
		    Return False
		  End Try
		End Function
	#tag EndMethod


End Module
#tag EndModule
