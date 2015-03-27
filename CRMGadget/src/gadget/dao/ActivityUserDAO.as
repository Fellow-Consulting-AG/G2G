package gadget.dao
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	
	import gadget.util.FieldUtils;
	
	import mx.collections.ArrayCollection;
	
	public class ActivityUserDAO extends SupportDAO implements ITeam {
/*		
		private var stmtInsert:SQLStatement;
		private var stmtDelete:SQLStatement;
		private var stmtSelect:SQLStatement;
*/		
		private var stmtUserSelect:SQLStatement;
		public function ActivityUserDAO(sqlConnection:SQLConnection, work:Function) {

			super(work, sqlConnection, {
				entity: [ 'Activity',   'User'   ],
				id:     [ 'ActivityId', 'UserId' ],
				columns: TEXTCOLUMNS
			},{
				oracle_id:"Id",
				unique:['ActivityId,UserId'],
				name_column:["UserAlias"],
				search_columns:["UserAlias"]
			});
			_isSyncWithParent = false;
			
			stmtUserSelect = new SQLStatement();
			stmtUserSelect.sqlConnection = sqlConnection;
			stmtUserSelect.text = "SELECT 'User' gadget_type, * FROM allusers WHERE Id in (SELECT UserId FROM activity_user WHERE ( deleted = 0 OR deleted IS null ) AND ActivityId = :ActivityId);";
			
			/*
			stmtInsert = new SQLStatement();
			stmtInsert.sqlConnection = sqlConnection;
			
			/* activityId is a gadget_id and userId is UserId /
			stmtInsert.text = "INSERT INTO activity_user (activityId, userId)" +
				" VALUES (:activityId, :userId)";
					
			stmtSelect = new SQLStatement();
			stmtSelect.sqlConnection = sqlConnection;
			
			stmtSelect.text = "SELECT * FROM activity_user au, allusers u" +
				" WHERE au.userId = u.UserId and au.activityId = :activityId ORDER BY u.uppername"; 
			
			stmtDelete = new SQLStatement();
			stmtDelete.sqlConnection = sqlConnection;
			stmtDelete.text = "DELETE FROM activity_user WHERE activityId = :activityId AND userId = :userId";
*/			
		}
		
		override public function fix_sync_incoming(rec:Object,parent:Object=null):Boolean { 
			if(parent!=null){
				rec['ActivityId']=parent['ActivityId'];
				rec['Subject']=parent['Subject'];
			}
			return true;
		}
/*		
		public function insert(activityUser:Object):void{
			stmtInsert.parameters[":activityId"] = activityUser.activityId;
			stmtInsert.parameters[":userId"] = activityUser.userId;
		    exec(stmtInsert);
		}
		
		public function delete_(activityUser:Object):void{
			stmtDelete.parameters[":activityId"] = activityUser.activityId;
			stmtDelete.parameters[":userId"] = activityUser.userId;
		    exec(stmtDelete);
		}
		
		public function select(activityId:String):ArrayCollection {
			stmtSelect.parameters[":activityId"] = activityId;
		    exec(stmtSelect);
			return new ArrayCollection(stmtSelect.getResult().data);
		}
*/
		override protected function getIncomingIgnoreFields():ArrayCollection{
			
			return new ArrayCollection(["ActivityId","Subject","EMailAddr","EMailAddr","Alias","FirstName","Role"]);
		}
		override protected function getOutgoingIgnoreFields():ArrayCollection{
			return new ArrayCollection([
				"ActivityId",	
				"Subject",
				"UserAlias","Alias",
				"UserEmail","EMailAddr",
				"UserExternalSystemId","ExternalSystemId",
				"UserFirstName","FirstName",
				"UserLastName","LastName",
				"UserRole","Role",
				
				"CreatedBy",
				"CreatedByAlias",
				"CreatedByEMailAddr",
				"CreatedByExternalSystemId",
				"CreatedByFirstName",
				"CreatedByFullName",
				"CreatedById",
				"CreatedByIntegrationId",
				"CreatedByLastName",
				"CreatedByUserSignInId",
				"CreatedDate",
				
				"ModId",
				"ModifiedBy",
				"ModifiedById",
				"ModifiedDate",
				
				"UpdatedByAlias",
				"UpdatedByEMailAddr",
				"UpdatedByExternalSystemId",
				"UpdatedByFirstName",
				"UpdatedByFullName",
				"UpdatedByIntegrationId",
				"UpdatedByLastName",
				"UpdatedByUserSignInId",
				
			]);
		}
		
		public override function findRelatedData(parentEntity:String , oracleId:String):ArrayCollection {
			stmtUserSelect.parameters[":ActivityId"]=oracleId;
			exec(stmtUserSelect);
			return new ArrayCollection(stmtUserSelect.getResult().data);
		}
		
		protected override function fieldList(updateFF:Boolean=true):ArrayCollection {
				return new ArrayCollection([
					{element_name:"ActivityId"},
					{element_name:"UserId"},
					{element_name:"UserFirstName"},
					{element_name:"UserLastName"},
					{element_name:"Id"},
					{element_name:"UserEmail"},
					{element_name:"UserRole"},
					{element_name:"UserAlias"}
				]);
		}
		
		private const TEXTCOLUMNS:Array = [
			ID("Id"),
			ID(".ActivityId"),				// Missing in WSDL
			PICK(".Subject","ActivityId"),	// Missing in WSDL
			PICK("UserAlias","UserId","Alias"),
			PICK("UserEmail","UserId","EMailAddr"),
			PICK("UserExternalSystemId","UserId","ExternalSystemId"),
			PICK("UserFirstName","UserId","FirstName"),
			PICK("UserLastName","UserId","LastName"),
			PICK("UserRole","UserId","Role"),

			"CreatedBy",
			"CreatedByAlias",
			"CreatedByEMailAddr",
			"CreatedByExternalSystemId",
			"CreatedByFirstName",
			"CreatedByFullName",
			"CreatedById",
			"CreatedByIntegrationId",
			"CreatedByLastName",
			"CreatedByUserSignInId",
			"CreatedDate",

			"ModId",
			"ModifiedBy",
			"ModifiedById",
			"ModifiedDate",

			"UpdatedByAlias",
			"UpdatedByEMailAddr",
			"UpdatedByExternalSystemId",
			"UpdatedByFirstName",
			"UpdatedByFullName",
			"UpdatedByIntegrationId",
			"UpdatedByLastName",
			"UpdatedByUserSignInId",
			];
	}
}