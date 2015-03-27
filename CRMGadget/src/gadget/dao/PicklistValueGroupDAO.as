package gadget.dao
{
	import flash.data.SQLConnection;

	public class PicklistValueGroupDAO extends SimpleTable {
		
		public function PicklistValueGroupDAO(sqlConnection:SQLConnection, workerFunction:Function) {
			super(sqlConnection, workerFunction, {
				table:"picklist_value_group",				
				unique: [ 'PicklistValueGroupId, ObjectName, FieldName, LicName' ],
				index: [ 'PicklistValueGroupId, ObjectName, FieldName, LicName' ],
				columns: { 'TEXT' : getColumns()}
			});
			
		}
		
		override public function getColumns():Array {
			return [
				'ObjectName',	
				'PicklistValueGroupId',
				'PicklistValueGroupName',
				'FieldName',
				'LicName',
			];
		}
		
	}
}