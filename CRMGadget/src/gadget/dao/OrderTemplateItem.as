package gadget.dao
{
	import flash.data.SQLConnection;
	
	public class OrderTemplateItem extends SimpleTable
	{
		public function OrderTemplateItem(sqlConnection:SQLConnection, work:Function)
		{
			super( sqlConnection, work, {
				table: 'order_template_item',
				oracle_id: 'gadget_id',
				name_column: [ 'ItemName' ],
				search_columns: [ 'ItemId' ],
				display_name : "ItemName",
				unique:['gadget_id'],								
				columns: {'TEXT' : textColumns,'INTEGER':["Qty"],'gadget_id': "INTEGER PRIMARY KEY AUTOINCREMENT" }
			});
		}
		
		private var textColumns:Array = ["TemplateId",	"TemplateName",					
			"ItemNo",
			"ItemName",
			"PlantId",
			"PlantName"
		];
	}
}