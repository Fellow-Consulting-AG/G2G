package gadget.dao
{
	import flash.data.SQLConnection;
	import flash.utils.Dictionary;

	public class BlockLayoutDAO extends SimpleTable
	{
		
		
		public function BlockLayoutDAO(sqlConnection:SQLConnection, work:Function) {
			super(sqlConnection, work, {
				table: 'block_layout',
				index: ["entity", "parent_field","parent_field_value","Name"],
				unique : ["entity, parent_field, parent_field_value,Name"],
				columns: { 'TEXT' : textColumns,'BOOLEAN':'isdefault'}
			});
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
		
		public function getAvailAbleName()
		
		private var textColumns:Array = [
			"entity", 
			"Name",
			"parent_field",
			"parent_field_value", 
			"subfields"
			
		];
		
	}
}