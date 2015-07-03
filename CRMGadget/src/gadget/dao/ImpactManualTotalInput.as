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
				//cols.push(q);
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
				
				for each(var q:String in OpportunityDAO.ALL_FY_QUATER){
					var qObj:Object = {};
					obj[q]=  qObj;
					for each(var m:String in OpportunityDAO.MONTH_FIELD_FOR_EACH_Q){
						qObj[m]=result[q+"_"+m]
					}
					
				}
				obj.gadget_id = result['gadget_id'];
				obj.FYTarget = result.FYTarget;
				return obj;
			}
			return null;
		}
		
		public function replaceRec(obj:Object):void{
			var lastRec:Object = selectLastRecord();
			
			var saveRec:Object = new Object();
			saveRec.FYTarget = obj.FYTarget;
			if(lastRec!=null){
				saveRec.gadget_id = lastRec.gadget_id;
			}
			for each(var q:String in OpportunityDAO.ALL_FY_QUATER){
				var qObj:Object =obj[q];
				
				for each(var m:String in OpportunityDAO.MONTH_FIELD_FOR_EACH_Q){
					if(qObj){
						saveRec[q+"_"+m]=qObj[m];
					}else{
						saveRec[q+"_"+m]="0";
					}
				}
				
			}
			if(saveRec.hasOwnProperty('gadget_id')){
				update(saveRec,{'gadget_id':saveRec['gadget_id']});
			}else{
				insert(saveRec);
			}
		}
	}
}