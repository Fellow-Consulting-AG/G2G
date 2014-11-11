package gadget.dao
{
	import flash.data.SQLConnection;
	
	public class OrderTemplateItem extends SimpleTable
	{
		public function OrderTemplateItem(sqlConnection:SQLConnection, work:Function)
		{
			super( sqlConnection, work, {
				table: 'order_template_item',
				oracle_id: 'Id',
				name_column: [ 'ItemName' ],
				search_columns: [ 'ItemId' ],
				display_name : "ItemName",
				unique:['Id'],								
				columns: {'TEXT' : textColumns,'INTEGER':["Qty"],'Id': "INTEGER PRIMARY KEY AUTOINCREMENT" }
			});
		}
		
		private var textColumns:Array = ["TemplateId",						
			"ItemNo",
			"ItemName"];
	}
}