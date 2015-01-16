package gadget.dao
{
	import flash.data.SQLConnection;
	import flash.data.SQLStatement;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;

	public class BlockLayoutDAO extends SimpleTable
	{
		
		
		protected var stmtGetNameByEntity:SQLStatement;
		protected var stmtGetByField:SQLStatement;
		protected var stmtGetSubField:SQLStatement;
		protected var stmtGetallBlock:SQLStatement;
		public function BlockLayoutDAO(sqlConnection:SQLConnection, work:Function) {
			super(sqlConnection, work, {
				table: 'block_layout',
				index: ["entity", "parent_field","Name"],
				unique : ["entity, parent_field,Name"],
				columns: {gadget_id: "INTEGER PRIMARY KEY AUTOINCREMENT", 'TEXT' : textColumns}
			});
			
			stmtGetNameByEntity = new SQLStatement();
			stmtGetNameByEntity.sqlConnection = sqlConnection;
			stmtGetNameByEntity.text = "Select * from block_layout where entity=:entity group by Name";
		}
		
		
		public function getSubFields(entity:String,parent_field:String,parent_field_value:String):String{
			return null;
		}
		public function getAllBlock(entity:String):Dictionary{
			return null;
		}
		
		public function getBlockByField(entity:String,parentField:String):Dictionary{
			return null;
		}
		
		public function getAvailableName(entity:String):ArrayCollection{
			stmtGetNameByEntity.parameters[":entity"]=entity;
			exec(stmtGetNameByEntity);
			return new ArrayCollection(stmtGetNameByEntity.getResult().data);
		}
		
		public function getByGadgetId(gadget_id:String):Object{
			var result:Array = fetch({'gadget_id':gadget_id});
			if(result!=null && result.length>0){
				return result[0];
			}
			return null;
		}
		private var textColumns:Array = [
			"entity", 
			"Name",
			"parent_field"
		];
		
	}
}