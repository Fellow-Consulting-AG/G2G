package gadget.dao
{
	import flash.data.SQLConnection;

	public class ImpactManualTotalInput extends SimpleTable
	{
		public function ImpactManualTotalInput(sqlConnection:SQLConnection, workerFunction:Function) {
			super(sqlConnection, workerFunction, {
				table:"impactmanualtotalinput"
			});
		}
		
		
		protected override function getSpecial():Object{
			return {columns:{gadget_id: "INTEGER PRIMARY KEY AUTOINCREMENT"}};
		}
		
		public override function getColumns():Array{
			var cols:Array =  ["FYTarget"];
			for each(var q:String in OpportunityDAO.ALL_FY_QUATER){
				cols.push(q);
				for each(var m:String in OpportunityDAO.MONTH_FIELD_FOR_EACH_Q){
					cols.push(q+"_"+m);
				}
			}
			
			return cols;
		}
		override public function selectLastRecord():Object{
			var result:Object = super.selectLastRecord();
			if(result!=null){
				var obj:Object ={};
				for(var f:String in result){
					obj[f.replace("_",".")]=result[f];
				}
				return obj;
			}
			return null;
		}
		
		public function replaceRec(obj:Object):void{
			var lastRec:Object = selectLastRecord();
			if(lastRec==null){
				lastRec = new Object();
			}
			for each(var f:String in getColumns()){
				lastRec[f.replace(".","_")] = obj[f];
			}
			if(lastRec.hasOwnProperty('gadget_id')){
				update(lastRec,{'gadget_id':lastRec['gadget_id']});
			}else{
				insert(lastRec);
			}
		}
	}
}