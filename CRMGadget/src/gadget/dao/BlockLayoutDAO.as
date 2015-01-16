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
				index: ["entity", "parent_field","parent_field_value","Name"],
				unique : ["entity, parent_field, parent_field_value,Name"],
				columns: { 'TEXT' : textColumns,'BOOLEAN':'isdefault'}
			});
			
			stmtGetNameByEntity = new SQLStatement();
			stmtGetNameByEntity.sqlConnection = sqlConnection;
			stmtGetNameByEntity.text = "Select entity,parent_field,entity,Name from block_layout where entity=:entity group by Name";
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
		private var textColumns:Array = [
			"entity", 
			"Name",
			"parent_field",
			"parent_field_value", 
			"subfields"
			
		];
		
	}
}