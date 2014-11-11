package gadget.dao
{
	import flash.data.SQLConnection;
	
	public class OrderTemplate extends SimpleTable
	{
		public function OrderTemplate(sqlConnection:SQLConnection, work:Function)
		{
			super( sqlConnection, work, {
				table: 'oder_template',
				oracle_id: 'TemplateId',
				name_column: [ 'Name' ],
				search_columns: [ 'Name' ],
				display_name : "Name",
				unique:['TemplateId', "Name"],								
				columns: {'TEXT' : textColumns,"TemplateId":"INTEGER PRIMARY KEY AUTOINCREMENT" }
			});
		}
		
		
		private var textColumns:Array = [
			"Name",			
			"Description",
			"Area"];
	}
}