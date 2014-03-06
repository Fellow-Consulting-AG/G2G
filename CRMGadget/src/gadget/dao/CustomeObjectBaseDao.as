package gadget.dao
{
	import flash.data.SQLConnection;
	
	public class CustomeObjectBaseDao extends BaseDAO
	{
		public function CustomeObjectBaseDao(work:Function, sqlConnection:SQLConnection, structure:Object)
		{
			super(work, sqlConnection, structure);
		}
		
		override public function getOwnerFields():Array{
			var mapfields:Array = [
				{entityField:"OwnerAlias", userField:"Alias"},{entityField:"OwnerId", userField:"Id"}
			];
			return mapfields;
			
		}
	}
}